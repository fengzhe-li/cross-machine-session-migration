#!/usr/bin/env python3
import argparse
import csv
import socket
import time
from pathlib import Path


def send_request(host, port, request_id, timeout):
    started = time.time()
    message = f"request_id={request_id} client_time={started:.6f}\n"
    with socket.create_connection((host, port), timeout=timeout) as sock:
        sock.sendall(message.encode())
        response = sock.recv(4096).decode(errors="replace").strip()
    ended = time.time()
    return ended, (ended - started) * 1000, response


def main():
    parser = argparse.ArgumentParser(description="Client that only talks to the stable proxy endpoint.")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=9000)
    parser.add_argument("--duration", type=float, default=12.0)
    parser.add_argument("--interval", type=float, default=0.25)
    parser.add_argument("--timeout", type=float, default=1.0)
    parser.add_argument("--log", default="logs/client.csv")
    args = parser.parse_args()

    log_path = Path(args.log)
    log_path.parent.mkdir(parents=True, exist_ok=True)

    start = time.time()
    deadline = start + args.duration
    request_id = 0

    with log_path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.writer(handle)
        writer.writerow(["timestamp", "request_id", "status", "latency_ms", "backend", "response"])

        while time.time() < deadline:
            request_id += 1
            backend = "unknown"
            status = "FAIL"
            latency_ms = 0.0
            response = ""

            try:
                timestamp, latency_ms, response = send_request(
                    args.host,
                    args.port,
                    request_id,
                    args.timeout,
                )
                status = "OK"
                for token in response.split():
                    if token.startswith("backend="):
                        backend = token.split("=", 1)[1]
                        break
            except Exception as exc:
                timestamp = time.time()
                response = f"{type(exc).__name__}: {exc}"

            writer.writerow(
                [
                    f"{timestamp:.6f}",
                    request_id,
                    status,
                    f"{latency_ms:.3f}",
                    backend,
                    response,
                ]
            )
            handle.flush()

            print(
                f"{timestamp:.6f} request={request_id} status={status} "
                f"backend={backend} latency_ms={latency_ms:.3f} response={response}",
                flush=True,
            )
            time.sleep(args.interval)


if __name__ == "__main__":
    main()
