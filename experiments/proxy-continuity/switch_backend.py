#!/usr/bin/env python3
import argparse
import json
import time
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description="Switch proxy backend target.")
    parser.add_argument("backend", choices=["serverA", "serverB"])
    parser.add_argument("--config", default="backend_state.json")
    parser.add_argument("--log", default="logs/switch_events.csv")
    args = parser.parse_args()

    config_path = Path(args.config)
    log_path = Path(args.log)

    with config_path.open("r", encoding="utf-8") as handle:
        config = json.load(handle)

    old_backend = config["active_backend"]
    config["active_backend"] = args.backend

    temp_path = config_path.with_suffix(".tmp")
    with temp_path.open("w", encoding="utf-8") as handle:
        json.dump(config, handle, indent=2)
        handle.write("\n")
    temp_path.replace(config_path)

    log_path.parent.mkdir(parents=True, exist_ok=True)
    if not log_path.exists():
        log_path.write_text("timestamp,old_backend,new_backend\n", encoding="utf-8")

    with log_path.open("a", encoding="utf-8") as handle:
        handle.write(f"{time.time():.6f},{old_backend},{args.backend}\n")

    print(f"Switched backend: {old_backend} -> {args.backend}")


if __name__ == "__main__":
    main()
