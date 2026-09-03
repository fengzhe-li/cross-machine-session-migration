# Native CRIU Process Migration Evidence

The native CRIU experiment removes Docker from the stack and migrates a Linux process directly. The main observable state is a counter that should continue after restore on the target machine.

The evidence includes manual validation, cross-machine checkpoint/transfer/restore screenshots, final n=5 summary evidence, raw CSV views, and timing plots.

Total curated evidence files in this section: **25**.

## Evidence Gallery

### Level3 Criu Automated Cross Machine Migration

![Level3 Criu Automated Cross Machine Migration](../figures/level3-native-criu/level3_criu_automated_cross_machine_migration.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level3 criu automated cross machine migration.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Checkpoint Transfer Restore Continuity

![Level3 Criu Checkpoint Transfer Restore Continuity](../figures/level3-native-criu/level3_criu_checkpoint_transfer_restore_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint transfer and target restore workflow.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Checkpoint Transfer Restore

![Level3 Criu Cross Machine Checkpoint Transfer Restore](../figures/level3-native-criu/level3_criu_cross_machine_checkpoint_transfer_restore.png)

- **Evidence type:** representative migration evidence
- **What it shows:** checkpoint transfer and target restore workflow.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Counter Continuity Success

![Level3 Criu Cross Machine Counter Continuity Success](../figures/level3-native-criu/level3_criu_cross_machine_counter_continuity_success.png)

- **Evidence type:** representative migration evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Migration Workflow

![Level3 Criu Cross Machine Migration Workflow](../figures/level3-native-criu/level3_criu_cross_machine_migration_workflow.png)

- **Evidence type:** architecture/workflow evidence
- **What it shows:** workflow diagram or terminal workflow evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Restore And Counter Continuity

![Level3 Criu Cross Machine Restore And Counter Continuity](../figures/level3-native-criu/level3_criu_cross_machine_restore_and_counter_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Restore Counter Continuity

![Level3 Criu Cross Machine Restore Counter Continuity](../figures/level3-native-criu/level3_criu_cross_machine_restore_counter_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Restore Debugging Context

![Level3 Criu Cross Machine Restore Debugging Context](../figures/level3-native-criu/level3_criu_cross_machine_restore_debugging_context.png)

- **Evidence type:** failure/diagnostic evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Documents diagnostic work and limitations encountered during native CRIU migration.

### Level3 Criu Cross Machine Restore Process Continuity

![Level3 Criu Cross Machine Restore Process Continuity](../figures/level3-native-criu/level3_criu_cross_machine_restore_process_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Cross Machine Setup

![Level3 Criu Cross Machine Setup](../figures/level3-native-criu/level3_criu_cross_machine_setup.png)

- **Evidence type:** supporting evidence
- **What it shows:** level3 criu cross machine setup.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Manual Checkpoint Created

![Level3 Criu Manual Checkpoint Created](../figures/level3-native-criu/level3_criu_manual_checkpoint_created.png)

- **Evidence type:** representative migration evidence
- **What it shows:** level3 criu manual checkpoint created.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Manual Restore Counter Continuity

![Level3 Criu Manual Restore Counter Continuity](../figures/level3-native-criu/level3_criu_manual_restore_counter_continuity.png)

- **Evidence type:** representative migration evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Restore Script Implementation

![Level3 Criu Restore Script Implementation](../figures/level3-native-criu/level3_criu_restore_script_implementation.png)

- **Evidence type:** representative migration evidence
- **What it shows:** restore-side evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Criu Target Restored Counter Observation

![Level3 Criu Target Restored Counter Observation](../figures/level3-native-criu/level3_criu_target_restored_counter_observation.png)

- **Evidence type:** target-side terminal evidence
- **What it shows:** counter continuity evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Cross Machine Environment Source Target

![Level3 Cross Machine Environment Source Target](../figures/level3-native-criu/level3_cross_machine_environment_source_target.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** source-side terminal evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Level3 Native Criu Raw Csv

![Level3 Native Criu Raw Csv](../figures/level3-native-criu/level3_native_criu_raw_csv.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** raw CSV or per-run result evidence.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

### Level3 Native Criu Summary

![Level3 Native Criu Summary](../figures/level3-native-criu/level3_native_criu_summary.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** native CRIU process migration result.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Manual Criu Checkpoint Dump Created

![Manual Criu Checkpoint Dump Created](../figures/level3-native-criu/manual_criu_checkpoint_dump_created.png)

- **Evidence type:** representative migration evidence
- **What it shows:** manual CRIU validation evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Manual Criu Source Process Running

![Manual Criu Source Process Running](../figures/level3-native-criu/manual_criu_source_process_running.png)

- **Evidence type:** source-side terminal evidence
- **What it shows:** manual CRIU validation evidence.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Native Criu Cross Machine Continuity Evidence

![Native Criu Cross Machine Continuity Evidence](../figures/level3-native-criu/native_criu_cross_machine_continuity_evidence.png)

- **Evidence type:** representative migration evidence
- **What it shows:** native CRIU process migration result.
- **Claim supported:** Supports the Level 3 claim that native CRIU can migrate process state outside Docker.

### Native Criu N5 All Success Runs

![Native Criu N5 All Success Runs](../figures/level3-native-criu/native_criu_n5_all_success_runs.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** native CRIU process migration result.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

### Native Criu N5 Final Summary And Raw Csv

![Native Criu N5 Final Summary And Raw Csv](../figures/level3-native-criu/native_criu_n5_final_summary_and_raw_csv.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** raw CSV or per-run result evidence.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

### Native Criu N5 Raw Csv And Results

![Native Criu N5 Raw Csv And Results](../figures/level3-native-criu/native_criu_n5_raw_csv_and_results.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** raw CSV or per-run result evidence.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

### Native Criu N5 Timing 2X2

[native_criu_n5_timing_2x2.pdf](../figures/level3-native-criu/native_criu_n5_timing_2x2.pdf)

- **Evidence type:** repeated-run evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

### Native Criu N5 Timing 2X2

![Native Criu N5 Timing 2X2](../figures/level3-native-criu/native_criu_n5_timing_2x2.png)

- **Evidence type:** repeated-run evidence
- **What it shows:** timing breakdown or per-run timing evidence.
- **Claim supported:** Supports final native CRIU repeated-run evaluation.

