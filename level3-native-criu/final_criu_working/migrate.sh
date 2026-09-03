#!/bin/bash

set -e
TARGET_USER="fengzhe"
TARGET_HOST="192.168.64.5"
TARGET_DIR="${TARGET_DIR:-$HOME/docker-checkpoint-demo/level3}"
CHECKPOINT_DIR="checkpoint"
PROCESS_NAME="counter_process.py"

PID=$(pgrep -f "$PROCESS_NAME" | head -n 1)

if [ -z "$PID" ]; then
    echo "Error: $PROCESS_NAME is not running."
    exit 1
fi

echo "Found process PID: $PID"

rm -rf "$CHECKPOINT_DIR"
mkdir -p "$CHECKPOINT_DIR"

echo "Authenticating sudo..."
sudo -v
echo "Creating CRIU checkpoint..."

START_TIME=$(date +%s%N)

sudo criu dump \
    -t "$PID" \
    -D "$CHECKPOINT_DIR" \
    --shell-job

DUMP_END_TIME=$(date +%s%N)

echo "Checkpoint created. Source process should now be stopped."

echo "Removing old checkpoint on target..."

ssh "${TARGET_USER}@${TARGET_HOST}" \
    "rm -rf '${TARGET_DIR}/${CHECKPOINT_DIR}'"

echo "Transferring checkpoint to target..."

scp -r "$CHECKPOINT_DIR" \
    "${TARGET_USER}@${TARGET_HOST}:${TARGET_DIR}/"

TRANSFER_END_TIME=$(date +%s%N)

DUMP_MS=$(( (DUMP_END_TIME - START_TIME) / 1000000 ))
TRANSFER_MS=$(( (TRANSFER_END_TIME - DUMP_END_TIME) / 1000000 ))
TOTAL_MS=$(( (TRANSFER_END_TIME - START_TIME) / 1000000 ))

echo
echo "Migration preparation completed."
echo "Dump time: ${DUMP_MS} ms"
echo "Transfer time: ${TRANSFER_MS} ms"
echo "Dump + transfer time: ${TOTAL_MS} ms"
echo

echo "Starting restore on target..."

ssh -t "${TARGET_USER}@${TARGET_HOST}" \
    "cd ${TARGET_DIR} && ./restore_background.sh"

echo
echo "Restore command sent."

