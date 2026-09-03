#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

HOST="${HOST:-192.168.64.2}"
PORT="${PORT:-7004}"
LOG_DIR="$ROOT_DIR/logs"
CHECKPOINT_DIR="$LOG_DIR/checkpoint"

mkdir -p "$LOG_DIR"
rm -rf "$CHECKPOINT_DIR"
rm -f "$LOG_DIR"/*.csv "$LOG_DIR"/*.log "$LOG_DIR"/*.txt "$LOG_DIR"/*.pcap
mkdir -p "$CHECKPOINT_DIR"

cleanup() {
  for pid in ${SERVER_PID:-} ${CLIENT_PID:-} ${TCPDUMP_PID:-}; do
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null || true
    fi
  done
}
trap cleanup EXIT

echo "timestamp,event,start_timestamp,end_timestamp,duration_ms" > "$LOG_DIR/timing.csv"

echo "Starting TCP session server on ${HOST}:${PORT}..."
python3 tcp_session_server.py \
  --host "$HOST" \
  --port "$PORT" \
  --log "$LOG_DIR/server_events.csv" \
  --diag-log "$LOG_DIR/server_diagnostics.log" > "$LOG_DIR/server_stdout.log" 2>&1 &
SERVER_PID=$!

sleep 1

echo "Starting persistent client. It opens exactly one TCP connection."
python3 persistent_client.py \
  --host "$HOST" \
  --port "$PORT" \
  --interval 0.5 \
  --timeout 30 \
  --log "$LOG_DIR/client.csv" > "$LOG_DIR/client_stdout.log" 2>&1 &
CLIENT_PID=$!

sleep 3

echo "Recording TCP state before dump..."
ss -tnp "sport = :$PORT or dport = :$PORT" > "$LOG_DIR/ss_before.txt" || true

if command -v tcpdump >/dev/null 2>&1; then
  echo "Starting optional tcpdump capture..."
  sudo tcpdump -i enp0s1 host "$HOST" and port "$PORT" -w "$LOG_DIR/tcpdump.pcap" > "$LOG_DIR/tcpdump.log" 2>&1 &
  TCPDUMP_PID=$!
  sleep 1
fi

SERVER_PID="$(pgrep -f "tcp_session_server.py --host $HOST --port $PORT" | head -n 1)"
if [ -z "$SERVER_PID" ]; then
  echo "Could not find tcp_session_server.py PID."
  exit 1
fi

echo "Dumping server PID ${SERVER_PID} with CRIU --tcp-established..."
sudo -v
DUMP_START=$(date +%s%N)
sudo criu dump \
  -t "$SERVER_PID" \
  -D "$CHECKPOINT_DIR" \
  -o "$LOG_DIR/dump.log" \
  -v4 \
  --shell-job \
  --tcp-established
DUMP_END=$(date +%s%N)
DUMP_MS=$(( (DUMP_END - DUMP_START) / 1000000 ))
echo "$(date +%s.%N),DUMP,$DUMP_START,$DUMP_END,$DUMP_MS" >> "$LOG_DIR/timing.csv"

echo "Restoring server on the same machine..."
RESTORE_START=$(date +%s%N)
sudo criu restore \
  -D "$CHECKPOINT_DIR" \
  -o "$LOG_DIR/restore.log" \
  -v4 \
  --shell-job \
  --tcp-established \
  -d
RESTORE_END=$(date +%s%N)
RESTORE_MS=$(( (RESTORE_END - RESTORE_START) / 1000000 ))
echo "$(date +%s.%N),RESTORE,$RESTORE_START,$RESTORE_END,$RESTORE_MS" >> "$LOG_DIR/timing.csv"

sleep 5

echo "Recording TCP state after restore..."
ss -tnp "sport = :$PORT or dport = :$PORT" > "$LOG_DIR/ss_after_restore.txt" || true

if [ -n "${TCPDUMP_PID:-}" ] && kill -0 "$TCPDUMP_PID" 2>/dev/null; then
  sudo kill "$TCPDUMP_PID" 2>/dev/null || true
  wait "$TCPDUMP_PID" 2>/dev/null || true
fi

if kill -0 "$CLIENT_PID" 2>/dev/null; then
  kill "$CLIENT_PID" 2>/dev/null || true
  wait "$CLIENT_PID" 2>/dev/null || true
else
  wait "$CLIENT_PID" || true
fi

python3 analyze_result.py \
  --client-log "$LOG_DIR/client.csv" \
  --timing-log "$LOG_DIR/timing.csv" \
  --summary "$LOG_DIR/summary.txt"

echo
echo "Experiment logs written to: $LOG_DIR"
