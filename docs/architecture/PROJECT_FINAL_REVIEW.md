# Project Final Review

Review perspective: supervisor-style evidence and requirements audit for the
session migration final-year/MSc project.

Review date: 2026-08-11

Reviewed project root:

`<local-source-project>`

## 1. Original Project Requirements

From the two meeting transcripts, the project objective is not simply to build
separate demos. The intended research problem is session/computation migration:

1. Move computation from one machine/location to another.
2. Preserve program state, memory state, and execution state where possible.
3. Redirect communication so the client continues using what it believes is the
   same endpoint.
4. Explore increasing implementation difficulty:
   - Level 1: application-aware migration, described as warm-up.
   - Level 2: Docker/container migration.
   - Level 3: native process migration without Docker, using CRIU and/or
     Telefork.
5. Measure migration time, success/failure, downtime, and state continuity.

Important interpretation:

- The supervisor's highest-level goal is not "restart somewhere else".
- The stronger claim is "the computation/session continues".
- Connection continuity is a separate requirement from computation migration.

## 2. Repository / Artefact State

The project directory is not currently a Git repository, so `git status` is not
available for this review.

Main reviewed modules:

| Area | Path | Current state |
|---|---|---|
| Level 1 application migration | `level1_application_migration/checkpoint-demo/` | Minimal counter application and Dockerfile present; little preserved evidence. |
| Level 2 Docker migration | `level2_docker_migration/docker-checkpoint-demo/` | Docker checkpoint/restore scripts present; result logs not well preserved. |
| Level 3 CRIU process migration | `level2_docker_migration/docker-checkpoint-demo/level3/` | CRIU process migration scripts and README exist, but location/naming is confusing because it sits under Level 2 Docker. |
| Level 3 Telefork | `level3_process_migration/Telefork/` | Strong result files exist, including cross-machine success and benchmark v2. |
| Proxy connection redirection | `connection_redirection/` | Complete module with logs and summary. |
| Same-machine TCP established CRIU | `tcp_established_same_machine/` | Scripts present, but the local `logs/` folder is empty in this project copy. Successful run evidence is described in conversation, but not preserved here. |
| Cross-machine TCP established CRIU | `tcp_established_cross_machine/` | Stage A/B implementation present; current logs do not yet prove completed cross-machine restore. |

Static script validation:

- All project shell scripts passed `bash -n`.
- No screenshots, PDF exports, or pcap/tcpdump evidence files were found in the
  reviewed repository copy.

## 3. Requirements Compliance

| Requirement | Status | Evidence | Supervisor-facing judgement |
|---|---:|---|---|
| Define staged migration levels | Completed | Folder structure and meeting-aligned scripts for Level 1/2/3 plus connection work. | Conceptually aligned with supervisor's plan. |
| Level 1 application-aware migration | Partially completed | `level1_application_migration/checkpoint-demo/counter.py` and Dockerfile. | Warm-up implementation exists, but evidence is weak. Need logs showing state save/transfer/restore if making more than a brief claim. |
| Level 2 Docker/container checkpoint/restore | Partially to mostly completed | Docker scripts: `run_checkpoint_restore_once.sh`, `run_simulated_container_migration.sh`, `run_tcp_live_migration_existing.sh`. | Implementation path is credible, but preserved output/results are missing. Need captured terminal output proving counters continue after restore. |
| Native CRIU process migration | Partially completed | CRIU scripts and README under `level2_docker_migration/docker-checkpoint-demo/level3/`. README claims cross-machine restore and typical timings. | The work matches Level 3 intent, but evidence should be moved/presented carefully in the report as "CRIU process migration investigation". |
| Telefork process migration | Completed with good evidence | `telefork_cross_machine_result.txt`, `telefork_benchmark_v2/results.csv`, `summary.txt`. | Strongest Level 3 process-migration evidence. Shows cross-machine process migration, preserved variable, 10/10 benchmark success. |
| Connection redirection with stable endpoint | Completed | `connection_redirection/logs/summary.txt`, `client.csv`, `proxy.csv`, `switch_events.csv`. | Strong evidence for proxy-based endpoint redirection. This satisfies the "client still uses same endpoint" requirement, but not true TCP socket migration. |
| Same-machine established TCP restore | Completed experimentally but evidence missing from repo copy | Scripts exist in `tcp_established_same_machine/`, but `logs/` is empty. | The claim is important and should be supported by preserved logs/evidence folder. In the current reviewed copy, this cannot be independently verified. |
| Cross-machine established TCP migration | In progress / not yet safely claimable | Stage A/B scripts and partial logs under `tcp_established_cross_machine/`. | Stage A VIP handover is described and implemented. Stage B automation exists, but current repo evidence does not prove successful CRIU restore on target or post-restore client continuation. |
| Migration metrics | Partially completed | Proxy downtime summary; Telefork benchmark timings; Docker scripts compute timings; CRIU README gives typical times. | Some metrics exist, but not consistently preserved for all levels. |

