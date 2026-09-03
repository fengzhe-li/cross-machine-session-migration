# Project Final Review

This review summarises the public repository after the final dissertation evidence curation pass. It is written as a requirements-to-evidence map rather than as a historical debugging diary.

## Supervisor-Aligned Objective

The project investigates session migration as two related problems:

1. **Computation migration:** moving application, container, or process execution state from one machine to another.
2. **Communication continuity:** keeping the client attached to a stable service endpoint, and in the strongest experiment preserving an already-established TCP session across migration.

The technical progression follows the original staged difficulty model:

- Level 1: application-aware migration.
- Level 2: Docker/container checkpoint and restore.
- Level 3: native process migration using CRIU and Telefork.
- Advanced communication continuity: proxy endpoint redirection and established TCP migration using CRIU plus a floating VIP.

## Current Completion Status

| Area | Status | Public evidence |
|---|---:|---|
| Level 1 application-managed migration | Completed | Source code and representative screenshots under `docs/figures/level1/`. |
| Level 2 Docker/CRIU migration | Completed | Docker scripts, result summary, n=10 figures, raw CSV screenshots, and timing plots. |
| Level 3 native CRIU process migration | Completed | Native CRIU scripts and n=5 evidence figures. |
| Telefork migration | Completed | Telefork source/example code and strict n=5 evidence figures. |
| Proxy endpoint redirection | Completed | Proxy experiment code and logged CSV/summary evidence. |
| Same-machine TCP-established validation | Completed | Validation scripts and representative evidence in the dissertation evidence set. |
| Cross-machine established TCP + VIP migration | Completed | Stage A/B scripts and final n=5 evidence figures. |

## Safe Dissertation Claims

The repository supports the following bounded claims:

- Application-managed state transfer preserves explicit application state, but requires application participation.
- Docker checkpoint/restore can preserve container runtime state and migrate a stateful TCP service, with repeated evaluation showing 8/10 successful migrations in the final dataset.
- Native CRIU can migrate a simple Linux process across machines with counter continuity, with 5/5 successful final runs.
- Telefork can migrate a process between compatible x86-64 Linux machines while preserving a simple runtime state value, with 5/5 strict final validation runs.
- Proxy-based endpoint redirection hides backend switching from the client but does not migrate an already-established TCP socket.
- CRIU `--tcp-established` with network locking and floating VIP handover can preserve an established client-visible TCP session in the tested VM environment, with 5/5 successful final runs.

## Important Claim Boundaries

- The Docker benchmark measures request availability and client-observed response gaps. It does not claim preservation of a single persistent client socket.
- The proxy experiment demonstrates transparent endpoint redirection, not kernel-level TCP socket migration.
- The established TCP + VIP experiment provides four-tuple continuity, session ID continuity, counter progress, and target restore evidence. Packet-level absence of a second SYN is not claimed unless packet capture evidence is separately available.
- Telefork compatibility is environment-sensitive; the final successful evaluation used compatible x86-64 source and target machines.
- Raw checkpoint image files and heavy generated artefacts are intentionally excluded from this public repository.

## Evidence Organisation

Detailed evidence is organised in:

- `docs/EXPERIMENT_EVIDENCE.md`
- `docs/FIGURE_INDEX.md`
- `docs/figures/level1/`
- `docs/figures/level2/`
- `docs/figures/level3-native-criu/`
- `docs/figures/telefork/`
- `docs/figures/established-tcp-vip/`

The public repository is therefore suitable as a curated implementation and evidence companion to the MSc dissertation, while the full raw VM logs and checkpoint images remain outside Git because of size, privacy, and reproducibility concerns.
