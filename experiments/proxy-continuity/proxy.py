#!/usr/bin/env python3
import argparse
import json
import socket
import threading
import time
from pathlib import Path


def load_backend(config_path):
    with config_path.open("r", encoding="utf-8") as handle:
        config = json.load(handle)
    return config["active_backend"], config["backends"][config["active_backend"]]


def append_log(log_path, line):
    with log_path.open("a", encoding="utf-8") as handle:
        handle.write(line + "\n")


def proxy_request(client_conn, client_addr, config_path, log_path, timeout):
    start = time.time()
    backend_name = "unknown"
    status = "ERROR"
    detail = ""

    with client_conn:
        try:
            payload = client_conn.recv(4096)
            if not payload:
                return

            backend_name, backend = load_backend(config_path)
            backend_host = backend["host"]
            backend_port = int(backend["port"])

            with socket.create_connection((backend_host, backend_port), timeout=timeout) as upstream:
                upstream.sendall(payload)
                response = upstream.recv(4096)

            client_conn.sendall(response)
            status = "OK"
            detail = response.decode(errors="replace").strip().replace(",", ";")
        except Exception as exc:
            status = "ERROR"
            detail = f"{type(exc).__name__}: {exc}".replace(",", ";")
            try:
                client_conn.sendall(f"proxy_error={detail}\n".encode())
            except OSError:
                pass
        finally:
            end = time.time()
            latency_ms = (end - start) * 1000
            append_log(
                log_path,
                (
                    f"{end:.6f},{client_addr[0]}:{client_addr[1]},"
                    f"{backend_name},{status},{latency_ms:.3f},{detail}"
                ),
            )


def main():
    parser = argparse.ArgumentParser(description="Stable-endpoint TCP proxy.")
    parser.add_argument("--listen-host", default="127.0.0.1")
    parser.add_argument("--listen-port", type=int, default=9000)
    parser.add_argument("--config", default="backend_state.json")
    parser.add_argument("--log", default="logs/proxy.csv")
    parser.add_argument("--backend-timeout", type=float, default=1.0)
    args = parser.parse_args()

    config_path = Path(args.config)
    log_path = Path(args.log)
    log_path.parent.mkdir(parents=True, exist_ok=True)

    if not log_path.exists():
        append_log(log_path, "timestamp,client,backend,status,latency_ms,detail")

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as listener:
        listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        listener.bind((args.listen_host, args.listen_port))
        listener.listen()
        print(
            f"proxy listening on {args.listen_host}:{args.listen_port}; "
            f"backend config={config_path}",
            flush=True,
        )

        while True:
            conn, addr = listener.accept()
            thread = threading.Thread(
                target=proxy_request,
                args=(conn, addr, config_path, log_path, args.backend_timeout),
                daemon=True,
            )
            thread.start()


if __name__ == "__main__":
    main()
