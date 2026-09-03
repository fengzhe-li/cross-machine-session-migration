#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "This command must be run with sudo/root." >&2
  exit 1
fi

CHECKPOINT_DIR="${CHECKPOINT_DIR:-logs/stage_b_checkpoint}"
RUNTIME_DIR="${RUNTIME_DIR:-logs/stage_b_runtime}"
RESTORE_LOG="${RESTORE_LOG:-restore.log}"
MOUNTS_FILE="${MOUNTS_FILE:-logs/stage_b_runtime_bind_mounts.txt}"
PORT="${PORT:-7004}"

if [ ! -f "$RUNTIME_DIR/manifest.txt" ]; then
  echo "Missing runtime manifest: $RUNTIME_DIR/manifest.txt" >&2
  exit 1
fi

if [ ! -d "$CHECKPOINT_DIR" ]; then
  echo "Missing checkpoint directory: $CHECKPOINT_DIR" >&2
  exit 1
fi

RUNTIME_ABS="$(cd "$RUNTIME_DIR" && pwd)"
CHECKPOINT_ABS="$(cd "$CHECKPOINT_DIR" && pwd)"
RESTORE_LOG_ABS="$CHECKPOINT_ABS/$RESTORE_LOG"

mkdir -p "$(dirname "$MOUNTS_FILE")"
: > "$MOUNTS_FILE"

cleanup_on_failure() {
  local status=$?
  if [ "$status" -ne 0 ]; then
    echo "Restore failed; removing runtime bind mounts."
    MOUNTS_FILE="$MOUNTS_FILE" "$(dirname "$0")/stage_b_unmount_runtime.sh" || true
  fi
  exit "$status"
}
trap cleanup_on_failure EXIT

echo "Installing source runtime files as target bind mounts..."
while IFS= read -r path; do
  [ -n "$path" ] || continue
  src="$RUNTIME_ABS/rootfs${path}"
  dest="$path"
  if [ ! -f "$src" ]; then
    echo "Missing packaged runtime file: $src" >&2
    exit 1
  fi
  if [ ! -e "$dest" ]; then
    mkdir -p "$(dirname "$dest")"
    touch "$dest"
  fi
  mount --bind "$src" "$dest"
  echo "$dest" >> "$MOUNTS_FILE"
done < "$RUNTIME_ABS/manifest.txt"

echo "Running CRIU restore with source runtime bind mounts..."

criu restore \
  -D "$CHECKPOINT_ABS" \
  -o "$RESTORE_LOG" \
  -v4 \
  --tcp-established \
  -d

echo "CRIU_RESTORE_WRAPPER_EXIT_CODE=0"
echo "Restore log: $RESTORE_LOG_ABS"
echo "Runtime bind mounts kept for restored process."
echo "Rollback when finished: sudo MOUNTS_FILE='$MOUNTS_FILE' ./stage_b_unmount_runtime.sh"

echo "Post-restore process check:"
pgrep -af tcp_session_server.py || true

echo "Post-restore socket check:"
ss -tnlp "sport = :$PORT or dport = :$PORT" || true

trap - EXIT
