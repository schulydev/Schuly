"""Frame a 1080x2400 screenshot in the AOSP Pixel 9 Pro XL device art (Apache 2.0), scaled to 660 px wide.

Usage: python frame.py <screenshot.png> <out.png> <out.webp>
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw

ART = Path(__file__).resolve().parent / "deviceart" / "back.webp"  # 1466x3101, screen 1344x2992 at (57, 56)
OUT_W = 660


def phone_frame(src_w, src_h):
    """The device art, shortened in the middle of the body so its screen matches the screenshot's aspect ratio."""
    art = Image.open(ART).convert("RGBA")
    sw = 1344
    sh = round(sw * src_h / src_w)
    cut = 2992 - sh
    a = np.asarray(art)
    if cut > 0:
        a = np.concatenate([a[:1900], a[1900 + cut:]])
    return Image.fromarray(a), (57, 56, sw, sh)


def framed(src, dst_png, dst_webp):
    shot = Image.open(src).convert("RGB")
    frame, (x, y, sw, sh) = phone_frame(*shot.size)
    shot = shot.resize((sw, sh), Image.LANCZOS)
    mask = Image.new("L", (sw * 2, sh * 2), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, sw * 2 - 1, sh * 2 - 1), 216, fill=255)
    mask = mask.resize((sw, sh), Image.LANCZOS)
    out = Image.new("RGBA", frame.size, (0, 0, 0, 0))
    out.paste(shot, (x, y), mask)
    out.alpha_composite(frame)
    fw, fh = out.size
    out = out.resize((OUT_W, round(fh * OUT_W / fw)), Image.LANCZOS)
    out.save(dst_png, optimize=True)
    out.save(dst_webp, "WEBP", quality=85, method=6)
    print(dst_png, out.size)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    framed(*sys.argv[1:4])
