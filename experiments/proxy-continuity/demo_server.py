#!/usr/bin/env python3
import argparse
import socket
import threading
import time


def handle_client(conn, addr, server_name, lock, state):
    with conn:
        data = conn.recv(4096)
        if not data:
            return

        with lock:
            state["counter"] += 1
            counter = state["counter"]

        message = data.decode(errors="replace").strip()
        response = (
            f"backend={server_name} counter={counter} "
            f"timestamp={time.time():.6f} request={message}\n"
        )
        print(
            f"{time.time():.6f} {server_name} handled request from {addr}: {message}",
            flush=True,
        )
        conn.sendall(response.encode())


def main():
    parser = argparse.ArgumentParser(description="Demo backend server for redirection tests.")
    parser.add_argument("--name", required=True, help="Backend name, e.g. serverA or serverB.")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, required=True)
    args = parser.parse_args()

    state = {"counter": 0}
    lock = threading.Lock()

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server.bind((args.host, args.port))
        server.listen()
        print(f"{args.name} listening on {args.host}:{args.port}", flush=True)

        while True:
            conn, addr = server.accept()
            thread = threading.Thread(
                target=handle_client,
                args=(conn, addr, args.name, lock, state),
                daemon=True,
            )
            thread.start()


if __name__ == "__main__":
    main()