## 4. Project Diary / Plan Consistency

The implementation broadly follows the supervisor's staged plan:

| Planned direction | Implementation match | Notes |
|---|---|---|
| Start with application-aware warm-up | Partial match | Minimal Level 1 exists, but not much diary/evidence. |
| Move to Docker/container migration | Match | Docker checkpoint/restore scripts exist. |
| Explore native process migration using CRIU and Telefork | Match | CRIU and Telefork both explored. Telefork has stronger evidence. |
| Add connection redirection so client remains unaware | Match | Proxy redirection completed with logs. |
| Investigate true established TCP migration | Match in progress | Same-machine validation reportedly succeeded, and Stage B cross-machine work is actively implemented. |

Potential contradictions or risks:

1. Some README files under `level2_docker_migration/docker-checkpoint-demo/level3/`
   describe "Level 3 - Cross-Machine Process Migration using CRIU". This is
   conceptually Level 3 but physically nested under Level 2 Docker. The final
   dissertation should not imply native CRIU process migration is part of Docker
   migration.
2. The Docker work and CRIU work are currently mixed in directory naming. This
   is less important for final submission, but the report must distinguish:
   - Docker checkpoint/restore as container-level migration.
   - Native CRIU as process-level migration.
3. Telefork evidence includes an initial benchmark set with 10/10 failures and
   a later v2 benchmark with 10/10 successes. This is not a problem if written
   honestly as iterative debugging; it would be a problem if only the success
   were reported without explaining the earlier failed stage.
4. Cross-machine TCP established migration logs currently show a long-running
   single-session client, but not enough target-side restore evidence. Do not
   claim final cross-machine TCP migration success yet unless a clean successful
   Stage B evidence folder is added.

## 5. Experiment Validation

### 5.1 Level 1 Application Migration

Demonstrated:

- A simple counter application exists.
- The code is suitable for a warm-up state migration demonstration.

Evidence found:

- `level1_application_migration/checkpoint-demo/counter.py`
- `level1_application_migration/checkpoint-demo/Dockerfile`

Safe claims:

- "A simple application-level warm-up workload was implemented."
- If additional logs exist outside this repository copy, the report may claim
  application-aware state transfer only when those logs show state before and
  after migration.

Unsafe claims from current repository evidence:

- "Application migration was fully validated with measured downtime."
- "Application state was transferred successfully" unless a state file/log is
  added.

Needed evidence:

- Terminal output before migration.
- State/checkpoint file contents.
- Terminal output after migration continuing from same counter/session value.
- Basic timing/downtime if used in evaluation.

### 5.2 Level 2 Container Migration

Demonstrated:

- Docker checkpoint/restore automation exists.
- Scripts use `docker checkpoint create` and `docker start --checkpoint`.
- Scripts measure checkpoint time, restore time, transfer/copy time.
- TCP server container experiment exists.

Evidence found:

- `run_checkpoint_restore_once.sh`
- `run_simulated_container_migration.sh`
- `run_tcp_container_migration.sh`
- `run_tcp_live_migration_existing.sh`
- `Dockerfile`, `Dockerfile_tcp`, `counter.py`, `tcp_server.py`

