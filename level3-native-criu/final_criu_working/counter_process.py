import time

counter = 0

print("Level 3 counter process started.", flush=True)

while True:
    print(f"Counter = {counter}", flush=True)
    counter += 1
    time.sleep(1)

