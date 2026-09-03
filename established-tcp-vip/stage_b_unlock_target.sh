#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

require_root
PORT="${PORT:-7004}"

while iptables -C INPUT -d "$VIP" -p tcp --dport "$PORT" -j DROP 2>/dev/null; do
  iptables -D INPUT -d "$VIP" -p tcp --dport "$PORT" -j DROP
done

while iptables -C OUTPUT -s "$VIP" -p tcp --sport "$PORT" -j DROP 2>/dev/null; do
  iptables -D OUTPUT -s "$VIP" -p tcp --sport "$PORT" -j DROP
done

echo "Target traffic unlocked for ${VIP}:${PORT}."
