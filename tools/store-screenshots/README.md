# Store screenshots

Takes the app screenshots on an Android emulator and frames them in a Pixel phone. The website uses the five framed images: `public/assets/schuly-{start,agenda,grades,absences,account}-page-v3.{png,webp}` in SchulyWebsite. The same raw shots can go into store listings.

The app runs against a fake API with made-up data (Mia Muster, Berufsfachschule Beispielstadt), so no real account or school is involved.

| File | What it does |
|---|---|
| `fake-api/server.ts` | Bun server that answers the app's `/auth` and `/api` calls with fixed data on port 5591 (`PORT=` to change). It accepts any sign-in. `EXTRAS=1` adds what the store shots leave out: Schulnetz approval fields on absences, a linked Microsoft account with an Outlook week, the other providers, a Microsoft sign-in button, a changeable profile picture, and pictures that answer 401 without a bearer token, as the server does. `MIN_APP_VERSION=3.6.0` asks older apps to update (`/api/app` names it, other calls answer 426); with `MIN_APP_VERSION_426_ONLY=1` only the 426 answers do. |
| `fake-api/avatar.py` | Draws the made-up profile picture `fake-api/static/mia.jpg` (already committed). |
| `capture.sh` | Emulator, build, sign-in, capture and framing steps. |
| `ui.sh` | Lists the on-screen elements, their labels and bounds, for when a label `capture.sh` looks for has changed. |
| `frame.py` | Puts a 1080×2400 screenshot into the Pixel 9 Pro XL device art and scales it to 660×1394. |
| `deviceart/` | The device art (`back.webp`, 100 kB) and its licence. |

## Prerequisites

- Bun.
- Flutter, as for building the app.
- The Android SDK with `sdkmanager`, `avdmanager`, `emulator` and `adb` on `PATH`, and hardware acceleration for the emulator.
- Python 3 with a virtual environment for the framing:

  ```sh
  cd tools/store-screenshots
  python -m venv .venv
  .venv/Scripts/pip install -r requirements.txt   # on macOS/Linux: .venv/bin/pip
  ```

- A bash shell. On Windows, use Git Bash.

## Regenerate

Run these from the repo root. Start the fake API in its own terminal and leave it running:

```sh
bun tools/store-screenshots/fake-api/server.ts
```

Then run the steps, all at once or one by one:

```sh
tools/store-screenshots/capture.sh all        # avd boot build prepare login shoot frame
tools/store-screenshots/capture.sh cleanup    # stop the emulator and delete the AVD
```

| Step | What it does |
|---|---|
| `avd` | Creates `SchulyShots_Pixel8_API35`: a Pixel 8 (1080×2400) with `system-images;android-35;google_apis;x86_64`, 2 GB RAM. The Google APIs image is needed because `adb root` must work to set the clock. |
| `boot` | Starts it on port 5580 (`emulator-5580`) with `-no-snapshot -gpu host -memory 2048` and waits for the boot to finish. |
| `build` | `flutter build apk --flavor dev --release --target-platform android-x64 --dart-define=BACKEND_BASE_URL=http://10.0.2.2:5591`. `10.0.2.2` is how the emulator reaches the host. It has to be the dev flavor, because the prod flavor blocks plain HTTP, and release mode, because a debug build draws Flutter's DEBUG ribbon on every screen. |
| `prepare` | Installs the APK, clears the app's data (sign-in, accent colour, theme), sets the app language to English, turns off automatic time, sets the timezone to Europe/Zurich, the clock to Fri 6.11.2026 09:41 and 24-hour format, turns dark mode on and enters the status bar demo mode. |
| `login` | Taps through onboarding (Schuly Cloud, Schuly account, I already have an account) and signs in as Mia Muster. |
| `shoot` | Restarts the app, then saves home, the timetable on Tue 10.11. (day view with the date carousel), grades, account and absences to `out/raw/*.png` with `adb exec-out screencap`. Before each shot it resets the clock to 09:41, full Wi-Fi, no mobile signal and no notifications. |
| `frame` | Writes `out/framed/schuly-<page>-page-<SUFFIX>.png` and `.webp` (`SUFFIX=v3` by default). |

Copy `out/framed/*` to SchulyWebsite's `public/assets/`. If the images change, give them a new name suffix (`SUFFIX=v4`) and update the references, so that caches load the new ones. The hero phone image on the website is `out/raw/home-dark.png`; see SchulyWebsite's `tools/hero-images`.

Settings you can override with environment variables: `AVD`, `IMAGE`, `EMU_PORT` (use `EMU_PORT=5554` to run on an emulator that is already up, skipping `avd` and `boot`), `API_PORT`, `CLOCK` (`MMDDhhmmYYYY.ss`), `TT_DAY` (the timetable day's label, `November 10, 2026`), `SUFFIX`, `FLUTTER` (the flutter command), `OUT` and `PY`. `DRY_RUN=1` prints every command without running it.

`login` and `shoot` don't tap fixed coordinates: they read the screen with `uiautomator dump` and tap the element whose text or label matches, such as `Next`, `Continue` or the bottom navigation's `Home`, `Timetable`, `Grades`, `Absences` and `Account`. That only works in English, which `prepare` sets. If a step stops with `not on screen`, run `EMU_PORT=5554 tools/store-screenshots/ui.sh` to see the labels and update the one in `capture.sh`. Each dump can take up to 10 s, so `login` and `shoot` take a few minutes. To frame a single screenshot by hand, run `python frame.py <shot.png> <out.png> <out.webp>`.

## Licences

- `deviceart/back.webp` is the Pixel 9 Pro XL device art from the Android Open Source Project / Android Studio, under the Apache License 2.0 (`deviceart/LICENSE.txt`). `frame.py` shortens the frame to the screenshot's aspect ratio. SchulyWebsite credits it in `CREDITS.txt`.
- The fake data and `static/mia.jpg` are made up for these screenshots.