Safe claims:

- "Container-level migration was implemented using Docker checkpoint/restore."
- "The scripts are designed to measure checkpoint and restore time."
- "The experiment targets runtime state preservation rather than a conventional restart."

Claims needing preserved logs:

- "The container runtime counter definitely continued from value N to N+1 after restore."
- "The measured checkpoint/restore time was X ms."
- "The TCP container responded successfully after restore."

Needed evidence:

- Saved terminal output from one successful Docker run.
- Docker logs before checkpoint and after restore.
- Checkpoint/restore timings.
- Screenshot of Docker checkpoint list or terminal output.

### 5.3 Level 3 Native Process Migration: CRIU

Demonstrated:

- Native CRIU process migration scripts exist.
- README describes source/target VMs, checkpoint transfer, and restore.
- The process workload is a counter process.

Evidence found:

- `level2_docker_migration/docker-checkpoint-demo/level3/migrate.sh`
- `level2_docker_migration/docker-checkpoint-demo/level3/final_criu_working/README.md`
- CRIU workflow documentation with typical timings.

Safe claims:

- "CRIU was investigated and implemented for native process checkpoint/restore."
- "The process-level CRIU experiment targeted in-memory counter continuity."

Claims needing caution:

- "CRIU process migration is fully complete" should be softened unless raw
  logs are added.
- Prefer "CRIU process migration investigation" or "CRIU checkpoint/restore
  prototype" unless there is a preserved evidence folder with dump/restore logs.

Needed evidence:

- Source terminal before dump.
- `criu dump` log.
- SCP/transfer output.
- Target restore log.
- Target terminal showing counter continuation.
- Timing table.

### 5.4 Level 3 Native Process Migration: Telefork

Demonstrated:

- Cross-machine Telefork process migration result exists.
- Local variable preservation was demonstrated.
- Target child exit status matches preserved variable value.
- Benchmark v2 shows 10/10 success.

Evidence found:

- `level3_process_migration/Telefork/telefork_cross_machine_result.txt`
- `source_backup/project_results/telefork_cross_machine_result.txt`
- `target_backup/project_results/telefork_target_cross_machine_result.txt`
- `source_backup/project_results/telefork_benchmark_v2/results.csv`
- `source_backup/project_results/telefork_benchmark_v2/summary.txt`
- ARM64 limitation evidence under `level2_docker_migration/docker-checkpoint-demo/level4_telefork/ARM64_LIMITATION.md`

Safe claims:

- "Telefork was evaluated as a native process migration mechanism."
- "The original ARM64 environment exposed architecture limitations."
- "The x86_64 Telefork experiment successfully migrated process state across machines."
- "The successful benchmark achieved 10/10 runs, mean migration time about 0.255 s."

Important limitation:

- Telefork did not migrate an already-established TCP server session in the
  evidence reviewed. It demonstrates process state migration, not full service
  connection continuity.

### 5.5 Connection Redirection

Demonstrated:

- Client connects to a stable proxy endpoint.
- Proxy initially forwards to Server A.
- Migration switch changes backend to Server B.
- Client does not know Server A/B addresses.
- Logs show 47 total requests, 47 successes, 0 failures.
- Switch occurred at timestamp `1786359932.879881`.
- First successful Server B response occurred with measured downtime `0.135 s`.

Evidence found:

- `connection_redirection/logs/summary.txt`
- `connection_redirection/logs/client.csv`
- `connection_redirection/logs/proxy.csv`
- `connection_redirection/logs/switch_events.csv`
- `connection_redirection/logs/serverA.log`
- `connection_redirection/logs/serverB.log`

Safe claims:

- "Proxy-based endpoint redirection was successfully demonstrated."
- "The client used one stable endpoint while backend routing changed."
- "This satisfies the endpoint-redirection interpretation of the supervisor's
  client-unaware requirement."

Important limitation:

- This is not true established TCP connection migration. The client test sends
  repeated requests through a stable proxy endpoint; the proxy redirects future
  request handling. It does not preserve a single end-to-end TCP socket between
  client and migrated server.

