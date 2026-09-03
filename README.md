# Cross-Machine Session Migration

This repository contains the implementation artefacts for an MSc dissertation project on session migration across application, container, and process levels.

The experiments are organised by migration depth:

- `level1-application-state/`: application-aware state transfer.
- `level2-docker-criu/`: Docker checkpoint/restore using CRIU.
- `level3-native-criu/`: native process migration with CRIU.
- `telefork/`: Telefork-based cross-machine process migration investigation.
- `established-tcp-vip/`: established TCP migration experiments using CRIU and a floating VIP.
- `experiments/`: supporting communication-continuity and validation experiments.
- `docs/`: architecture notes and dissertation-facing review material.

Large checkpoint images, VM images, logs, build caches, keys, environment files, and generated archives are intentionally excluded.
