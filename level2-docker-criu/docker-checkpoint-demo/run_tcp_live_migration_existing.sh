#!/usr/bin/env bash
set -euo pipefail

echo "===== Level 2 Live Docker Container Migration ====="

SOURCE="tcp-live-source"
TARGET="tcp-live-target"
CHECKPOINT="live-cp-$(date +%s)"
WORKDIR="$HOME/live-container-migration-$CHECKPOINT"

echo "Source container: $SOURCE"
echo "Target container: $TARGET"
echo "Checkpoint: $CHECKPOINT"
echo "Working directory: $WORKDIR"

mkdir -p "$WORKDIR/serverA" "$WORKDIR/serverB"

echo
echo "[1] Checking source container..."
sudo docker ps | grep "$SOURCE"

echo
echo "[2] Source logs before checkpoint..."
sudo docker logs --tail 10 "$SOURCE"

echo
echo "[3] Sending request to source container before migration..."
python3 - <<'PY'
import socket

HOST = "127.0.0.1"
PORT = 7002

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    s.sendall(b"request_before_checkpoint")
    print(s.recv(1024).decode())
PY

echo
echo "[4] Creating checkpoint from running source container..."
START=$(date +%s%N)
sudo docker checkpoint create "$SOURCE" "$CHECKPOINT"
END=$(date +%s%N)
CHECKPOINT_MS=$(( (END - START) / 1000000 ))

echo "Checkpoint created: $CHECKPOINT"
echo "Checkpoint time: ${CHECKPOINT_MS} ms"

echo
echo "[5] Locating checkpoint files..."
SOURCE_ID=$(sudo docker inspect -f '{{.Id}}' "$SOURCE")
SOURCE_CP_PATH="/var/lib/docker/containers/$SOURCE_ID/checkpoints/$CHECKPOINT"

echo "Source checkpoint path:"
echo "$SOURCE_CP_PATH"

sudo du -sh "$SOURCE_CP_PATH"

echo
echo "[6] Copying checkpoint to simulated Server A..."
START=$(date +%s%N)
sudo cp -a "$SOURCE_CP_PATH" "$WORKDIR/serverA/"
sudo chown -R "$USER:$USER" "$WORKDIR"
END=$(date +%s%N)
COPY_A_MS=$(( (END - START) / 1000000 ))

echo "Copied to: $WORKDIR/serverA/$CHECKPOINT"
echo "Copy-to-Server-A time: ${COPY_A_MS} ms"
du -sh "$WORKDIR/serverA/$CHECKPOINT"

echo
echo "[7] Transferring checkpoint from Server A to Server B..."
START=$(date +%s%N)
cp -a "$WORKDIR/serverA/$CHECKPOINT" "$WORKDIR/serverB/"
END=$(date +%s%N)
TRANSFER_MS=$(( (END - START) / 1000000 ))

echo "Transferred to: $WORKDIR/serverB/$CHECKPOINT"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
du -sh "$WORKDIR/serverB/$CHECKPOINT"

echo
echo "[8] Creating target container..."
sudo docker rm -f "$TARGET" 2>/dev/null || true

sudo docker create \
  --name "$TARGET" \
  --network host \
  --privileged \
  --security-opt seccomp=unconfined \
  checkpoint-tcp-server

TARGET_ID=$(sudo docker inspect -f '{{.Id}}' "$TARGET")
TARGET_CP_DIR="/var/lib/docker/containers/$TARGET_ID/checkpoints"

echo "Target container ID: $TARGET_ID"
echo "Target checkpoint directory: $TARGET_CP_DIR"

echo
echo "[9] Installing checkpoint into target container..."
sudo mkdir -p "$TARGET_CP_DIR"
sudo cp -a "$WORKDIR/serverB/$CHECKPOINT" "$TARGET_CP_DIR/"
sudo du -sh "$TARGET_CP_DIR/$CHECKPOINT"

echo
echo "[10] Restoring target container from checkpoint..."
START=$(date +%s%N)
sudo docker start --checkpoint "$CHECKPOINT" "$TARGET"
END=$(date +%s%N)
RESTORE_MS=$(( (END - START) / 1000000 ))

echo "Restore time: ${RESTORE_MS} ms"

echo
echo "[11] Waiting after restore..."
sleep 3

echo
echo "===== Target logs after restore ====="
sudo docker logs --tail 10 "$TARGET"

echo
echo "[12] Sending request to restored target container after migration..."
python3 - <<'PY'
import socket

HOST = "127.0.0.1"
PORT = 7002

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    s.sendall(b"request_after_restore")
    print(s.recv(1024).decode())
PY

echo
echo "===== Level 2 Live Container Migration Result ====="
echo "Checkpoint time: ${CHECKPOINT_MS} ms"
echo "Copy-to-Server-A time: ${COPY_A_MS} ms"
echo "Simulated transfer time: ${TRANSFER_MS} ms"
echo "Restore time: ${RESTORE_MS} ms"
echo
echo "If the target logs and post-restore request continue from the source runtime counter,"
echo "then the Docker source container was checkpointed, transferred, restored, and continued running."
