#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

mkdir -p logs
rm -f logs/*.csv logs/*.txt

cat > backend_state.json <<'JSON'
{
  "active_backend": "serverA",
  "backends": {
    "serverA": {
      "host": "127.0.0.1",
      "port": 9101
    },
    "serverB": {
      "host": "127.0.0.1",
      "port": 9102
    }
  }
}
JSON

cleanup() {
  for pid in ${SERVER_A_PID:-} ${SERVER_B_PID:-} ${PROXY_PID:-} ${CLIENT_PID:-}; do
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null || true
    fi
  done
}
trap cleanup EXIT

echo "Starting Server A..."
python3 demo_server.py --name serverA --port 9101 > logs/serverA.log 2>&1 &
SERVER_A_PID=$!

echo "Starting Server B..."
python3 demo_server.py --name serverB --port 9102 > logs/serverB.log 2>&1 &
SERVER_B_PID=$!

sleep 1

echo "Starting proxy on stable endpoint 127.0.0.1:9000..."
python3 proxy.py --listen-port 9000 --config backend_state.json --log logs/proxy.csv > logs/proxy.log 2>&1 &
PROXY_PID=$!

sleep 1

echo "Starting client. The client will only connect to 127.0.0.1:9000."
python3 client_test.py \
  --host 127.0.0.1 \
  --port 9000 \
  --duration 12 \
  --interval 0.25 \
  --log logs/client.csv > logs/client_stdout.log 2>&1 &
CLIENT_PID=$!

sleep 5

echo "Triggering backend switch: Server A -> Server B"
python3 switch_backend.py serverB --config backend_state.json --log logs/switch_events.csv

wait "$CLIENT_PID"

python3 analyze_results.py \
  --client-log logs/client.csv \
  --switch-log logs/switch_events.csv \
  --summary logs/summary.txt

echo
echo "Logs written to: $ROOT_DIR/logs"