### 5.6 Same-Machine CRIU `--tcp-established`

Demonstrated according to development history:

- Same-machine CRIU dump/restore with `--tcp-established` succeeded.
- The same established client socket reportedly continued beyond 3000 messages.
- Same `session_id` and continuous counter were observed.

Evidence found in current repository copy:

- Scripts exist:
  - `tcp_established_same_machine/tcp_session_server.py`
  - `tcp_established_same_machine/persistent_client.py`
  - `tcp_established_same_machine/run_same_machine_test.sh`
  - `tcp_established_same_machine/analyze_result.py`
- However, `tcp_established_same_machine/logs/` is empty in the reviewed copy.

Safe claims from current files alone:

- "A same-machine TCP-established CRIU validation module was implemented."

Claims not safely supported by current repository evidence:

- "Same-machine established TCP restore was successfully validated" unless the
  missing successful-run evidence folder is restored/preserved.

Needed evidence:

- `client.csv`, `server_events.csv`, `server_diagnostics.log`
- `dump.log`, `restore.log`
- `ss_before.txt`, `ss_after_restore.txt`
- tcpdump/pcap or terminal output showing no second SYN if available
- summary file preserving the confirmed >3000 post-restore exchanges

### 5.7 Cross-Machine TCP Established Migration

Demonstrated:

- Stage A design and scripts implement VIP claim/release and Gratuitous ARP.
- Stage B implements a realistic CRIU `--tcp-established` cross-machine attempt:
  source dump, checkpoint transfer, runtime dependency packaging, VIP handover,
  target restore, target socket/process collection.
- TTY/fd and SSH/sudo automation have been addressed in scripts.

Evidence found:

- `tcp_established_cross_machine/README_STAGE_A.md`
- `tcp_established_cross_machine/README_STAGE_B.md`
- Stage A/B shell scripts.
- `tcp_established_cross_machine/logs/client.csv` with 1600 rows, 1600 OK
  entries, one `session_id`, continuous sequence/counter 1-1598.

Current limitation:

- The reviewed `client.csv` proves a long-running persistent client session to
  the VIP, but it does not by itself prove the server was restored on target.
- Current `server_diagnostics.log` contains an older failed bind attempt
  (`OSError: Can't assign requested address`).
- No clean `restore.log`, `dump.log`, `stage_b_ss_target_after_restore.txt`,
  `stage_b_restored_process.txt`, or tcpdump/pcap was found in the repository
  copy.

Safe claims:

- "Cross-machine established TCP migration was designed and implemented as an
  advanced experiment."
- "Stage A VIP handover was validated according to project notes."
- "Stage B is the final advanced experiment pipeline."

Unsafe claim at this moment:

- "Cross-machine established TCP session migration is fully successful."

Needed evidence before final claim:

- Full Stage B run log with `CRIU_DUMP_EXIT_CODE=0` and
  `CRIU_RESTORE_EXIT_CODE=0`.
- Source dump log.
- Target restore log.
- Target restored process listing.
- `ss` before dump and after target restore showing same TCP 4-tuple.
- Client CSV showing same `session_id` and continuous counter before/after the
  restore timestamp.
- tcpdump/pcap showing no second SYN after migration.
- Migration timing CSV: dump, transfer, VIP handover, restore, downtime.

## 6. Final Report Readiness

Recommended report structure:

1. Introduction
   - Motivation: low-latency interactive services, moving users, edge/cloud.
   - Problem: move computation and preserve communication continuity.
2. Requirements and Research Questions
   - RQ1: Can application state be migrated explicitly?
   - RQ2: Can container runtime state be migrated using Docker checkpoint/restore?
   - RQ3: Can native process execution state be migrated using CRIU/Telefork?
   - RQ4: How can communication continuity be maintained after migration?
3. Background
   - Checkpoint/restore, CRIU, Docker checkpoint/restore, Telefork, TCP state,
     proxy/NAT/VIP concepts.
4. Methodology
   - Experimental environment.
   - Metrics: migration time, downtime, failed requests, success rate, state
     continuity, TCP continuity.
