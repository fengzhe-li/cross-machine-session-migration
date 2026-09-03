#!/usr/bin/env bash
set -euo pipefail

TS=$(date +%s)
CONTAINER="checkpoint-auto-$TS"
IMAGE="checkpoint-counter"
CHECKPOINT="cp-$TS"

echo "===== Docker Checkpoint/Restore Automated Test ====="
echo "Container: $CONTAINER"
echo "Checkpoint: $CHECKPOINT"

echo
echo "[1] Starting container..."
sudo docker run -d \
  --name "$CONTAINER" \
  --network host \
  --privileged \
  --security-opt seccomp=unconfined \
  "$IMAGE" >/dev/null

echo "[2] Waiting for counter to run..."
sleep 10

echo
echo "===== Before Checkpoint ====="
sudo docker logs --tail 10 "$CONTAINER"

echo
echo "[3] Creating checkpoint..."
START=$(date +%s%N)
sudo docker checkpoint create "$CONTAINER" "$CHECKPOINT" >/dev/null
END=$(date +%s%N)
CHECKPOINT_MS=$(( (END - START) / 1000000 ))

echo "Checkpoint name: $CHECKPOINT"
echo "Checkpoint time: ${CHECKPOINT_MS} ms"

echo
echo "[4] Checking checkpoint list..."
sudo docker checkpoint ls "$CONTAINER"

# Record how many log lines existed before restore
LOG_LINES_BEFORE_RESTORE=$(sudo docker logs "$CONTAINER" 2>/dev/null | wc -l)

echo
echo "[5] Restoring from checkpoint..."
START=$(date +%s%N)
sudo docker start --checkpoint "$CHECKPOINT" "$CONTAINER" >/dev/null
END=$(date +%s%N)
RESTORE_MS=$(( (END - START) / 1000000 ))

echo "Restore time: ${RESTORE_MS} ms"

echo
echo "[6] Waiting after restore..."
sleep 3

echo
echo "===== New Logs After Restore Only ====="
sudo docker logs "$CONTAINER" 2>/dev/null | tail -n +$((LOG_LINES_BEFORE_RESTORE + 1))

echo
echo "===== Full Tail Log ====="
sudo docker logs --tail 20 "$CONTAINER"

echo
echo "===== Result ====="
echo "If the new logs after restore continue from the previous counter value instead of restarting from 1, Docker checkpoint/restore preserved runtime state."
echo "Checkpoint time: ${CHECKPOINT_MS} ms"
echo "Restore time: ${RESTORE_MS} ms"

echo
echo "[7] Stopping container..."
sudo docker stop "$CONTAINER" >/dev/null

echo "Done."
