#!/usr/bin/env bash
set -euo pipefail

VIP="${VIP:-192.168.64.50}"
PREFIX="${PREFIX:-24}"
IFACE="${IFACE:-enp0s1}"
SOURCE_IP="${SOURCE_IP:-192.168.64.2}"
TARGET_IP="${TARGET_IP:-192.168.64.5}"
GARP_COUNT="${GARP_COUNT:-7}"

module_dir() {
  cd "$(dirname "${BASH_SOURCE[0]}")" && pwd
}

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This command must be run with sudo/root." >&2
    exit 1
  fi
}

iface_mac() {
  cat "/sys/class/net/${IFACE}/address"
}

has_vip() {
  ip -o -4 addr show dev "$IFACE" | grep -q "${VIP}/${PREFIX}"
}

add_vip() {
  if has_vip; then
    echo "VIP ${VIP}/${PREFIX} is already assigned to ${IFACE}."
  else
    ip addr add "${VIP}/${PREFIX}" dev "$IFACE"
    echo "Assigned VIP ${VIP}/${PREFIX} to ${IFACE}."
  fi
}

remove_vip() {
  if has_vip; then
    ip addr del "${VIP}/${PREFIX}" dev "$IFACE"
    echo "Removed VIP ${VIP}/${PREFIX} from ${IFACE}."
  else
    echo "VIP ${VIP}/${PREFIX} is not assigned to ${IFACE}."
  fi
}

send_garp() {
  local dir
  dir="$(module_dir)"

  if command -v arping >/dev/null 2>&1; then
    echo "Sending gratuitous ARP with arping for ${VIP} on ${IFACE}..."
    arping -A -c "$GARP_COUNT" -I "$IFACE" "$VIP" || true
    arping -U -c "$GARP_COUNT" -I "$IFACE" "$VIP" || true
  else
    echo "arping not found; using built-in raw-socket Gratuitous ARP sender."
    python3 "$dir/send_garp.py" --iface "$IFACE" --ip "$VIP" --count "$GARP_COUNT"
  fi
}

show_state() {
  echo "=== host ==="
  hostname
  echo
  echo "=== interface ==="
  ip -o link show "$IFACE"
  echo
  echo "=== IPv4 addresses ==="
  ip -o -4 addr show dev "$IFACE"
  echo
  echo "=== routes ==="
  ip route
  echo
  echo "=== VIP neighbour state ==="
  ip neigh show "$VIP" || true
}
