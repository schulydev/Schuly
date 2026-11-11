"""Builds the Google Play and App Store listing images from the app icon and the raw emulator screenshots.

Usage: python make.py [--status-bar PX] [--nav-bar PX]
Reads assets/app_icon.png and tools/store-screenshots/out/raw (English) and raw-de (German),
writes to tools/store-listing/out/.
"""
import argparse
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
ICON = ROOT / "assets" / "app_icon.png"
FONTS = ROOT / "assets" / "fonts"
SHOTS = ROOT / "tools" / "store-screenshots" / "out"
OUT = HERE / "out"

# Dark tokens from lib/ui/core/theme/schuly_theme.dart, and the icon's blue (pubspec's background_color_ios).
BACKGROUND = (0x0A, 0x0A, 0x0A)
FOREGROUND = (0xFA, 0xFA, 0xFA)
MUTED = (0xA1, 0xA1, 0xA1)
BLUE = (0x21, 0x98, 0xFE)

# The store order: what a student opens the app for first.
PAGES = ["home-dark", "agenda-dark", "grades-dark", "absences-dark", "account-dark"]
LANGS = {"en": "raw", "de": "raw-de"}
TAGLINE = {
    "en": ("Grades, absences and timetable", "for Swiss students, in one app."),
    "de": ("Noten, Absenzen und Stundenplan", "für Lernende in der Schweiz, in einer App."),
}

PLAY_SIZE = (1200, 2400)  # Play allows at most 2:1, the raw 1080x2400 is 2.22:1
APPLE_SIZE = (1320, 2868)  # iPhone 6.9"
APPLE_63_SIZE = (1206, 2622)  # "iPhone mit Dynamic Island (mittleres Display)", the slot App Store Connect asks for first
HEADER_SIZE = (3840, 1646)  # App Store product page header ("Kopfzeile")


def font(weight, size):
    return ImageFont.truetype(str(FONTS / f"Geist-{weight}.ttf"), size)


