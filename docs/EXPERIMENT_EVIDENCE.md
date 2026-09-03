# Experiment Evidence Overview

This page is the high-level index for the repository evidence. Detailed galleries are split by migration mechanism so the README remains readable while the repository still preserves substantial proof that the experiments were executed.

## Detailed Evidence Pages

- [Level 1 application migration](evidence/LEVEL1_EVIDENCE.md)
- [Level 2 Docker/CRIU](evidence/LEVEL2_DOCKER_CRIU_EVIDENCE.md)
- [Native CRIU process migration](evidence/NATIVE_CRIU_EVIDENCE.md)
- [Telefork process migration](evidence/TELEFORK_EVIDENCE.md)
- [Established TCP + VIP](evidence/ESTABLISHED_TCP_VIP_EVIDENCE.md)

## Evidence Counts

- **Level 1 application migration:** 8 files
- **Level 2 Docker/CRIU:** 65 files
- **Native CRIU:** 25 files
- **Telefork:** 30 files
- **Established TCP + VIP:** 87 files

## Representative Summary Figures

### Level 1 application migration

![Level 1 application migration](figures/level1/level1_server_b_state_restored.png)

Server B continues using restored application state.

### Level 2 Docker/CRIU

![Level 2 Docker/CRIU](figures/level2/level2_n10_reliability_summary.png)

Final Docker repeated evaluation summary.

### Level 2 Docker/CRIU

![Level 2 Docker/CRIU](figures/level2/docker_n10_timing_2x2_final.png)

Docker n=10 timing analysis.

### Native CRIU

![Native CRIU](figures/level3-native-criu/level3_native_criu_summary.png)

Native CRIU final n=5 summary.

### Native CRIU

![Native CRIU](figures/level3-native-criu/native_criu_n5_timing_2x2.png)

Native CRIU timing analysis.

### Telefork

![Telefork](figures/telefork/telefork_final_n5_summary_5of5.png)

Telefork strict final n=5 summary.

### Telefork

![Telefork](figures/telefork/telefork_n5_per_run_timing.png)

Telefork per-run timing.

### Established TCP + VIP

![Established TCP + VIP](figures/established-tcp-vip/established_tcp_experimental_architecture.png)

Three-machine established TCP migration architecture.

### Established TCP + VIP

![Established TCP + VIP](figures/established-tcp-vip/final_n5_corrected_summary_5of5-1.png)

Final established TCP + VIP n=5 summary.

### Established TCP + VIP

![Established TCP + VIP](figures/established-tcp-vip/client_latency_comparison.png)

Client latency comparison.

