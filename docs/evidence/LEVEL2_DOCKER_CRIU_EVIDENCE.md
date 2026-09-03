# Level 2 Docker/CRIU Evidence

Level 2 evaluates container-level migration using Docker checkpoint/restore with CRIU underneath. The workload is a stateful TCP service, and the evidence includes checkpoint creation, checkpoint transfer, target restore, state preservation, client continuity, proxy redirection, and repeated-trial results.

The final repeated Docker evaluation retains both successful and failed attempts. This is important because the dissertation claim is not a cherry-picked demonstration: the final dataset reports 8 successful migrations out of 10 attempts.

Total curated evidence files in this section: **65**.

## Evidence Gallery

### Connection Redirection Client Switch A To B

![Connection Redirection Client Switch A To B](../figures/level2/connection_redirection_client_switch_a_to_b.png)

- **Evidence type:** supporting evidence
- **What it shows:** proxy-based endpoint redirection evidence.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Connection Redirection Controller Success

![Connection Redirection Controller Success](../figures/level2/connection_redirection_controller_success.png)

- **Evidence type:** supporting evidence
- **What it shows:** proxy-based endpoint redirection evidence.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Connection Redirection Overview

![Connection Redirection Overview](../figures/level2/connection_redirection_overview.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** proxy-based endpoint redirection evidence.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Docker 1 Source Plus Checkpoint

![Docker 1 Source Plus Checkpoint](../figures/level2/docker_1_source_plus_checkpoint.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** source-side terminal evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Docker 2 Transfer Plus Restore Plus Counter Continuity

![Docker 2 Transfer Plus Restore Plus Counter Continuity](../figures/level2/docker_2_transfer_plus_restore_plus_counter_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Docker Checkpoint Creation 144Ms

![Docker Checkpoint Creation 144Ms](../figures/level2/docker_checkpoint_creation_144ms.png)

- **Evidence type:** representative migration evidence
- **What it shows:** docker checkpoint creation 144ms.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Docker N10 Timing 2X2

[docker_n10_timing_2x2.pdf](../figures/level2/docker_n10_timing_2x2.pdf)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker N10 Timing 2X2

![Docker N10 Timing 2X2](../figures/level2/docker_n10_timing_2x2.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker N10 Timing 2X2 Clean

[docker_n10_timing_2x2_clean.pdf](../figures/level2/docker_n10_timing_2x2_clean.pdf)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker N10 Timing 2X2 Clean

![Docker N10 Timing 2X2 Clean](../figures/level2/docker_n10_timing_2x2_clean.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker N10 Timing 2X2 Final

[docker_n10_timing_2x2_final.pdf](../figures/level2/docker_n10_timing_2x2_final.pdf)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker N10 Timing 2X2 Final

![Docker N10 Timing 2X2 Final](../figures/level2/docker_n10_timing_2x2_final.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Docker Workflow Evidence

![Docker Workflow Evidence](../figures/level2/docker_workflow_evidence.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** workflow diagram or terminal workflow evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Legacy Level2 Checkpoint Time

![Legacy Level2 Checkpoint Time](../figures/level2/legacy_level2_checkpoint_time.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** legacy level2 checkpoint time.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Legacy Level2 Client Interruption

![Legacy Level2 Client Interruption](../figures/level2/legacy_level2_client_interruption.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** legacy level2 client interruption.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Legacy Level2 Restore Time

![Legacy Level2 Restore Time](../figures/level2/legacy_level2_restore_time.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Legacy Level2 Success Rate

![Legacy Level2 Success Rate](../figures/level2/legacy_level2_success_rate.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** legacy level2 success rate.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Automated Checkpoint Restore Success

![Level2 Automated Checkpoint Restore Success](../figures/level2/level2_automated_checkpoint_restore_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint and restore execution evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Automated Container Migration Success

![Level2 Automated Container Migration Success](../figures/level2/level2_automated_container_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 automated container migration success.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Checkpoint Plot

![Level2 Checkpoint Plot](../figures/level2/level2_checkpoint_plot.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 checkpoint plot.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Checkpoint Time

![Level2 Checkpoint Time](../figures/level2/level2_checkpoint_time.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** level2 checkpoint time.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Client Interruption Run3

![Level2 Client Interruption Run3](../figures/level2/level2_client_interruption_run3.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** level2 client interruption run3.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Client Measurement Run5

![Level2 Client Measurement Run5](../figures/level2/level2_client_measurement_run5.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** level2 client measurement run5.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Client Observed Interruption

![Level2 Client Observed Interruption](../figures/level2/level2_client_observed_interruption.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** level2 client observed interruption.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Docker Checkpoint Restore Automated

![Level2 Docker Checkpoint Restore Automated](../figures/level2/level2_docker_checkpoint_restore_automated.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint and restore execution evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Checkpoint Restore Success

![Level2 Docker Checkpoint Restore Success](../figures/level2/level2_docker_checkpoint_restore_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint and restore execution evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Checkpoint Transfer Restore Workflow

![Level2 Docker Checkpoint Transfer Restore Workflow](../figures/level2/level2_docker_checkpoint_transfer_restore_workflow.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** checkpoint transfer and target restore workflow.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Full Migration Workflow

![Level2 Docker Full Migration Workflow](../figures/level2/level2_docker_full_migration_workflow.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** workflow diagram or terminal workflow evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Migration Result Summary

![Level2 Docker Migration Result Summary](../figures/level2/level2_docker_migration_result_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Migration Summary Pass

![Level2 Docker Migration Summary Pass](../figures/level2/level2_docker_migration_summary_pass.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker Source Container Runtime Before Migrationnon Core

![Level2 Docker Source Container Runtime Before Migrationnon Core](../figures/level2/level2_docker_source_container_runtime_before_migrationnon_core.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** source-side terminal evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Docker State Preservation Success

![Level2 Docker State Preservation Success](../figures/level2/level2_docker_state_preservation_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** state preservation evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Experiment Summary

![Level2 Experiment Summary](../figures/level2/level2_experiment_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Client Continuity

![Level2 Integrated Client Continuity](../figures/level2/level2_integrated_client_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** client-observed continuity evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Client Handover

![Level2 Integrated Client Handover](../figures/level2/level2_integrated_client_handover.png)

- **Evidence type:** supporting evidence
- **What it shows:** client-facing handover behaviour.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Docker Migration Execution

![Level2 Integrated Docker Migration Execution](../figures/level2/level2_integrated_docker_migration_execution.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 integrated docker migration execution.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Docker Proxy Migration Success

![Level2 Integrated Docker Proxy Migration Success](../figures/level2/level2_integrated_docker_proxy_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 integrated docker proxy migration success.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Level2 Integrated Migration Controller Code

![Level2 Integrated Migration Controller Code](../figures/level2/level2_integrated_migration_controller_code.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 integrated migration controller code.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Pipeline Completion

![Level2 Integrated Pipeline Completion](../figures/level2/level2_integrated_pipeline_completion.png)

- **Evidence type:** supporting evidence
- **What it shows:** level2 integrated pipeline completion.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Integrated Proxy Client Continuity Summary

![Level2 Integrated Proxy Client Continuity Summary](../figures/level2/level2_integrated_proxy_client_continuity_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** client-observed continuity evidence.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Level2 Integrated Proxy Migration Controller Implementationnon Result

![Level2 Integrated Proxy Migration Controller Implementationnon Result](../figures/level2/level2_integrated_proxy_migration_controller_implementationnon_result.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 integrated proxy migration controller implementationnon result.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Level2 Live Client Continuity

![Level2 Live Client Continuity](../figures/level2/level2_live_client_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** client-observed continuity evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Client Interruption

![Level2 Live Client Interruption](../figures/level2/level2_live_client_interruption.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** level2 live client interruption.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Live Client Measurement

![Level2 Live Client Measurement](../figures/level2/level2_live_client_measurement.png)

- **Evidence type:** supporting evidence
- **What it shows:** level2 live client measurement.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Migration Execution

![Level2 Live Migration Execution](../figures/level2/level2_live_migration_execution.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 live migration execution.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Migration Execution2

![Level2 Live Migration Execution2](../figures/level2/level2_live_migration_execution2.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 live migration execution2.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Migration Result

![Level2 Live Migration Result](../figures/level2/level2_live_migration_result.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 live migration result.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Migration Run3

![Level2 Live Migration Run3](../figures/level2/level2_live_migration_run3.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 live migration run3.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Live Migration Run4

![Level2 Live Migration Run4](../figures/level2/level2_live_migration_run4.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 live migration run4.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Manual Checkpoint Transfer Restore

![Level2 Manual Checkpoint Transfer Restore](../figures/level2/level2_manual_checkpoint_transfer_restore.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint transfer and target restore workflow.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 N10 Failure And Raw Evidence

![Level2 N10 Failure And Raw Evidence](../figures/level2/level2_n10_failure_and_raw_evidence.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports honest reliability reporting by preserving genuine Docker/CRIU failure evidence.

### Level2 N10 Failure Diagnostics

![Level2 N10 Failure Diagnostics](../figures/level2/level2_n10_failure_diagnostics.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports honest reliability reporting by preserving genuine Docker/CRIU failure evidence.

### Level2 N10 Final Summary

![Level2 N10 Final Summary](../figures/level2/level2_n10_final_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 N10 Raw Csv Evidence

![Level2 N10 Raw Csv Evidence](../figures/level2/level2_n10_raw_csv_evidence.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 N10 Reliability Summary

![Level2 N10 Reliability Summary](../figures/level2/level2_n10_reliability_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 N10 Successful Timing Summary

![Level2 N10 Successful Timing Summary](../figures/level2/level2_n10_successful_timing_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** final ten-run repeated evaluation evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Request Success Rate

![Level2 Request Success Rate](../figures/level2/level2_request_success_rate.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** level2 request success rate.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Level2 Restore Time

![Level2 Restore Time](../figures/level2/level2_restore_time.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Statistical Summary

![Level2 Statistical Summary](../figures/level2/level2_statistical_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** summary result evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Tcp Client Switch After Restore

![Level2 Tcp Client Switch After Restore](../figures/level2/level2_tcp_client_switch_after_restore.png)

- **Evidence type:** representative migration evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Tcp Container Migration Success

![Level2 Tcp Container Migration Success](../figures/level2/level2_tcp_container_migration_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level2 tcp container migration success.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Level2 Tcp Image Build Setup

![Level2 Tcp Image Build Setup](../figures/level2/level2_tcp_image_build_setup.png)

- **Evidence type:** supporting evidence
- **What it shows:** level2 tcp image build setup.
- **Claim supported:** Supports the Level 2 claim that Docker/CRIU can preserve container runtime state across migration.

### Migration Latency

![Migration Latency](../figures/level2/migration_latency.png)

- **Evidence type:** timing/metric evidence
- **What it shows:** client-observed latency evidence.
- **Claim supported:** Supports repeated Docker migration evaluation and client-disruption measurement.

### Proxy Redirection Server B Post Switch

![Proxy Redirection Server B Post Switch](../figures/level2/proxy_redirection_server_b_post_switch.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** target Server B state restoration after application-managed migration.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

### Proxy Server A Pre Switch Processing

![Proxy Server A Pre Switch Processing](../figures/level2/proxy_server_a_pre_switch_processing.png)

- **Evidence type:** supporting evidence
- **What it shows:** proxy server a pre switch processing.
- **Claim supported:** Supports endpoint-redirection evidence for client-facing continuity.

