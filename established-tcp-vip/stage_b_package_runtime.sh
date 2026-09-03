#!/usr/bin/env bash
set -euo pipefail

PID="${1:?usage: stage_b_package_runtime.sh <pid> <output-dir>}"
OUT_DIR="${2:?usage: stage_b_package_runtime.sh <pid> <output-dir>}"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR/rootfs"

python3 - "$PID" "$OUT_DIR" <<'PY'
import os
import shutil
import sys
from pathlib import Path

pid = sys.argv[1]
out_dir = Path(sys.argv[2])
rootfs = out_dir / "rootfs"
manifest = out_dir / "manifest.txt"

paths = set()
maps_path = Path(f"/proc/{pid}/maps")

for line in maps_path.read_text(encoding="utf-8").splitlines():
    parts = line.split(maxsplit=5)
    if len(parts) < 6:
        continue
    path = parts[5]
    if not path.startswith("/"):
        continue
    if " (deleted)" in path:
        continue
    if os.path.isfile(path):
        paths.add(path)

copied = []
for path in sorted(paths):
    src = Path(path)
    dest = rootfs / path.lstrip("/")
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)
    copied.append(path)

manifest.write_text("\n".join(copied) + "\n", encoding="utf-8")
print(f"Packaged {len(copied)} mapped runtime files for PID {pid}")
print(f"Manifest: {manifest}")
PY
