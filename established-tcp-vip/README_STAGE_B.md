# Stage B: Cross-Machine CRIU Established TCP Migration Test

Stage B performs the first staged cross-machine migration attempt:

1. Source owns VIP `192.168.64.50`.
2. Server binds to `192.168.64.50:7004` on source.
3. A persistent client connects to the VIP.
4. Source dumps the server with CRIU `--tcp-established`.
5. Checkpoint images are copied to target.
6. VIP is moved from source to target using Stage A scripts.
7. Target restores the process with CRIU `--tcp-established`.
8. Target TCP/process state is collected.

Stage B does not optimize the final long-running experiment. It validates the
cross-machine mechanics.

## Source setup

```bash
cd ~/tcp_established_cross_machine
sudo ./stage_a_claim_vip.sh

./stage_b_start_server.sh
```

## Client setup

Run from a client host that can reach the VIP:

```bash
cd ~/tcp_established_cross_machine
python3 persistent_client.py \
  --host 192.168.64.50 \
  --port 7004 \
  --interval 0.5 \
  --timeout 60 \
  --log logs/client.csv
```

## Migration command on source

```bash
cd ~/tcp_established_cross_machine
./stage_b_migrate.sh
```

`stage_b_migrate.sh` synchronizes the current Stage B scripts to the target
before locking target traffic, dumping the source server, transferring checkpoint
images, moving the VIP, and running CRIU restore.

## Rollback

Run on source and target:

```bash
cd ~/tcp_established_cross_machine
sudo ./stage_a_release_vip.sh
sudo ./stage_b_unlock_target.sh
pkill -f tcp_session_server.py || true
```
