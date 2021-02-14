import os
from pathlib import Path
from PIL import Image

icon_sizes = [(256, 256), (128, 128)]
build_path = "build/ico"
icons = [Path(f"icons/{i}") for i in os.listdir("icons")]

if not os.path.exists(build_path):
    os.mkdir(build_path)

for icon_path in icons:
    img = Image.open(icon_path.absolute())
    new_name = Path(build_path, icon_path.with_suffix(".ico").name)
    img.save(new_name.absolute(), sizes=icon_sizes)
