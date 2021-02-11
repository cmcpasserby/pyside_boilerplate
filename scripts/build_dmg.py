import hashlib
import subprocess


name = "app"
path = f"dist/{name}.dmg"

subprocess.call(["dmgbuild", "-s", "misc/dmgbuild_settings.py", name, path])

print("Hashing (SHA256)...")
hasher = hashlib.sha256()
with open(path, 'rb') as f:
    for block in iter(lambda: f.read(4096), b''):
        hasher.update(block)
print(f"{hasher.hexdigest()} {path}")