def opaque_icon(size):
    """The icon as a full square: its transparent rounded corners are filled with the icon's own edge colours."""
    icon = Image.open(ICON).convert("RGBA")
    side = max(icon.size)
    square = Image.new("RGBA", (side, side), (0, 0, 0, 0))
    square.paste(icon, ((side - icon.width) // 2, (side - icon.height) // 2))
    # Only the fully opaque inside, about 12 px in from the anti-aliased rim and its shading.
    inside = square.getchannel("A").point(lambda a: 255 if a == 255 else 0)
    for _ in range(3):
        inside = inside.filter(ImageFilter.MinFilter(9))
    # The inside's colours, blurred and divided by the blurred coverage, give the gradient behind the corners.
    rgb = np.asarray(square.convert("RGB"), dtype=np.float32) * (np.asarray(inside, dtype=np.float32)[..., None] / 255)
    blur = lambda a: np.asarray(Image.fromarray(a).filter(ImageFilter.GaussianBlur(side // 8)), dtype=np.float32)
    cover = blur(np.asarray(inside))
    fill = np.stack([blur(rgb[..., c].astype(np.uint8)) for c in range(3)], -1) / np.maximum(cover, 1)[..., None] * 255
    out = Image.fromarray(np.clip(fill, 0, 255).astype(np.uint8))
    out.paste(square.convert("RGB"), (0, 0), inside.filter(ImageFilter.GaussianBlur(6)))
    return out.resize((size, size), Image.LANCZOS)


def play_icon():
    out = OUT / "play" / "icon-512.png"
    opaque_icon(512).save(out, optimize=True)
    print(out)


def feature_graphic(lang):
    w, h = 1024, 500
    img = Image.new("RGB", (w, h), BACKGROUND)
    # A soft blue glow behind the icon.
    glow = Image.new("L", (w, h), 0)
    ImageDraw.Draw(glow).ellipse((-40, 20, 460, 520), fill=110)
    glow = glow.filter(ImageFilter.GaussianBlur(120))
    img = Image.composite(Image.new("RGB", (w, h), BLUE), img, glow)

    icon = Image.open(ICON).convert("RGBA").resize((220, 219), Image.LANCZOS)
    img.paste(icon, (100, (h - icon.height) // 2), icon)

    d = ImageDraw.Draw(img)
    x = 370
    d.text((x, 150), "Schuly", font=font("Bold", 110), fill=FOREGROUND)
    line1, line2 = TAGLINE[lang]
    d.text((x, 292), line1, font=font("Medium", 34), fill=FOREGROUND)
    d.text((x, 338), line2, font=font("Regular", 30), fill=MUTED)

    out = OUT / "play" / f"feature-graphic-{lang}.png"
    img.save(out, optimize=True)
    print(out)


def pad_edges(img, size, top_share=0.5):
    """Puts img in the middle of size, filling the margins by repeating its edge pixels, so the page background carries on."""
    w, h = size
    left, top = (w - img.width) // 2, round((h - img.height) * top_share)
    out = Image.new("RGB", size)
    out.paste(img, (left, top))
    if left:
        out.paste(img.crop((0, 0, 1, img.height)).resize((left, img.height)), (0, top))
        right = w - left - img.width
        out.paste(img.crop((img.width - 1, 0, img.width, img.height)).resize((right, img.height)), (left + img.width, top))
    if top:
        out.paste(out.crop((0, top, w, top + 1)).resize((w, top)), (0, 0))
    bottom = h - top - img.height
    if bottom:
        out.paste(out.crop((0, top + img.height - 1, w, top + img.height)).resize((w, bottom)), (0, top + img.height))
    return out


def screenshots(lang, status_bar, nav_bar):
    src = SHOTS / LANGS[lang]
    play_dir, apple_dir = OUT / "play" / lang, OUT / "apple" / lang
    play_dir.mkdir(parents=True, exist_ok=True)
    apple_dir.mkdir(parents=True, exist_ok=True)
    for i, page in enumerate(PAGES, 1):
        shot = Image.open(src / f"{page}.png").convert("RGB")
        name = f"{i:02d}-{page.removesuffix('-dark')}.png"

        # Play: the whole Android screen, widened to 2:1.
        pad_edges(shot, PLAY_SIZE).save(play_dir / name, optimize=True)

        # App Store: without the Android status and navigation bars, scaled to the iPhone width without distortion,
        # the leftover height filled with the page's own top and bottom colours (more on top, where iOS has its status bar).
        app = shot.crop((0, status_bar, shot.width, shot.height - nav_bar))
        scale = min(APPLE_SIZE[0] / app.width, APPLE_SIZE[1] / app.height)
        app = app.resize((round(app.width * scale), round(app.height * scale)), Image.LANCZOS)
        pad_edges(app, APPLE_SIZE, top_share=0.6).save(apple_dir / name, optimize=True)
        print(play_dir / name, apple_dir / name)


def apple_63(lang):
    """The 6.3" iPhone screenshots: the 6.9" ones scaled down (both are 9:19.5, so nothing is cut or padded)."""
    src, dst = OUT / "apple" / lang, OUT / "apple-6.3" / lang
    dst.mkdir(parents=True, exist_ok=True)
    for f in sorted(src.glob("*.png")):
        Image.open(f).convert("RGB").resize(APPLE_63_SIZE, Image.LANCZOS).save(dst / f.name, optimize=True)
        print(dst / f.name)


def header(lang):
    """The App Store header banner: the feature graphic scaled to the banner height, its edges carried on to the full width."""
    graphic = Image.open(OUT / "play" / f"feature-graphic-{lang}.png").convert("RGB")
    h = HEADER_SIZE[1]
    graphic = graphic.resize((round(graphic.width * h / graphic.height), h), Image.LANCZOS)
    out = OUT / "apple" / f"header-{lang}.png"
    pad_edges(graphic, HEADER_SIZE).save(out, optimize=True)
    print(out)


def images_only():
    (OUT / "play").mkdir(parents=True, exist_ok=True)
    play_icon()
    for lang in LANGS:
        feature_graphic(lang)
        header(lang)
        if (OUT / "apple" / lang).exists():
            apple_63(lang)


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    # The Pixel 8 AVD's bars in px. dumpsys window gives a 74 px statusBars inset, but the clock's glyphs reach row 82,
    # so the cut is a little lower; the app's own content starts below row 180. The gesture bar is the bottom 63 px.
    ap.add_argument("--status-bar", type=int, default=96)
    ap.add_argument("--nav-bar", type=int, default=63)
    args = ap.parse_args()
    (OUT / "play").mkdir(parents=True, exist_ok=True)
    play_icon()
    for lang in LANGS:
        feature_graphic(lang)
        screenshots(lang, args.status_bar, args.nav_bar)
        apple_63(lang)
        header(lang)
