#!/usr/bin/env bash
set -euo pipefail

TS=$(date +%s)

IMAGE="checkpoint-counter"
SOURCE_CONTAINER="source-container-$TS"
TARGET_CONTAINER="target-container-$TS"
CHECKPOINT="cp-migrate-$TS"

BASE_DIR="$HOME/simulated-container-migration-$TS"
SERVER_A_DIR="$BASE_DIR/serverA"
SERVER_B_DIR="$BASE_DIR/serverB"

echo "===== Simulated Docker Container Migration ====="
echo "Source container: $SOURCE_CONTAINER"
echo "Target container: $TARGET_CONTAINER"
echo "Checkpoint: $CHECKPOINT"
echo "Working directory: $BASE_DIR"

echo
echo "[1] Preparing directories..."
mkdir -p "$SERVER_A_DIR" "$SERVER_B_DIR"

echo
echo "[2] Starting source container..."
sudo docker run -d \
  --name "$SOURCE_CONTAINER" \
  --network host \
  --privileged \
  --security-opt seccomp=unconfined \
  "$IMAGE" >/dev/null

echo "[3] Waiting for source container to run..."
sleep 10

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
echo "[5] Locating checkpoint files..."
echo "Source checkpoint path:"
echo "$SOURCE_CHECKPOINT_PATH"

echo
echo "[6] Copying checkpoint to simulated Server A..."
START=$(date +%s%N)
sudo cp -a "$SOURCE_CHECKPOINT_PATH" "$SERVER_A_DIR/"
sudo chown -R "$USER:$USER" "$BASE_DIR"
END=$(date +%s%N)
COPY_TO_A_MS=$(( (END - START) / 1000000 ))

echo "Copied to: $SERVER_A_DIR/$CHECKPOINT"
echo "Copy-to-Server-A time: ${COPY_TO_A_MS} ms"
du -sh "$SERVER_A_DIR/$CHECKPOINT"

echo
echo "[7] Transferring checkpoint from Server A to Server B..."
START=$(date +%s%N)
cp -a "$SERVER_A_DIR/$CHECKPOINT" "$SERVER_B_DIR/"
END=$(date +%s%N)
TRANSFER_MS=$(( (END - START) / 1000000 ))

echo "Transferred to: $SERVER_B_DIR/$CHECKPOINT"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
du -sh "$SERVER_B_DIR/$CHECKPOINT"

echo
echo "[8] Creating target container..."
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
echo "[9] Installing checkpoint into target container..."
sudo cp -a "$SERVER_B_DIR/$CHECKPOINT" "$TARGET_CHECKPOINT_DIR/"
sudo du -sh "$TARGET_CHECKPOINT_DIR/$CHECKPOINT"

echo
echo "[10] Restoring target container from checkpoint..."
START=$(date +%s%N)
sudo docker start --checkpoint "$CHECKPOINT" "$TARGET_CONTAINER" >/dev/null
END=$(date +%s%N)
RESTORE_MS=$(( (END - START) / 1000000 ))

echo "Restore time: ${RESTORE_MS} ms"

echo
echo "[11] Waiting after restore..."
sleep 3

echo
echo "===== Target Logs After Restore ====="
sudo docker logs --tail 20 "$TARGET_CONTAINER"

echo
echo "===== Migration Result ====="
echo "Checkpoint time: ${CHECKPOINT_MS} ms"
echo "Copy-to-Server-A time: ${COPY_TO_A_MS} ms"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
echo "Restore time: ${RESTORE_MS} ms"
echo
echo "If the target logs continue from the source counter value instead of restarting from 1,"
echo "the simulated Docker container migration preserved runtime state."

echo
echo "[12] Stopping target container..."
sudo docker stop "$TARGET_CONTAINER" >/dev/null

echo "Done."
