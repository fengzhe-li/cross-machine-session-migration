#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

require_root

echo "Claiming VIP ${VIP}/${PREFIX} on $(hostname) interface ${IFACE}"
add_vip
send_garp
show_state
