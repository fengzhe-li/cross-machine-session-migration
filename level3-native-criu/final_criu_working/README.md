# Level 3 - Cross-Machine Process Migration using CRIU

## Project Overview

This project demonstrates Linux process migration between two Ubuntu virtual
machines using CRIU (Checkpoint/Restore In Userspace).

The experiment checkpoints a running Python process on the source machine,
transfers the checkpoint images to a target machine, and restores the process
there so that execution continues from the previous state.

The restored process keeps the in-memory counter value instead of restarting
from zero.

---

## Environment

Source VM:
- session-source

Target VM:
- session-target

Operating System:
- Ubuntu Linux (ARM64)

Migration Tool:
- CRIU

Remote Communication:
- SSH
- SCP

Background Restore:
- tmux

---

## Files

counter_process.py
- Test application.
- Prints an increasing counter every second.

migrate.sh
- Creates the checkpoint.
- Transfers checkpoint files.
- Automatically starts restoration on the target machine.

restore.sh
- Interactive foreground restore.

restore_background.sh
- Starts CRIU restore inside a detached tmux session.

checkpoint/
- Stores CRIU checkpoint images.

---

## Migration Workflow

1. Start counter_process.py on the source machine.
2. Run migrate.sh.
3. CRIU checkpoints the running process.
4. Checkpoint images are copied to the target machine.
5. SSH automatically invokes restore_background.sh.
6. CRIU restores the process on the target machine.
7. The restored process continues from the previous counter value.

---

## Performance Metrics

The migration script reports:

- Dump time
- Transfer time
- Dump + Transfer time
- Restore launch time

Typical experimental result:

- Dump: about 40 ms
- Transfer: about 440 ms
- Total: about 480 ms

---

## Current Progress

Completed:

- Application-level migration (Warm-up)
- Docker container migration
- CRIU checkpoint and restore
- Cross-machine process migration
- Automatic checkpoint transfer
- Automatic remote restore

Future Work:

- Transparent client redirection
- Telefork comparison
- Migration latency evaluation

