# Figure Index

| Figure file | Section / mechanism | What it shows | Why it matters |
|---|---|---|---|
| `docs/figures/level1/baseline_restart_counter_reset.png` | Level 1 | Baseline restart losing counter state | Establishes why restart is not migration. |
| `docs/figures/level1/level1_server_b_state_restored.png` | Level 1 | Server B restoring application state | Demonstrates application-managed state continuation. |
| `docs/figures/level1/level1_application_aware_migration_client_switch.png` | Level 1 | Client/application-aware switch | Shows the warm-up migration flow. |
| `docs/figures/level2/level2_docker_full_migration_workflow.png` | Level 2 Docker/CRIU | Full Docker migration workflow | Shows checkpoint, transfer, restore, and handover context. |
| `docs/figures/level2/level2_docker_checkpoint_transfer_restore_workflow.png` | Level 2 Docker/CRIU | Checkpoint-transfer-restore sequence | Distinguishes migration from restart. |
| `docs/figures/level2/level2_docker_checkpoint_restore_success.png` | Level 2 Docker/CRIU | Docker checkpoint/restore success | Confirms CRIU-backed container restore. |
| `docs/figures/level2/level2_docker_state_preservation_success.png` | Level 2 Docker/CRIU | Counter preservation | Supports runtime state preservation claim. |
| `docs/figures/level2/level2_live_migration_result.png` | Level 2 Docker/CRIU | Live migration terminal result | Representative successful execution evidence. |
| `docs/figures/level2/level2_integrated_client_continuity.png` | Level 2 Docker/CRIU | Client request continuity | Supports availability and interruption analysis. |
| `docs/figures/level2/level2_integrated_client_handover.png` | Level 2 Docker/CRIU | Client handover behaviour | Shows stable endpoint/proxy handover effect. |
| `docs/figures/level2/level2_experiment_summary.png` | Level 2 Docker/CRIU | Experiment summary | Captures high-level result evidence. |
| `docs/figures/level2/level2_n10_reliability_summary.png` | Level 2 Docker/CRIU | n=10 reliability summary | Documents 8/10 final repeated-trial result. |
| `docs/figures/level2/level2_n10_failure_and_raw_evidence.png` | Level 2 Docker/CRIU | Failure and raw evidence | Shows failed trials were retained. |
| `docs/figures/level2/level2_n10_raw_csv_evidence.png` | Level 2 Docker/CRIU | Raw CSV evidence | Supports auditability of statistics. |
| `docs/figures/level2/docker_n10_timing_2x2_final.pdf` | Level 2 Docker/CRIU | Timing plot PDF | Dissertation-quality timing analysis. |
| `docs/figures/level2/docker_n10_timing_2x2_final.png` | Level 2 Docker/CRIU | Timing plot preview | GitHub-friendly preview of timing analysis. |
| `docs/figures/level2/level2_statistical_summary.png` | Level 2 Docker/CRIU | Statistical summary | Summarises successful-run metrics. |
| `docs/figures/level3-native-criu/native_criu_cross_machine_continuity_evidence.png` | Native CRIU | Cross-machine continuity | Shows process migration evidence outside Docker. |
| `docs/figures/level3-native-criu/level3_criu_cross_machine_counter_continuity_success.png` | Native CRIU | Counter continuity | Demonstrates state preservation. |
| `docs/figures/level3-native-criu/level3_native_criu_summary.png` | Native CRIU | Final n=5 summary | Documents 5/5 final result. |
| `docs/figures/level3-native-criu/level3_native_criu_raw_csv.png` | Native CRIU | Raw CSV evidence | Supports statistics traceability. |
| `docs/figures/level3-native-criu/native_criu_n5_timing_2x2.pdf` | Native CRIU | Timing plot PDF | Records phase/timing analysis. |
| `docs/figures/level3-native-criu/native_criu_n5_timing_2x2.png` | Native CRIU | Timing plot preview | GitHub-friendly timing figure. |
| `docs/figures/telefork/telefork_cross_machine_migration_success.png` | Telefork | Cross-machine migration success | Shows Telefork execution path works. |
| `docs/figures/telefork/telefork_cross_machine_target_execution_and_state_preservation.png` | Telefork | Target execution and state preservation | Confirms migrated process runs on target. |
| `docs/figures/telefork/telefork_benchmark_with_target_runtime_evidence.png` | Telefork | Benchmark/runtime evidence | Connects benchmark output to target execution. |
| `docs/figures/telefork/telefork_manual_validation_source.png` | Telefork | Source validation evidence | Shows source-side validation output. |
| `docs/figures/telefork/telefork_manual_validation_target.png` | Telefork | Target validation evidence | Shows target-side validation output. |
| `docs/figures/telefork/telefork_cross_machine_benchmark_10_runs_summary.png` | Telefork | Earlier 10-run benchmark summary | Shows repeated benchmark context. |
| `docs/figures/telefork/telefork_final_n5_summary_5of5.png` | Telefork | Final strict n=5 summary | Documents final 5/5 result. |
| `docs/figures/telefork/telefork_n5_per_run_timing.png` | Telefork | Per-run timing | Supports migration timing analysis. |
| `docs/figures/established-tcp-vip/established_tcp_experimental_architecture.png` | Established TCP + VIP | Final topology | Shows Mac client, source, target, and VIP. |
| `docs/figures/established-tcp-vip/clean_validation_migration_success.png` | Established TCP + VIP | Clean validation success | Shows end-to-end validation before final evaluation. |
| `docs/figures/established-tcp-vip/clean_validation_pre_migration_four_tuple.png` | Established TCP + VIP | Pre-migration TCP four-tuple | Supports transport endpoint continuity. |
| `docs/figures/established-tcp-vip/clean_validation_target_post_migration.png` | Established TCP + VIP | Target state after migration | Confirms restored target server/socket. |
| `docs/figures/established-tcp-vip/clean_validation_post_migration_four_tuple.png` | Established TCP + VIP | Post-migration TCP four-tuple | Shows same client-visible endpoint. |
| `docs/figures/established-tcp-vip/cross_machine_tcp_same_session_counter_continuity.png` | Established TCP + VIP | Same session/counter continuity | Shows application session did not restart. |
| `docs/figures/established-tcp-vip/cross_machine_tcp_session_continuity_and_timing.png` | Established TCP + VIP | Session continuity and timing | Links continuity to measured migration phases. |
| `docs/figures/established-tcp-vip/final_n5_corrected_summary_5of5-1.png` | Established TCP + VIP | Final n=5 summary part 1 | Documents repeated-trial success. |
| `docs/figures/established-tcp-vip/final_n5_corrected_summary_5of5-2.png` | Established TCP + VIP | Final n=5 summary part 2 | Continues final dataset evidence. |
| `docs/figures/established-tcp-vip/final_n5_client_peak_latency.png` | Established TCP + VIP | Client peak latency | Shows client-observed disruption. |
| `docs/figures/established-tcp-vip/client_latency_comparison.pdf` | Established TCP + VIP | Client latency comparison PDF | Dissertation-quality latency plot. |
| `docs/figures/established-tcp-vip/client_latency_comparison.png` | Established TCP + VIP | Client latency comparison preview | GitHub-friendly latency figure. |
| `docs/figures/established-tcp-vip/established_tcp_vip_phase_timing_clean.pdf` | Established TCP + VIP | Phase timing PDF | Shows migration phase timing breakdown. |
| `docs/figures/established-tcp-vip/established_tcp_vip_phase_timing_clean.png` | Established TCP + VIP | Phase timing preview | GitHub-friendly phase timing figure. |
