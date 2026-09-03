#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

require_root
PORT="${PORT:-7004}"

iptables -C INPUT -d "$VIP" -p tcp --dport "$PORT" -j DROP 2>/dev/null || \
  iptables -I INPUT -d "$VIP" -p tcp --dport "$PORT" -j DROP
iptables -C OUTPUT -s "$VIP" -p tcp --sport "$PORT" -j DROP 2>/dev/null || \
  iptables -I OUTPUT -s "$VIP" -p tcp --sport "$PORT" -j DROP

echo "Target traffic locked for ${VIP}:${PORT}."
