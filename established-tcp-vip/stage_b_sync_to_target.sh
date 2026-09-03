#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

TARGET_USER="${TARGET_USER:-fengzhe}"
REMOTE_DIR="${REMOTE_DIR:-$HOME/tcp_established_cross_machine}"
SSH_CONTROL_DIR="${SSH_CONTROL_DIR:-$SCRIPT_DIR/logs/ssh_control}"
mkdir -p "$SSH_CONTROL_DIR"

SSH_OPTS=(
  -o ControlMaster=auto
  -o ControlPersist=10m
  -o ControlPath="$SSH_CONTROL_DIR/%r@%h:%p"
)

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

cd "$SCRIPT_DIR"

missing=0
for file in "${FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "ERROR: missing local Stage B file: $file" >&2
    missing=1
  fi
done

if [ "$missing" -ne 0 ]; then
  exit 1
fi

echo "Syncing Stage B files to ${TARGET_USER}@${TARGET_IP}:${REMOTE_DIR}"
tar -czf - "${FILES[@]}" | ssh "${SSH_OPTS[@]}" "${TARGET_USER}@${TARGET_IP}" \
  "mkdir -p '${REMOTE_DIR}' && tar -xzf - -C '${REMOTE_DIR}' && chmod +x '${REMOTE_DIR}'/*.sh '${REMOTE_DIR}'/*.py"

echo "Verifying target Stage B files..."
ssh "${SSH_OPTS[@]}" "${TARGET_USER}@${TARGET_IP}" "
  set -e
  cd '${REMOTE_DIR}'
  for file in ${FILES[*]}; do
    test -f \"\$file\"
  done
  for file in *.sh *.py; do
    test -x \"\$file\"
  done
  bash -n stage_b_migrate.sh
  bash -n stage_b_restore_with_runtime.sh
  bash -n stage_b_start_server.sh
  bash -n stage_b_lock_target.sh
  bash -n stage_b_unlock_target.sh
  bash -n stage_b_package_runtime.sh
  bash -n stage_b_unmount_runtime.sh
  echo TARGET_STAGE_B_SYNC_OK
"
