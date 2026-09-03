# Established TCP + VIP Evidence

The established TCP + VIP experiment is the strongest communication-continuity experiment. An independent Mac client keeps one connection to a floating VIP while the server process migrates from source to target using CRIU TCP-established restore.

The evidence includes same-machine validation, VIP handover, clean validation, final run-level screenshots, pre/post four-tuple evidence, session ID and counter continuity, failure diagnostics, and timing/latency plots.

Total curated evidence files in this section: **87**.

## Evidence Gallery

### Clean Validation Mac Client Before Migration

![Clean Validation Mac Client Before Migration](../figures/established-tcp-vip/clean_validation_mac_client_before_migration.png)

- **Evidence type:** final validation evidence
- **What it shows:** clean validation mac client before migration.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Clean Validation Migration Success

![Clean Validation Migration Success](../figures/established-tcp-vip/clean_validation_migration_success.png)

- **Evidence type:** final validation evidence
- **What it shows:** clean validation migration success.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Clean Validation Post Migration Four Tuple

![Clean Validation Post Migration Four Tuple](../figures/established-tcp-vip/clean_validation_post_migration_four_tuple.png)

- **Evidence type:** final validation evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Clean Validation Post Reboot Reset Verified

![Clean Validation Post Reboot Reset Verified](../figures/established-tcp-vip/clean_validation_post_reboot_reset_verified.png)

- **Evidence type:** final validation evidence
- **What it shows:** clean validation post reboot reset verified.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Clean Validation Pre Migration Four Tuple

![Clean Validation Pre Migration Four Tuple](../figures/established-tcp-vip/clean_validation_pre_migration_four_tuple.png)

- **Evidence type:** final validation evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Clean Validation Source Server Ready

![Clean Validation Source Server Ready](../figures/established-tcp-vip/clean_validation_source_server_ready.png)

- **Evidence type:** final validation evidence
- **What it shows:** source-side terminal evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Clean Validation Target Post Migration

![Clean Validation Target Post Migration](../figures/established-tcp-vip/clean_validation_target_post_migration.png)

- **Evidence type:** final validation evidence
- **What it shows:** target-side terminal evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Client Latency Comparison

