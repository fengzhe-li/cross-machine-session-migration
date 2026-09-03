#!/usr/bin/env bash
set -euo pipefail

TS=$(date +%s)

IMAGE="checkpoint-tcp-server"
SOURCE_CONTAINER="tcp-source-$TS"
TARGET_CONTAINER="tcp-target-$TS"
CHECKPOINT="tcp-cp-$TS"

BASE_DIR="$HOME/tcp-container-migration-$TS"
SERVER_A_DIR="$BASE_DIR/serverA"
SERVER_B_DIR="$BASE_DIR/serverB"

echo "===== TCP Docker Container Migration ====="
echo "Source container: $SOURCE_CONTAINER"
echo "Target container: $TARGET_CONTAINER"
echo "Checkpoint: $CHECKPOINT"
echo "Working directory: $BASE_DIR"

echo
echo "[0] Cleaning possible old TCP containers..."
sudo docker ps -aq --filter "name=tcp-source" | xargs -r sudo docker rm -f
sudo docker ps -aq --filter "name=tcp-target" | xargs -r sudo docker rm -f

echo
echo "[1] Preparing directories..."
mkdir -p "$SERVER_A_DIR" "$SERVER_B_DIR"

echo
echo "[2] Starting source TCP container..."
sudo docker run -d \
  --name "$SOURCE_CONTAINER" \
  --network host \
  --privileged \
  --security-opt seccomp=unconfined \
  "$IMAGE" >/dev/null

echo "[3] Waiting for source TCP server to run..."
sleep 6

echo
echo "===== Source Logs Before Checkpoint ====="
sudo docker logs --tail 10 "$SOURCE_CONTAINER"

echo
echo "[4] Creating checkpoint on source container..."
START=$(date +%s%N)
sudo docker checkpoint create "$SOURCE_CONTAINER" "$CHECKPOINT" >/dev/null
END=$(date +%s%N)
CHECKPOINT_MS=$(( (END - START) / 1000000 ))

echo "Checkpoint created: $CHECKPOINT"
echo "Checkpoint time: ${CHECKPOINT_MS} ms"

SOURCE_ID=$(sudo docker inspect -f '{{.Id}}' "$SOURCE_CONTAINER")
SOURCE_CHECKPOINT_PATH="/var/lib/docker/containers/$SOURCE_ID/checkpoints/$CHECKPOINT"

echo
echo "[5] Copying checkpoint to simulated Server A..."
START=$(date +%s%N)
sudo cp -a "$SOURCE_CHECKPOINT_PATH" "$SERVER_A_DIR/"
sudo chown -R "$USER:$USER" "$BASE_DIR"
END=$(date +%s%N)
COPY_TO_A_MS=$(( (END - START) / 1000000 ))

echo "Copied to: $SERVER_A_DIR/$CHECKPOINT"
echo "Copy-to-Server-A time: ${COPY_TO_A_MS} ms"
du -sh "$SERVER_A_DIR/$CHECKPOINT"

echo
echo "[6] Transferring checkpoint from Server A to Server B..."
START=$(date +%s%N)
cp -a "$SERVER_A_DIR/$CHECKPOINT" "$SERVER_B_DIR/"
END=$(date +%s%N)
TRANSFER_MS=$(( (END - START) / 1000000 ))

echo "Transferred to: $SERVER_B_DIR/$CHECKPOINT"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
du -sh "$SERVER_B_DIR/$CHECKPOINT"

echo
echo "[7] Creating target TCP container..."
sudo docker create \
  --name "$TARGET_CONTAINER" \
  --network host \
  --privileged \
  --security-opt seccomp=unconfined \
  "$IMAGE" >/dev/null

TARGET_ID=$(sudo docker inspect -f '{{.Id}}' "$TARGET_CONTAINER")
TARGET_CHECKPOINT_DIR="/var/lib/docker/containers/$TARGET_ID/checkpoints"

echo "Target container ID: $TARGET_ID"
echo "Target checkpoint directory: $TARGET_CHECKPOINT_DIR"

echo
echo "[8] Installing checkpoint into target container..."
sudo cp -a "$SERVER_B_DIR/$CHECKPOINT" "$TARGET_CHECKPOINT_DIR/"
sudo du -sh "$TARGET_CHECKPOINT_DIR/$CHECKPOINT"

echo
echo "[9] Restoring target TCP container from checkpoint..."
START=$(date +%s%N)
sudo docker start --checkpoint "$CHECKPOINT" "$TARGET_CONTAINER" >/dev/null
END=$(date +%s%N)
RESTORE_MS=$(( (END - START) / 1000000 ))

echo "Restore time: ${RESTORE_MS} ms"

echo
echo "[10] Waiting after restore..."
sleep 3

echo
echo "===== Target Logs After Restore ====="
sudo docker logs --tail 15 "$TARGET_CONTAINER"

echo
echo "===== TCP Migration Result ====="
echo "Checkpoint time: ${CHECKPOINT_MS} ms"
echo "Copy-to-Server-A time: ${COPY_TO_A_MS} ms"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
echo "Restore time: ${RESTORE_MS} ms"
echo
echo "The restored TCP server should now be available at:"
echo "192.168.64.2:7002"
echo
echo "Target container is left running for proxy testing."
