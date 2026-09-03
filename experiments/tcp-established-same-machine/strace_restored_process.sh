#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="${LOG_DIR:-logs}"
PORT="${PORT:-7004}"
PID="${1:-}"

mkdir -p "$LOG_DIR"

if [ -z "$PID" ]; then
  PID="$(pgrep -f "tcp_session_server.py --host .* --port ${PORT}" | head -n 1 || true)"
fi

if [ -z "$PID" ]; then
  echo "No tcp_session_server.py process found for port ${PORT}."
  exit 1
fi

echo "Attaching strace to PID $PID. Output: $LOG_DIR/strace_restored.log"
sudo strace -tt -f -p "$PID" \
  -e trace=signal,process,exit_group,kill,tkill,tgkill,close,shutdown \
  -o "$LOG_DIR/strace_restored.log"
