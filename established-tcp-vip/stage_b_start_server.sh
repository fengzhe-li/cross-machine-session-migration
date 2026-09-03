#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

PORT="${PORT:-7004}"
LOG_DIR="${LOG_DIR:-$SCRIPT_DIR/logs}"
EVENT_LOG="$LOG_DIR/server_events.csv"
DIAG_LOG="$LOG_DIR/server_diagnostics.log"
STDOUT_LOG="$LOG_DIR/server_stdout.log"
STDERR_LOG="$LOG_DIR/server_stderr.log"
PID_FILE="$LOG_DIR/stage_b_server.pid"

mkdir -p "$LOG_DIR"

if ! ip -o -4 addr show dev "$IFACE" | grep -q "${VIP}/${PREFIX}"; then
  echo "ERROR: VIP ${VIP}/${PREFIX} is not assigned on source ${IFACE}." >&2
  echo "Run sudo ./stage_a_claim_vip.sh first." >&2
  exit 1
fi

if pgrep -f "tcp_session_server.py --host ${VIP} --port ${PORT}" >/dev/null; then
  echo "ERROR: server for ${VIP}:${PORT} already appears to be running." >&2
  pgrep -af "tcp_session_server.py --host ${VIP} --port ${PORT}" >&2
  exit 1
fi

echo "Starting Stage B server detached from the interactive terminal..."
setsid python3 "$SCRIPT_DIR/tcp_session_server.py" \
  --host "$VIP" \
  --port "$PORT" \
  --log "$EVENT_LOG" \
  --diag-log "$DIAG_LOG" \
  </dev/null >>"$STDOUT_LOG" 2>>"$STDERR_LOG" &

SERVER_PID=$!
echo "$SERVER_PID" > "$PID_FILE"
sleep 1

if ! kill -0 "$SERVER_PID" 2>/dev/null; then
  echo "ERROR: detached server exited during startup." >&2
  echo "stderr: $STDERR_LOG" >&2
  exit 1
fi

echo "SERVER_PID=$SERVER_PID"
echo "PID file: $PID_FILE"
echo "stdout: $STDOUT_LOG"
echo "stderr: $STDERR_LOG"
echo "events: $EVENT_LOG"
echo "diagnostics: $DIAG_LOG"
ss -tnlp "sport = :$PORT or dport = :$PORT" || true