5. Level 1: Application-Aware Migration
   - Treat as warm-up.
6. Level 2: Container-Level Migration
   - Docker checkpoint/restore.
   - Clearly state Docker may use CRIU internally, but the research object is
     the container runtime.
7. Level 3: Process-Level Migration
   - CRIU investigation.
   - Telefork investigation and benchmark.
8. Communication Continuity
   - Proxy-based redirection.
   - Same-machine TCP established CRIU validation.
   - Cross-machine VIP + CRIU Stage B as advanced work, only claim success if
     final evidence is collected.
9. Evaluation
   - Tables comparing all experiments.
   - Metrics and limitations.
10. Discussion
   - Difference between endpoint redirection and true TCP migration.
   - OS/runtime limitations.
   - Architecture and portability limitations.
11. Conclusion and Future Work

## 7. Missing Evidence Checklist

High priority before submission:

| Item | Why needed |
|---|---|
| Level 1 run logs | Needed to prove warm-up state migration, even briefly. |
| Docker checkpoint/restore terminal output | Needed to support Level 2 claims and timings. |
| CRIU native process dump/restore logs | Needed to support Level 3 CRIU claims. |
| Same-machine TCP-established evidence folder | Important because this is a strong dissertation contribution but currently missing from repo copy. |
| Cross-machine Stage B successful run folder | Required before claiming true cross-machine established TCP migration. |
| Screenshots of key successful terminals | Useful for dissertation evidence and viva-style defence. |
| tcpdump/pcap for TCP continuity | Required if claiming no reconnect/no second SYN. |
| Environment table | Source/target OS, kernel, CRIU version, architecture, IPs. |
| Repetition table | At least 3 runs for proxy, Docker, same-machine TCP; 10-run Telefork already exists. |

## 8. Likely Supervisor Criticisms

1. Evidence is uneven.
   - Proxy and Telefork have strong logs.
   - Level 1, Docker, CRIU, and same-machine TCP need better preserved evidence.

2. Directory naming may confuse the research story.
   - Native CRIU appears under a Docker path.
   - In the dissertation, structure the narrative by research level, not by
     current folder location.

3. Proxy redirection is not TCP migration.
   - This is acceptable if explicitly stated.
   - It should be presented as endpoint redirection, not established socket
     preservation.

4. Cross-machine TCP established migration is not yet proven in the reviewed
   artefacts.
   - Scripts are promising, but final claims need dump/restore/tcpdump/ss
     evidence.

5. Metrics are inconsistent across levels.
   - The report should use the same metric categories for every experiment:
     state continuity, downtime, failure count, migration time, and limitations.

6. Some work is described in README files but not supported by raw logs.
   - A supervisor may ask for raw terminal evidence. Preserve it now.

## 9. Overall Assessment

The project is well aligned with the supervisor's original direction. It is
not merely a collection of unrelated demos: it follows a coherent progression
from application-aware migration, to container checkpoint/restore, to native
process migration, and then to connection continuity.

Strongest completed contributions:

1. Telefork cross-machine process migration with benchmark evidence.
2. Proxy-based connection redirection with complete logs and downtime metric.
3. The design and implementation effort for CRIU `--tcp-established` validation.

Main weakness:

The evidence chain is not yet equally strong for every claim. The dissertation
can be strong if it is honest:

- Claim Level 1 as warm-up.
- Claim Level 2 as Docker checkpoint/restore implementation, with logs added.
- Claim Telefork strongly.
- Claim proxy redirection strongly.
- Claim same-machine TCP established migration only after restoring its evidence
  folder into this repository copy.
- Claim cross-machine established TCP migration only after one clean Stage B run
  is preserved with dump/restore/ss/tcpdump/client logs.

Supervisor-style final verdict:

The project has enough technical scope for a strong dissertation, but it is not
ready to submit as-is. The remaining work is not primarily new design; it is
evidence preservation, final Stage B validation, and careful writing that
separates:

- computation migration,
- endpoint redirection,
- true established TCP connection migration.
