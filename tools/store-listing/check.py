"""Checks the texts in listing.md against the store limits, and the images in out/ against the store sizes.

Usage: python check.py
"""
import re
import sys
from pathlib import Path

from PIL import Image

HERE = Path(__file__).resolve().parent
LIMITS = {"play_short": 80, "apple_subtitle": 30, "apple_promo": 170, "apple_keywords": 100, "description": 4000, "whats_new": 500}
SIZES = {"play/icon-512.png": (512, 512), "play/feature-graphic-*.png": (1024, 500), "play/*/*.png": (1200, 2400), "apple/*/*.png": (1320, 2868)}

text = (HERE / "listing.md").read_text(encoding="utf-8")
bad = 0
for key, body in re.findall(r"<!-- (\w+) -->\n(.*?)\n<!-- /\1 -->", text, re.S):
    limit = LIMITS[key.rsplit("_", 1)[0]]
    ok = len(body) <= limit and "ß" not in body
    bad += not ok
    print(f"{'ok ' if ok else 'BAD'} {key}: {len(body)}/{limit}")

for pattern, size in SIZES.items():
    files = sorted((HERE / "out").glob(pattern))
    for f in files:
        im = Image.open(f)
        ok = im.size == size and im.mode == "RGB"
        bad += not ok
        print(f"{'ok ' if ok else 'BAD'} {f.relative_to(HERE)}: {im.size[0]}x{im.size[1]} {im.mode}, {f.stat().st_size // 1024} kB")
    if not files:
        bad += 1
        print(f"BAD no files for {pattern}")

sys.exit(1 if bad else 0)
