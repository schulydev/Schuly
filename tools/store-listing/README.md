# Store listing

The images and texts for the Google Play and App Store listings. The images in `out/` are committed, so they can be uploaded without running anything.

| File | What it is |
|---|---|
| `listing.md` | The listing texts in German and English: Play short description, App Store subtitle, promotional text and keywords, the description, "What's new", and the URLs. |
| `make.py` | Builds everything in `out/` from `assets/app_icon.png`, the Geist fonts in `assets/fonts/` and the raw screenshots of `tools/store-screenshots`. |
| `check.py` | Checks the texts in `listing.md` against the store limits (and that there is no "ß"), and every image in `out/` against its store size. |

## Output

| Path | Store | Size |
|---|---|---|
| `out/play/icon-512.png` | Play app icon | 512×512, no transparency: the icon's rounded corners are filled with its own blue, Play rounds them itself |
| `out/play/feature-graphic-{de,en}.png` | Play feature graphic | 1024×500 |
| `out/play/{de,en}/0N-<page>.png` | Play phone screenshots | 1200×2400: the raw 1080×2400 shot widened with the page's own edge colours, since Play allows at most 2:1 |
| `out/apple/{de,en}/0N-<page>.png` | App Store iPhone 6.9" screenshots | 1320×2868: the raw shot without the Android status bar (top 96 px) and gesture bar (bottom 63 px), scaled up without distortion and filled to size with the page's own top and bottom colours |

The App Store has no iPhone shots of its own because there is no Mac to run the iOS simulator; the Android shots without the system bars show the same Flutter screens.

## Regenerate

1. Take the raw shots in English and German with `tools/store-screenshots` (see its README):

   ```sh
   tools/store-screenshots/capture.sh all
   LOCALE=de tools/store-screenshots/capture.sh shoot
   tools/store-screenshots/capture.sh cleanup
   ```

2. Build and check the images, with the virtual environment of `tools/store-screenshots`:

   ```sh
   cd tools/store-listing
   ../store-screenshots/.venv/Scripts/python make.py    # on macOS/Linux: .venv/bin/python
   ../store-screenshots/.venv/Scripts/python check.py
   ```

`make.py --status-bar PX --nav-bar PX` changes how much it cuts off for the App Store shots, if the emulator is not the Pixel 8 AVD that `capture.sh` creates.
