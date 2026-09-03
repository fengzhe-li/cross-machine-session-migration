#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

PORT="${PORT:-7004}"
TARGET_USER="${TARGET_USER:-fengzhe}"
REMOTE_DIR="${REMOTE_DIR:-$HOME/tcp_established_cross_machine}"
LOG_DIR="${LOG_DIR:-$SCRIPT_DIR/logs}"
CHECKPOINT_DIR="$LOG_DIR/stage_b_checkpoint"
RUNTIME_DIR="$LOG_DIR/stage_b_runtime"
SSH_CONTROL_DIR="$LOG_DIR/ssh_control"

mkdir -p "$LOG_DIR"
rm -rf "$CHECKPOINT_DIR"
rm -rf "$RUNTIME_DIR"
mkdir -p "$CHECKPOINT_DIR"
mkdir -p "$SSH_CONTROL_DIR"
SSH_CONTROL_PATH="$SSH_CONTROL_DIR/%r@%h:%p"
SSH_OPTS=(
  -o ControlMaster=auto
  -o ControlPersist=10m
  -o ControlPath="$SSH_CONTROL_PATH"
)

TIMING_LOG="$LOG_DIR/stage_b_timing.csv"
if [ ! -f "$TIMING_LOG" ]; then
  echo "event,start_ns,end_ns,duration_ms,detail" > "$TIMING_LOG"
fi

record_timing() {
  local event="$1"
  local start="$2"
  local end="$3"
  local detail="$4"
  local ms=$(( (end - start) / 1000000 ))
  echo "${event},${start},${end},${ms},${detail}" >> "$TIMING_LOG"
  echo "${event}: ${ms} ms"
}

