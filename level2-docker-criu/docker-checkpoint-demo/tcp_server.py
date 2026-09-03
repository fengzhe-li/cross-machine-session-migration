import socket
import threading
import time

HOST = "0.0.0.0"
PORT = 7002

counter = 0
lock = threading.Lock()


def tick_counter():
    global counter

    while True:
        time.sleep(1)

        with lock:
            counter += 1
            current = counter

        print(f"Runtime counter: {current}", flush=True)


threading.Thread(target=tick_counter, daemon=True).start()

print(f"Docker TCP server listening on {HOST}:{PORT}", flush=True)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen()

    while True:
        conn, addr = server.accept()

        with conn:
            data = conn.recv(1024).decode().strip()

            if not data:
                continue

            with lock:
                current = counter

            reply = f"Docker restored server handled {data}, runtime_counter={current}"

            print(reply, flush=True)

            conn.sendall(reply.encode())
