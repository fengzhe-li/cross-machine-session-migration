# Stage A: Floating VIP and ARP Validation

This stage validates the service endpoint needed for cross-machine established
TCP migration.

Default configuration:

- Source VM: `192.168.64.2`
- Target VM: `192.168.64.5`
- Interface: `enp0s1`
- Floating VIP: `192.168.64.50/24`

## Goal

The VIP must move from `session-source` to `session-target`, and clients on the
same network must update their ARP/neighbour entry to the target NIC MAC.

## Commands

On source:

```bash
cd ~/tcp_established_cross_machine
sudo ./stage_a_claim_vip.sh
```

From Mac/client:

```bash
ping 192.168.64.50
arp -a | grep 192.168.64.50
```

On source:

```bash
sudo ./stage_a_release_vip.sh
```

On target:

```bash
cd ~/tcp_established_cross_machine
sudo ./stage_a_claim_vip.sh
```

From Mac/client:

```bash
ping 192.168.64.50
arp -a | grep 192.168.64.50
```

The ARP entry should change to the target NIC MAC.

## Gratuitous ARP

The claim script sends Gratuitous ARP announcements after assigning the VIP.
It prefers system `arping` if installed. If `arping` is unavailable, it uses the
included `send_garp.py` raw-socket implementation, so Stage A does not depend on
manual ARP cache clearing.

## Rollback

Run on both source and target if needed:

```bash
cd ~/tcp_established_cross_machine
sudo ./stage_a_release_vip.sh
```
