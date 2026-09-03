#!/usr/bin/env python3
import argparse
import csv
from pathlib import Path


def read_csv(path):
    if not Path(path).exists():
        return []
    with open(path, "r", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def main():
    parser = argparse.ArgumentParser(
        description="Analyze same-machine CRIU established TCP experiment logs."
    )
    parser.add_argument("--client-log", default="logs/client.csv")
    parser.add_argument("--timing-log", default="logs/timing.csv")
    parser.add_argument("--summary", default="logs/summary.txt")
    args = parser.parse_args()

    client_rows = read_csv(args.client_log)
    timing_rows = read_csv(args.timing_log)
    message_rows = [row for row in client_rows if row.get("event") == "MESSAGE"]
    ok_rows = [row for row in message_rows if row.get("status") == "OK"]
    fail_rows = [row for row in message_rows if row.get("status") != "OK"]

    dump_start = dump_end = restore_start = restore_end = None
    for row in timing_rows:
        if row.get("event") == "DUMP":
            dump_start = float(row["start_timestamp"])
            dump_end = float(row["end_timestamp"])
            dump_ms = row["duration_ms"]
        elif row.get("event") == "RESTORE":
            restore_start = float(row["start_timestamp"])
            restore_end = float(row["end_timestamp"])
            restore_ms = row["duration_ms"]
    dump_ms = locals().get("dump_ms", "N/A")
    restore_ms = locals().get("restore_ms", "N/A")

    before_dump = [
        row for row in ok_rows
        if dump_start is not None and float(row["timestamp"]) < dump_start
    ]
    after_restore = [
        row for row in ok_rows
        if restore_end is not None and float(row["timestamp"]) > restore_end
    ]

    downtime = "N/A"
    if before_dump and after_restore:
        last_before = max(float(row["timestamp"]) for row in before_dump)
        first_after = min(float(row["timestamp"]) for row in after_restore)
        downtime = f"{first_after - last_before:.3f} s"

    session_ids = sorted({row["session_id"] for row in ok_rows if row["session_id"]})
    counters = [
        int(row["message_counter"])
        for row in ok_rows
        if row.get("message_counter", "").isdigit()
    ]
    counter_continues = bool(counters) and counters == sorted(counters)
    has_post_restore_success = bool(after_restore)

    lines = [
        "Same-Machine CRIU Established TCP Experiment Summary",
        "",
        f"Total message attempts: {len(message_rows)}",
        f"Successful messages: {len(ok_rows)}",
        f"Failed messages: {len(fail_rows)}",
        f"Session IDs observed: {', '.join(session_ids) if session_ids else 'N/A'}",
        f"Single session ID preserved: {len(session_ids) == 1}",
        f"Message counter monotonic: {counter_continues}",
        f"Successful message after restore: {has_post_restore_success}",
        f"Dump time: {dump_ms} ms",
        f"Restore time: {restore_ms} ms",
        f"Measured downtime: {downtime}",
        "",
        "Interpretation:",
        "PASS requires one client connection, one session_id, monotonic counters,",
        "successful post-restore messages, and no failed message after migration.",
    ]

    Path(args.summary).write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
