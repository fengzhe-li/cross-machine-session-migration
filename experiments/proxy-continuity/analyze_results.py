#!/usr/bin/env python3
import argparse
import csv
from pathlib import Path


def read_switch_time(path):
    if not path.exists():
        return None
    with path.open("r", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        return None
    return float(rows[-1]["timestamp"])


def main():
    parser = argparse.ArgumentParser(description="Summarise connection redirection experiment logs.")
    parser.add_argument("--client-log", default="logs/client.csv")
    parser.add_argument("--switch-log", default="logs/switch_events.csv")
    parser.add_argument("--summary", default="logs/summary.txt")
    args = parser.parse_args()

    client_log = Path(args.client_log)
    switch_log = Path(args.switch_log)
    summary_path = Path(args.summary)

    with client_log.open("r", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))

    switch_time = read_switch_time(switch_log)
    ok_rows = [row for row in rows if row["status"] == "OK"]
    failed_rows = [row for row in rows if row["status"] != "OK"]
    after_switch = [
        row for row in rows
        if switch_time is not None and float(row["timestamp"]) >= switch_time
    ]
    after_switch_ok = [row for row in after_switch if row["status"] == "OK"]
    after_switch_b = [row for row in after_switch_ok if row["backend"] == "serverB"]

    downtime = 0.0
    if switch_time is not None and after_switch_b:
        first_b = min(float(row["timestamp"]) for row in after_switch_b)
        downtime = max(0.0, first_b - switch_time)

    lines = [
        "Connection Redirection Experiment Summary",
        "",
        f"Total requests: {len(rows)}",
        f"Successful requests: {len(ok_rows)}",
        f"Failed requests: {len(failed_rows)}",
        f"Switch time: {switch_time if switch_time is not None else 'N/A'}",
        f"Successful requests after switch: {len(after_switch_ok)}",
        f"Successful Server B requests after switch: {len(after_switch_b)}",
        f"Measured downtime until first Server B response: {downtime:.3f} s",
        "",
        "Interpretation:",
        "The client used one stable proxy endpoint for the whole run.",
        "A successful Server B response after the switch shows that backend redirection",
        "was hidden behind the proxy endpoint.",
    ]

    summary_path.parent.mkdir(parents=True, exist_ok=True)
    summary_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
