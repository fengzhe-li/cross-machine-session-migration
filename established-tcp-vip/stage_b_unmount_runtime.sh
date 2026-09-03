#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "This command must be run with sudo/root." >&2
  exit 1
fi

MOUNTS_FILE="${MOUNTS_FILE:-logs/stage_b_runtime_bind_mounts.txt}"

if [ ! -f "$MOUNTS_FILE" ]; then
  echo "No runtime bind mount list found: $MOUNTS_FILE"
  exit 0
fi

tac "$MOUNTS_FILE" | while IFS= read -r path; do
  [ -n "$path" ] || continue
  if findmnt -T "$path" >/dev/null 2>&1; then
    umount "$path" 2>/dev/null || true
  fi
done

rm -f "$MOUNTS_FILE"
echo "Runtime bind mounts removed."
