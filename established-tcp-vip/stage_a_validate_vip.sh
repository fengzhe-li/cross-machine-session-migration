#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

require_root

echo "Stage A VIP validation on $(hostname)"
echo "VIP=${VIP}/${PREFIX} IFACE=${IFACE}"
echo

show_state
echo

echo "Checking whether VIP is already assigned locally..."
if has_vip; then
  echo "VIP is currently assigned on this host."
else
  echo "VIP is not currently assigned on this host."
fi
echo

echo "Checking whether VIP responds before local claim..."
if ping -c 2 -W 1 "$VIP"; then
  echo "WARNING: ${VIP} responded to ping. It may already be in use."
else
  echo "No ping response from ${VIP}; it appears available from this host."
fi
