#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

SOURCE_USER="${SOURCE_USER:-fengzhe}"
TARGET_USER="${TARGET_USER:-fengzhe}"
REMOTE_DIR="${REMOTE_DIR:-$HOME/tcp_established_cross_machine}"

FILES=(
  README_STAGE_A.md
  README_STAGE_B.md
  common.sh
  send_garp.py
  stage_a_claim_vip.sh
  stage_a_release_vip.sh
  stage_a_validate_vip.sh
  stage_b_lock_target.sh
  stage_b_migrate.sh
  stage_b_package_runtime.sh
  stage_b_restore_with_runtime.sh
  stage_b_start_server.sh
  stage_b_sync_to_target.sh
  stage_b_sync_to_vms_from_mac.sh
  stage_b_unlock_target.sh
  stage_b_unmount_runtime.sh
  tcp_session_server.py
  persistent_client.py
)

sync_one_host() {
  local user="$1"
  local ip="$2"
  local label="$3"

  echo "=== Syncing ${label}: ${user}@${ip}:${REMOTE_DIR} ==="
  cd "$SCRIPT_DIR"

  tar -czf - "${FILES[@]}" | ssh "${user}@${ip}" \
    "mkdir -p '${REMOTE_DIR}' && tar -xzf - -C '${REMOTE_DIR}' && chmod +x '${REMOTE_DIR}'/*.sh '${REMOTE_DIR}'/*.py"

  echo "=== Verifying ${label} files ==="
  ssh "${user}@${ip}" "
    set -e
    cd '${REMOTE_DIR}'
    for file in ${FILES[*]}; do
      test -f \"\$file\"
    done
    for file in *.sh *.py; do
      test -x \"\$file\"
    done
    for file in *.sh; do
      bash -n \"\$file\"
    done
    ls -l ${FILES[*]}
    echo ${label}_SYNC_OK
  "
}

missing=0
for file in "${FILES[@]}"; do
  if [ ! -f "$SCRIPT_DIR/$file" ]; then
    echo "ERROR: missing local file: $SCRIPT_DIR/$file" >&2
    missing=1
  fi
done

if [ "$missing" -ne 0 ]; then
  exit 1
fi

sync_one_host "$SOURCE_USER" "$SOURCE_IP" "SOURCE"
sync_one_host "$TARGET_USER" "$TARGET_IP" "TARGET"

echo "STAGE_B_VM_SYNC_COMPLETE"
