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
  echo "No tcp_session_server.py process found for port ${PORT}." | tee "$LOG_DIR/process_monitor.txt"
  exit 1
fi

{
  echo "timestamp=$(date +%s.%N)"
  echo "pid=$PID"
  echo
  echo "=== ps metadata ==="
  ps -o pid,ppid,pgid,sid,stat,tty,wchan:32,etime,cmd -p "$PID" || true
  echo
  echo "=== /proc/$PID/status ==="
  cat "/proc/$PID/status" || true
  echo
  echo "=== /proc/$PID/wchan ==="
  cat "/proc/$PID/wchan" || true
  echo
  echo
  echo "=== file descriptors ==="
  ls -l "/proc/$PID/fd" || true
  echo
  echo "=== TCP sockets ==="
  ss -tinpo "sport = :$PORT or dport = :$PORT" || true
} > "$LOG_DIR/process_monitor.txt"

cat "$LOG_DIR/process_monitor.txt"
