#!/usr/bin/env python3
import argparse
import csv
import socket
import time


def parse_response(response):
    parsed = {"session_id": "", "pid": "", "message_counter": ""}
    for token in response.split():
        if "=" not in token:
            continue
        key, value = token.split("=", 1)
        if key in parsed:
            parsed[key] = value
    return parsed


def main():
    parser = argparse.ArgumentParser(
        description="Persistent client with exactly one TCP connect call."
    )
    parser.add_argument("--host", default="192.168.64.2")
    parser.add_argument("--port", type=int, default=7004)
    parser.add_argument("--interval", type=float, default=0.5)
    parser.add_argument("--timeout", type=float, default=30.0)
    parser.add_argument("--log", default="logs/client.csv")
    args = parser.parse_args()

    with open(args.log, "w", newline="", encoding="utf-8") as handle:
        writer = csv.writer(handle)
        writer.writerow(
            [
                "timestamp",
                "event",
                "sequence",
                "status",
                "session_id",
                "server_pid",
                "message_counter",
                "latency_ms",
                "response",
                "error",
            ]
        )
        handle.flush()

        sock = socket.create_connection((args.host, args.port), timeout=args.timeout)
        sock.settimeout(args.timeout)

        writer.writerow(
            [
                f"{time.time():.6f}",
                "CONNECTED",
                0,
                "OK",
                "",
                "",
                "",
                "0.000",
                f"{args.host}:{args.port}",
                "",
            ]
        )
        handle.flush()
        print(f"CONNECTED to {args.host}:{args.port}", flush=True)

        sequence = 0

        try:
            with sock:
                while True:
                    sequence += 1
                    started = time.time()
                    request = f"client_sequence={sequence} client_time={started:.6f}\n"

                    try:
                        sock.sendall(request.encode())
                        response = sock.recv(4096).decode(errors="replace").strip()
                        if not response:
                            raise ConnectionError("empty response from server")

                        ended = time.time()
                        latency_ms = (ended - started) * 1000
                        parsed = parse_response(response)
                        writer.writerow(
                            [
                                f"{ended:.6f}",
                                "MESSAGE",
                                sequence,
                                "OK",
                                parsed["session_id"],
                                parsed["pid"],
                                parsed["message_counter"],
                                f"{latency_ms:.3f}",
                                response,
                                "",
                            ]
                        )
                        handle.flush()
                        print(
                            f"{ended:.6f} seq={sequence} OK "
                            f"session_id={parsed['session_id']} "
                            f"counter={parsed['message_counter']} "
                            f"latency_ms={latency_ms:.3f}",
                            flush=True,
                        )
                    except Exception as exc:
                        failed_at = time.time()
                        writer.writerow(
                            [
                                f"{failed_at:.6f}",
                                "MESSAGE",
                                sequence,
                                "FAIL",
                                "",
                                "",
                                "",
                                "0.000",
                                "",
                                f"{type(exc).__name__}: {exc}",
                            ]
                        )
                        handle.flush()
                        print(
                            f"{failed_at:.6f} seq={sequence} FAIL "
                            f"{type(exc).__name__}: {exc}",
                            flush=True,
                        )
                        return

                    time.sleep(args.interval)
        except KeyboardInterrupt:
            interrupted_at = time.time()
            writer.writerow(
                [
                    f"{interrupted_at:.6f}",
                    "INTERRUPTED",
                    sequence,
                    "OK",
                    "",
                    "",
                    "",
                    "0.000",
                    "manual interrupt",
                    "",
                ]
            )
            handle.flush()
            print("Interrupted by user.", flush=True)


if __name__ == "__main__":
    main()