[client_latency_comparison.pdf](../figures/established-tcp-vip/client_latency_comparison.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Comparison

![Client Latency Comparison](../figures/established-tcp-vip/client_latency_comparison.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Migration Window Mean Sd

![Client Latency Migration Window Mean Sd](../figures/established-tcp-vip/client_latency_migration_window_mean_sd.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Migration Window N5

![Client Latency Migration Window N5](../figures/established-tcp-vip/client_latency_migration_window_n5.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Multiline Linear

[client_latency_multiline_linear.pdf](../figures/established-tcp-vip/client_latency_multiline_linear.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Small Multiples

[client_latency_small_multiples.pdf](../figures/established-tcp-vip/client_latency_small_multiples.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Small Multiples Clean

[client_latency_small_multiples_clean.pdf](../figures/established-tcp-vip/client_latency_small_multiples_clean.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Client Latency Small Multiples Clean

![Client Latency Small Multiples Clean](../figures/established-tcp-vip/client_latency_small_multiples_clean.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Cross Machine Source Target Environment Validation

![Cross Machine Source Target Environment Validation](../figures/established-tcp-vip/cross_machine_source_target_environment_validation.png)

- **Evidence type:** final validation evidence
- **What it shows:** source-side terminal evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Cross Machine Tcp Same Session Counter Continuity

![Cross Machine Tcp Same Session Counter Continuity](../figures/established-tcp-vip/cross_machine_tcp_same_session_counter_continuity.png)

- **Evidence type:** transport/session evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Cross Machine Tcp Session Continuity And Timing

![Cross Machine Tcp Session Continuity And Timing](../figures/established-tcp-vip/cross_machine_tcp_session_continuity_and_timing.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Established Tcp Client Continuity Terminal 20260811

![Established Tcp Client Continuity Terminal 20260811](../figures/established-tcp-vip/established_tcp_client_continuity_terminal_20260811.png)

- **Evidence type:** representative migration evidence
- **What it shows:** client-observed continuity evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Established Tcp Experimental Architecture

![Established Tcp Experimental Architecture](../figures/established-tcp-vip/established_tcp_experimental_architecture.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** experiment architecture diagram.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Established Tcp Vip Multiline Runs

[established_tcp_vip_multiline_runs.pdf](../figures/established-tcp-vip/established_tcp_vip_multiline_runs.pdf)

- **Evidence type:** supporting evidence
- **What it shows:** floating VIP handover or phase timing evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Established Tcp Vip Phase Timing Clean

[established_tcp_vip_phase_timing_clean.pdf](../figures/established-tcp-vip/established_tcp_vip_phase_timing_clean.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Established Tcp Vip Phase Timing Clean

![Established Tcp Vip Phase Timing Clean](../figures/established-tcp-vip/established_tcp_vip_phase_timing_clean.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Established Tcp Vip Phase Timing Mean Sd

[established_tcp_vip_phase_timing_mean_sd.pdf](../figures/established-tcp-vip/established_tcp_vip_phase_timing_mean_sd.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Established Tcp Vip Timing Breakdown

[established_tcp_vip_timing_breakdown.pdf](../figures/established-tcp-vip/established_tcp_vip_timing_breakdown.pdf)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Established Tcp Vip Timing Breakdown

![Established Tcp Vip Timing Breakdown](../figures/established-tcp-vip/established_tcp_vip_timing_breakdown.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Final N5 Client Peak Latency

![Final N5 Client Peak Latency](../figures/established-tcp-vip/final_n5_client_peak_latency.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final N5 Corrected Summary 5Of5 1

![Final N5 Corrected Summary 5Of5 1](../figures/established-tcp-vip/final_n5_corrected_summary_5of5-1.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final N5 Corrected Summary 5Of5 2

![Final N5 Corrected Summary 5Of5 2](../figures/established-tcp-vip/final_n5_corrected_summary_5of5-2.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final N5 Success Summary

![Final N5 Success Summary](../figures/established-tcp-vip/final_n5_success_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final N5 Timing Statistics

![Final N5 Timing Statistics](../figures/established-tcp-vip/final_n5_timing_statistics.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run1 Mac Client Before Migration

![Final Run1 Mac Client Before Migration](../figures/established-tcp-vip/final_run1_mac_client_before_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run1 Mac Evidence Copied

![Final Run1 Mac Evidence Copied](../figures/established-tcp-vip/final_run1_mac_evidence_copied.png)

- **Evidence type:** supporting evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run1 Migration Success

![Final Run1 Migration Success](../figures/established-tcp-vip/final_run1_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run1 Post Migration Four Tuple

![Final Run1 Post Migration Four Tuple](../figures/established-tcp-vip/final_run1_post_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run1 Pre Migration Four Tuple

![Final Run1 Pre Migration Four Tuple](../figures/established-tcp-vip/final_run1_pre_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run1 Target Post Migration

![Final Run1 Target Post Migration](../figures/established-tcp-vip/final_run1_target_post_migration.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run2 Mac Client Before Migration

![Final Run2 Mac Client Before Migration](../figures/established-tcp-vip/final_run2_mac_client_before_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run2 Migration Success

![Final Run2 Migration Success](../figures/established-tcp-vip/final_run2_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run2 Post Migration Four Tuple

![Final Run2 Post Migration Four Tuple](../figures/established-tcp-vip/final_run2_post_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run2 Pre Migration Four Tuple

![Final Run2 Pre Migration Four Tuple](../figures/established-tcp-vip/final_run2_pre_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run2 Source Server Ready

![Final Run2 Source Server Ready](../figures/established-tcp-vip/final_run2_source_server_ready.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run2 Target Post Migration

![Final Run2 Target Post Migration](../figures/established-tcp-vip/final_run2_target_post_migration.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run3 Mac Client Before Migration

![Final Run3 Mac Client Before Migration](../figures/established-tcp-vip/final_run3_mac_client_before_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run3 Migration Success

![Final Run3 Migration Success](../figures/established-tcp-vip/final_run3_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run3 Post Migration Four Tuple

![Final Run3 Post Migration Four Tuple](../figures/established-tcp-vip/final_run3_post_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run3 Pre Migration Four Tuple

![Final Run3 Pre Migration Four Tuple](../figures/established-tcp-vip/final_run3_pre_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run3 Source Server Ready

![Final Run3 Source Server Ready](../figures/established-tcp-vip/final_run3_source_server_ready.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run3 Target Post Migration

![Final Run3 Target Post Migration](../figures/established-tcp-vip/final_run3_target_post_migration.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run4 Mac Client Before Migration

![Final Run4 Mac Client Before Migration](../figures/established-tcp-vip/final_run4_mac_client_before_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run4 Migration Success

![Final Run4 Migration Success](../figures/established-tcp-vip/final_run4_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run4 Post Migration Four Tuple

![Final Run4 Post Migration Four Tuple](../figures/established-tcp-vip/final_run4_post_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run4 Pre Migration Four Tuple

![Final Run4 Pre Migration Four Tuple](../figures/established-tcp-vip/final_run4_pre_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run4 Source Server Ready

![Final Run4 Source Server Ready](../figures/established-tcp-vip/final_run4_source_server_ready.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run4 Target Post Migration

![Final Run4 Target Post Migration](../figures/established-tcp-vip/final_run4_target_post_migration.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run5 Mac Client Before Migration

![Final Run5 Mac Client Before Migration](../figures/established-tcp-vip/final_run5_mac_client_before_migration.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run5 Migration Success

![Final Run5 Migration Success](../figures/established-tcp-vip/final_run5_migration_success.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run5 Post Migration Four Tuple

![Final Run5 Post Migration Four Tuple](../figures/established-tcp-vip/final_run5_post_migration_four_tuple.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run5 Pre Migration Four Tuple

![Final Run5 Pre Migration Four Tuple](../figures/established-tcp-vip/final_run5_pre_migration_four_tuple.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Final Run5 Source Server Ready

![Final Run5 Source Server Ready](../figures/established-tcp-vip/final_run5_source_server_ready.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Final Run5 Target Post Migration

![Final Run5 Target Post Migration](../figures/established-tcp-vip/final_run5_target_post_migration.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** run-level final established TCP evidence.
- **Claim supported:** Supports final run-level established TCP + VIP evaluation.

### Migration Approach Comparison Matrix

![Migration Approach Comparison Matrix](../figures/established-tcp-vip/migration_approach_comparison_matrix.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** migration approach comparison matrix.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Migration Reliability Comparison

[migration_reliability_comparison.pdf](../figures/established-tcp-vip/migration_reliability_comparison.pdf)

- **Evidence type:** representative migration evidence
- **What it shows:** migration reliability comparison.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Migration Reliability Comparison

![Migration Reliability Comparison](../figures/established-tcp-vip/migration_reliability_comparison.png)

- **Evidence type:** representative migration evidence
- **What it shows:** migration reliability comparison.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Migration Reliability Comparison Updated

![Migration Reliability Comparison Updated](../figures/established-tcp-vip/migration_reliability_comparison_updated.png)

- **Evidence type:** representative migration evidence
- **What it shows:** migration reliability comparison updated.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Progressive Migration Framework

![Progressive Migration Framework](../figures/established-tcp-vip/progressive_migration_framework.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** progressive migration framework.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Progressive Migration Framework Publication

[progressive_migration_framework_publication.pdf](../figures/established-tcp-vip/progressive_migration_framework_publication.pdf)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** progressive migration framework publication.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Progressive Migration Framework Publication

![Progressive Migration Framework Publication](../figures/established-tcp-vip/progressive_migration_framework_publication.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** progressive migration framework publication.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Run1 Initial Vip Ownership

![Run1 Initial Vip Ownership](../figures/established-tcp-vip/run1_initial_vip_ownership.png)

- **Evidence type:** supporting evidence
- **What it shows:** floating VIP handover or phase timing evidence.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Run1 Mac Client Before Migration

![Run1 Mac Client Before Migration](../figures/established-tcp-vip/run1_mac_client_before_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** run1 mac client before migration.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Run1 Pre Migration Four Tuple

![Run1 Pre Migration Four Tuple](../figures/established-tcp-vip/run1_pre_migration_four_tuple.png)

- **Evidence type:** transport/session evidence
- **What it shows:** TCP four-tuple before/after migration.
- **Claim supported:** Supports client-visible TCP endpoint continuity before and after migration.

### Run1 Restore Runtime Mount Failure

![Run1 Restore Runtime Mount Failure](../figures/established-tcp-vip/run1_restore_runtime_mount_failure.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** retained failure evidence.
- **Claim supported:** Documents harness failure diagnosis and clean-state controls.

### Run1 Source Server Before Client

![Run1 Source Server Before Client](../figures/established-tcp-vip/run1_source_server_before_client.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** target Server B state restoration after application-managed migration.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

### Run1 Stale Runtime Mounts Diagnosis

![Run1 Stale Runtime Mounts Diagnosis](../figures/established-tcp-vip/run1_stale_runtime_mounts_diagnosis.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** run1 stale runtime mounts diagnosis.
- **Claim supported:** Documents harness failure diagnosis and clean-state controls.

### Same Machine Criu Dump Success With Established Socket

![Same Machine Criu Dump Success With Established Socket](../figures/established-tcp-vip/same_machine_criu_dump_success_with_established_socket.png)

- **Evidence type:** transport/session evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Criu Restore Success And Network Unlock

![Same Machine Criu Restore Success And Network Unlock](../figures/established-tcp-vip/same_machine_criu_restore_success_and_network_unlock.png)

- **Evidence type:** representative migration evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Continuity

![Same Machine Tcp Continuity](../figures/established-tcp-vip/same_machine_tcp_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Established Before Migration State

![Same Machine Tcp Established Before Migration State](../figures/established-tcp-vip/same_machine_tcp_established_before_migration_state.png)

- **Evidence type:** representative migration evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Post Restore Client Continuity

![Same Machine Tcp Post Restore Client Continuity](../figures/established-tcp-vip/same_machine_tcp_post_restore_client_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** client-observed continuity evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Post Restore Client Long Run

![Same Machine Tcp Post Restore Client Long Run](../figures/established-tcp-vip/same_machine_tcp_post_restore_client_long_run.png)

- **Evidence type:** representative migration evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Post Restore Diagnostic Terminal

![Same Machine Tcp Post Restore Diagnostic Terminal](../figures/established-tcp-vip/same_machine_tcp_post_restore_diagnostic_terminal.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** diagnostic evidence explaining a failure mode.
- **Claim supported:** Documents harness failure diagnosis and clean-state controls.

### Same Machine Tcp Server Client Initial Run

![Same Machine Tcp Server Client Initial Run](../figures/established-tcp-vip/same_machine_tcp_server_client_initial_run.png)

- **Evidence type:** supporting evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Same Machine Tcp Source Environment Setup

![Same Machine Tcp Source Environment Setup](../figures/established-tcp-vip/same_machine_tcp_source_environment_setup.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** same-machine TCP-established validation evidence.
- **Claim supported:** Supports the prerequisite validation that CRIU can restore an established TCP socket.

### Stale Runtime Mounts Cleanup Success

![Stale Runtime Mounts Cleanup Success](../figures/established-tcp-vip/stale_runtime_mounts_cleanup_success.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** stale runtime mounts cleanup success.
- **Claim supported:** Documents harness failure diagnosis and clean-state controls.

### Tcp Vip Peak Latency Per Run

![Tcp Vip Peak Latency Per Run](../figures/established-tcp-vip/tcp_vip_peak_latency_per_run.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Tcp Vip Per Run Stacked Timing

![Tcp Vip Per Run Stacked Timing](../figures/established-tcp-vip/tcp_vip_per_run_stacked_timing.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports migration disruption and phase timing analysis.

### Transparency Complexity Tradeoff

![Transparency Complexity Tradeoff](../figures/established-tcp-vip/transparency_complexity_tradeoff.png)

- **Evidence type:** supporting evidence
- **What it shows:** transparency complexity tradeoff.
- **Claim supported:** Supports the advanced claim that established TCP session continuity can survive source-to-target migration in the tested environment.

