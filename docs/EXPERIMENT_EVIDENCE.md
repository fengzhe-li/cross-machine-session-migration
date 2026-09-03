# Experiment Evidence

This document summarises the curated evidence included in the repository. It distinguishes representative demonstrations from repeated final evaluations, so the public repository reflects both how each mechanism works and what was actually measured.

## Level 1: Application-Managed Migration

Level 1 demonstrates the warm-up case where the application is aware of migration. The service explicitly serialises its state and starts another server instance using the transferred state. This level proves the basic idea of computation migration, but it is intentionally less transparent than the later Docker, CRIU, and Telefork experiments.

![Baseline restart loses state](figures/level1/baseline_restart_counter_reset.png)

This figure shows why a naive restart is not migration: the counter state is reset rather than preserved.

![Server B restores application state](figures/level1/level1_server_b_state_restored.png)

This figure shows Server B continuing from restored state. It supports the claim that Level 1 application-aware migration works, while also showing that the application itself participates in the migration protocol.

![Application-aware client switch](figures/level1/level1_application_aware_migration_client_switch.png)

This is representative demonstration evidence rather than repeated final evaluation. Level 1 is used as the conceptual warm-up in the dissertation.

## Level 2: Docker/CRIU Container Migration

Level 2 migrates a Dockerised stateful TCP service using Docker checkpoint/restore with CRIU underneath. The research object at this level is the container runtime rather than the application code. The service is checkpointed, checkpoint state is transferred, and the container is restored on the target side.

![Docker checkpoint transfer restore workflow](figures/level2/level2_docker_checkpoint_transfer_restore_workflow.png)

This figure shows the checkpoint-transfer-restore workflow and supports the claim that the experiment goes beyond simply stopping and restarting a container.

![Docker state preservation success](figures/level2/level2_docker_state_preservation_success.png)

This figure demonstrates counter/state preservation across container restore.

![Integrated client continuity](figures/level2/level2_integrated_client_continuity.png)

This figure shows the client-facing availability experiment. At Level 2, the client logger measures request availability and response gaps. It does not claim preservation of one established TCP socket; that stronger transport-level question is evaluated separately in the established TCP + VIP experiment.

![Docker n=10 reliability summary](figures/level2/level2_n10_reliability_summary.png)

The final repeated evaluation contains 10 attempted Docker migrations. The dissertation reports 8 successful migrations out of 10 attempts, keeping failed checkpoint attempts in the dataset.

![Docker n=10 raw CSV evidence](figures/level2/level2_n10_raw_csv_evidence.png)

This figure supports reproducibility and auditability: the reported statistics are derived from raw per-run evidence rather than a single selected demonstration.

Additional timing plots are included as [docker_n10_timing_2x2_final.pdf](figures/level2/docker_n10_timing_2x2_final.pdf) and the PNG preview below.

![Docker n=10 timing plot](figures/level2/docker_n10_timing_2x2_final.png)

## Level 3: Native CRIU Process Migration

The native CRIU experiment removes Docker from the stack and migrates a Linux process directly. This is a closer match to the supervisor's process-level migration challenge: the unit of migration is the process and its runtime state rather than a whole container.

![Native CRIU cross-machine continuity](figures/level3-native-criu/native_criu_cross_machine_continuity_evidence.png)

This figure shows cross-machine migration evidence and counter continuity after restore.

![CRIU counter continuity success](figures/level3-native-criu/level3_criu_cross_machine_counter_continuity_success.png)

This representative run supports the process-state preservation claim.

![Native CRIU final summary](figures/level3-native-criu/level3_native_criu_summary.png)

The final repeated native CRIU evaluation produced 5 successful runs out of 5. The summary and raw CSV evidence distinguish implementation success from benchmark reporting.

![Native CRIU raw CSV](figures/level3-native-criu/level3_native_criu_raw_csv.png)

Timing evidence is also available as [native_criu_n5_timing_2x2.pdf](figures/level3-native-criu/native_criu_n5_timing_2x2.pdf).

## Telefork

Telefork is evaluated as an alternative process migration route. The experiment focuses on whether a process can resume on a different x86-64 Linux machine with observable application state preserved. The repository includes the Telefork code used in the experiment and the dissertation evidence around it.

![Telefork cross-machine migration success](figures/telefork/telefork_cross_machine_migration_success.png)

This figure shows the basic cross-machine migration success path.

![Telefork target execution and state preservation](figures/telefork/telefork_cross_machine_target_execution_and_state_preservation.png)

This figure shows target-side execution evidence, supporting the claim that the migrated process resumed on the target.

![Telefork final n=5 summary](figures/telefork/telefork_final_n5_summary_5of5.png)

The strict final validation produced 5 successful runs out of 5. The final success definition required matching run evidence and state continuity, not just a zero exit code.

![Telefork per-run timing](figures/telefork/telefork_n5_per_run_timing.png)

The per-run timing figure supports the reported Telefork migration timing analysis.

## Established TCP + VIP

This experiment addresses the strongest communication-continuity question in the project. An independent Mac client opens one TCP connection to a stable floating service IP, while the server process migrates from source to target using CRIU `--tcp-established`. The VIP is moved from source to target and gratuitous ARP is used to update neighbour state.

![Established TCP experimental architecture](figures/established-tcp-vip/established_tcp_experimental_architecture.png)

This architecture figure shows the three-machine topology: independent client, source VM, and target VM.

![Pre-migration four tuple](figures/established-tcp-vip/clean_validation_pre_migration_four_tuple.png)

This figure shows the client-side TCP four-tuple before migration.

![Target post-migration state](figures/established-tcp-vip/clean_validation_target_post_migration.png)

This figure shows the target-side restored server after migration.

![Post-migration four tuple](figures/established-tcp-vip/clean_validation_post_migration_four_tuple.png)

This figure shows that the client still observes the same service endpoint after migration.

![Same session and counter continuity](figures/established-tcp-vip/cross_machine_tcp_same_session_counter_continuity.png)

This figure supports the application-level continuity claim: the same session ID is preserved and the counter continues rather than restarting.

![Established TCP final n=5 summary](figures/established-tcp-vip/final_n5_corrected_summary_5of5-1.png)

The final repeated evaluation produced 5 successful established-TCP migrations out of 5. The success definition required VIP handover evidence, restored target process/socket evidence, same session identity, and strict post-migration counter progress.

![Established TCP final n=5 continued summary](figures/established-tcp-vip/final_n5_corrected_summary_5of5-2.png)

Client-side latency evidence is included as [client_latency_comparison.pdf](figures/established-tcp-vip/client_latency_comparison.pdf), with a PNG preview below.

![Client latency comparison](figures/established-tcp-vip/client_latency_comparison.png)

Phase timing evidence is included as [established_tcp_vip_phase_timing_clean.pdf](figures/established-tcp-vip/established_tcp_vip_phase_timing_clean.pdf).