check_server_has_no_tty_fds() {
  local pid="$1"
  local bad=0

  for fd in 0 1 2; do
    target="$(readlink "/proc/${pid}/fd/${fd}" 2>/dev/null || true)"
    echo "SERVER_FD_${fd}=${target}"
    case "$target" in
      /dev/pts/*|/dev/tty*)
        bad=1
        ;;
    esac
  done

  if [ "$bad" -ne 0 ]; then
    echo "ERROR: server still has an interactive TTY fd." >&2
    echo "Start the server with ./stage_b_start_server.sh before running migration." >&2
    echo "This avoids checkpointing source pts state that cannot be inherited on target." >&2
    exit 1
  fi
}

ssh_tty() {
  ssh "${SSH_OPTS[@]}" -tt "${TARGET_USER}@${TARGET_IP}" "$@"
}

ssh_plain() {
  ssh "${SSH_OPTS[@]}" "${TARGET_USER}@${TARGET_IP}" "$@"
}

scp_to_target() {
  scp "${SSH_OPTS[@]}" "$@"
}

remote_sudo_phase() {
  local phase="$1"
  local command="$2"

  ssh_tty "
    set -e
    echo 'Verifying target sudo for phase: ${phase}'
    if ! sudo -v; then
      echo 'ERROR: target sudo authentication failed during phase: ${phase}' >&2
      exit 1
    fi
    if ! sudo -n true; then
      echo 'ERROR: target sudo is not available non-interactively after authentication during phase: ${phase}' >&2
      exit 1
    fi
    ${command}
  "
}

require_local_stage_b_files() {
  local files=(
    common.sh
    send_garp.py
    stage_a_claim_vip.sh
    stage_a_release_vip.sh
    stage_b_lock_target.sh
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
  local missing=0

  for file in "${files[@]}"; do
    if [ ! -f "$SCRIPT_DIR/$file" ]; then
      echo "ERROR: missing local Stage B file: $SCRIPT_DIR/$file" >&2
      missing=1
    fi
  done

  if [ "$missing" -ne 0 ]; then
    exit 1
  fi
}

validate_target_prerequisites() {
  ssh_plain "
    set -e
    cd '${REMOTE_DIR}'
    test -x ./stage_b_restore_with_runtime.sh
    test -x ./stage_b_lock_target.sh
    test -x ./stage_b_unlock_target.sh
    test -x ./stage_a_claim_vip.sh
    test -x ./stage_a_release_vip.sh
    test -x ./send_garp.py
    command -v criu >/dev/null
    command -v iptables >/dev/null
    command -v ip >/dev/null
    command -v python3 >/dev/null
    bash -n stage_b_restore_with_runtime.sh
    bash -n stage_b_lock_target.sh
    bash -n stage_b_unlock_target.sh
    echo TARGET_PREFLIGHT_OK
  "
}

cache_sudo_credentials() {
  echo "Caching source sudo credentials..."
  sudo -v

  echo "Checking target sudo availability..."
  remote_sudo_phase "initial_sudo_check" "echo TARGET_SUDO_OK"
}

echo "Stage B cross-machine established TCP migration"
echo "source=$(hostname) source_ip=${SOURCE_IP} target=${TARGET_USER}@${TARGET_IP}"
echo "vip=${VIP} port=${PORT} iface=${IFACE}"

require_local_stage_b_files

echo "Syncing current Stage B files to target..."
"$SCRIPT_DIR/stage_b_sync_to_target.sh"
validate_target_prerequisites
cache_sudo_credentials

if ! ip -o -4 addr show dev "$IFACE" | grep -q "${VIP}/${PREFIX}"; then
  echo "ERROR: VIP ${VIP}/${PREFIX} is not assigned on source ${IFACE}."
  echo "Run sudo ./stage_a_claim_vip.sh on source first."
  exit 1
fi

SERVER_PID="$(pgrep -f "tcp_session_server.py --host ${VIP} --port ${PORT}" | head -n 1 || true)"
if [ -z "$SERVER_PID" ]; then
  echo "ERROR: could not find server bound to ${VIP}:${PORT}."
  exit 1
fi

echo "SERVER_PID=$SERVER_PID"
check_server_has_no_tty_fds "$SERVER_PID"
ss -tinpo "sport = :$PORT or dport = :$PORT" > "$LOG_DIR/stage_b_ss_source_before_dump.txt" || true

echo "Packaging source runtime dependencies for CRIU restore..."
start=$(date +%s%N)
"$SCRIPT_DIR/stage_b_package_runtime.sh" "$SERVER_PID" "$RUNTIME_DIR"
end=$(date +%s%N)
record_timing "runtime_package" "$start" "$end" "pid=${SERVER_PID}"

echo "Preparing target directories and locking target traffic before VIP handover..."
start=$(date +%s%N)
remote_sudo_phase "target_prepare_and_lock" \
  "mkdir -p '${REMOTE_DIR}/logs' && sudo -n rm -rf '${REMOTE_DIR}/logs/stage_b_checkpoint' '${REMOTE_DIR}/logs/stage_b_runtime' && cd '${REMOTE_DIR}' && sudo -n env VIP='${VIP}' IFACE='${IFACE}' PORT='${PORT}' ./stage_b_lock_target.sh"
end=$(date +%s%N)
record_timing "target_prepare_and_lock" "$start" "$end" "remote_dir=${REMOTE_DIR};iptables_drop"

echo "Dumping source server with CRIU --tcp-established..."
start=$(date +%s%N)
sudo -n criu dump \
  -t "$SERVER_PID" \
  -D "$CHECKPOINT_DIR" \
  -o dump.log \
  -v4 \
  --tcp-established \
  --network-lock iptables
end=$(date +%s%N)
record_timing "dump" "$start" "$end" "pid=${SERVER_PID}"
echo "CRIU_DUMP_EXIT_CODE=0"

echo "Making checkpoint images readable for transfer..."
sudo -n chown -R "$USER:$USER" "$CHECKPOINT_DIR"

echo "Transferring checkpoint images to target..."
start=$(date +%s%N)
scp_to_target -r "$CHECKPOINT_DIR" "${TARGET_USER}@${TARGET_IP}:${REMOTE_DIR}/logs/"
end=$(date +%s%N)
record_timing "checkpoint_transfer" "$start" "$end" "scp"

echo "Transferring packaged source runtime dependencies to target..."
start=$(date +%s%N)
scp_to_target -r "$RUNTIME_DIR" "${TARGET_USER}@${TARGET_IP}:${REMOTE_DIR}/logs/"
end=$(date +%s%N)
record_timing "runtime_transfer" "$start" "$end" "scp_runtime"

echo "Moving VIP source -> target..."
start=$(date +%s%N)
sudo -n env VIP="$VIP" IFACE="$IFACE" ./stage_a_release_vip.sh
remote_sudo_phase "target_claim_vip" \
  "cd '${REMOTE_DIR}' && sudo -n env VIP='${VIP}' IFACE='${IFACE}' ./stage_a_claim_vip.sh"
end=$(date +%s%N)
record_timing "vip_handover" "$start" "$end" "source_release_target_claim"

echo "Preparing target backing files for restored open log descriptors..."
remote_sudo_phase "target_prepare_backing_files" \
  "cd '${REMOTE_DIR}' && mkdir -p logs && sudo -n rm -f logs/server_events.csv logs/server_diagnostics.log logs/server_stdout.log logs/server_stderr.log"
scp_to_target "$LOG_DIR/server_events.csv" "$LOG_DIR/server_diagnostics.log" "$LOG_DIR/server_stdout.log" "$LOG_DIR/server_stderr.log" \
  "${TARGET_USER}@${TARGET_IP}:${REMOTE_DIR}/logs/"

echo "Restoring process on target..."
start=$(date +%s%N)
if remote_sudo_phase "target_restore" "cd '${REMOTE_DIR}' && sudo -n ./stage_b_restore_with_runtime.sh"; then
  end=$(date +%s%N)
  record_timing "restore" "$start" "$end" "target_restore"
  echo "CRIU_RESTORE_EXIT_CODE=0"
  echo "CRIU restore succeeded on target."
else
  status=$?
  end=$(date +%s%N)
  record_timing "restore" "$start" "$end" "target_restore_failed_exit_${status}"
  echo "CRIU_RESTORE_EXIT_CODE=$status"
  echo "ERROR: CRIU restore failed on target. Stopping Stage B immediately."
  exit "$status"
fi

echo "Unlocking target traffic..."
start=$(date +%s%N)
remote_sudo_phase "target_unlock" \
  "cd '${REMOTE_DIR}' && sudo -n env VIP='${VIP}' IFACE='${IFACE}' PORT='${PORT}' ./stage_b_unlock_target.sh"
end=$(date +%s%N)
record_timing "target_unlock" "$start" "$end" "iptables_drop_removed"

echo "Collecting post-restore TCP state..."
ssh_plain \
  "cd '${REMOTE_DIR}' && ss -tinpo 'sport = :${PORT} or dport = :${PORT}' > logs/stage_b_ss_target_after_restore.txt || true"
ssh_plain \
  "cd '${REMOTE_DIR}' && pgrep -af tcp_session_server.py > logs/stage_b_restored_process.txt || true"

echo
echo "Stage B completed. Inspect source logs in: $LOG_DIR"
echo "Inspect target logs in: ${TARGET_USER}@${TARGET_IP}:${REMOTE_DIR}/logs"
