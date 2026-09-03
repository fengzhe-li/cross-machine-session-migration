#!/usr/bin/env python3
import argparse
import atexit
import faulthandler
import os
import signal
import socket
import sys
import time
import traceback
import uuid


diag_log = None


def log_diag(message):
    line = f"{time.time():.6f} {message}\n"
    if diag_log is not None:
        diag_log.write(line)
        diag_log.flush()
    print(line, end="", flush=True)


def log_event(log, event, session_id, pid, message_counter, detail):
    log.write(
        f"{time.time():.6f},{event},{session_id},{pid},{message_counter},{detail}\n"
    )
    log.flush()


def install_signal_handlers():
    def handler(signum, frame):
        name = signal.Signals(signum).name
        log_diag(f"SIGNAL_RECEIVED signal={name} signum={signum}")
        traceback.print_stack(frame, file=diag_log or sys.stderr)
        if diag_log is not None:
            diag_log.flush()
        raise SystemExit(128 + signum)

    for signum in (signal.SIGHUP, signal.SIGTERM, signal.SIGINT, signal.SIGQUIT):
        signal.signal(signum, handler)


def run_server(args, session_id, message_counter, pid):
    with open(args.log, "w", encoding="utf-8") as log:
        log.write("timestamp,event,session_id,pid,message_counter,detail\n")
        log.flush()

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as listener:
            listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            listener.bind((args.host, args.port))
            listener.listen(1)
            log_event(log, "LISTENING", session_id, pid, message_counter, f"{args.host}:{args.port}")
            log_diag(f"LISTENING fd={listener.fileno()} address={args.host}:{args.port}")
            print(
                f"server listening on {args.host}:{args.port} "
                f"session_id={session_id} pid={pid}",
                flush=True,
            )

            while True:
                log_diag("ACCEPT_WAIT")
                conn, addr = listener.accept()
                with conn:
                    log_event(
                        log,
                        "ACCEPTED",
                        session_id,
                        pid,
                        message_counter,
                        f"client={addr[0]}:{addr[1]} fd={conn.fileno()}",
                    )
                    log_diag(f"ACCEPTED client={addr[0]}:{addr[1]} fd={conn.fileno()}")
                    print(f"accepted client {addr}", flush=True)

                    while True:
                        try:
                            data = conn.recv(4096)
                            if not data:
                                log_event(
                                    log,
                                    "CLIENT_CLOSED",
                                    session_id,
                                    pid,
                                    message_counter,
                                    "empty_recv",
                                )
                                log_diag("CLIENT_CLOSED empty_recv; leaving connection loop")
                                print(
                                    "client closed connection; waiting for another client",
                                    flush=True,
                                )
                                break

                            message_counter += 1
                            request = data.decode(errors="replace").strip()
                            response = (
                                f"session_id={session_id} pid={pid} "
                                f"message_counter={message_counter} received={request}\n"
                            )
                            conn.sendall(response.encode())
                            log_event(log, "REPLY", session_id, pid, message_counter, request)
                            print(response.strip(), flush=True)
                        except BaseException:
                            log_diag(
                                f"LOOP_EXCEPTION message_counter={message_counter} "
                                f"client={addr[0]}:{addr[1]}"
                            )
                            traceback.print_exc(file=diag_log)
                            diag_log.flush()
                            raise


def main():
    global diag_log

    parser = argparse.ArgumentParser(
        description="TCP server for cross-machine CRIU established TCP tests."
    )
    parser.add_argument("--host", default="192.168.64.50")
    parser.add_argument("--port", type=int, default=7004)
    parser.add_argument("--log", default="logs/server_events.csv")
    parser.add_argument("--diag-log", default="logs/server_diagnostics.log")
    args = parser.parse_args()

    session_id = str(uuid.uuid4())
    message_counter = 0
    pid = os.getpid()

    with open(args.diag_log, "w", encoding="utf-8") as diag:
        diag_log = diag
        faulthandler.enable(file=diag_log, all_threads=True)
        install_signal_handlers()
        atexit.register(lambda: log_diag("ATEXIT process exiting"))
        log_diag(
            f"SERVER_START pid={pid} ppid={os.getppid()} "
            f"session_id={session_id} host={args.host} port={args.port}"
        )

        try:
            run_server(args, session_id, message_counter, pid)
        except BaseException:
            log_diag("UNHANDLED_EXCEPTION_BEGIN")
            traceback.print_exc(file=diag_log)
            diag_log.flush()
            log_diag("UNHANDLED_EXCEPTION_END")
            raise


if __name__ == "__main__":
    main()
