#!/usr/bin/env bash
# Captures the app screenshots on an Android emulator against the fake API, then frames them.
# Usage: tools/store-screenshots/capture.sh <step>...   (run from the repo root; steps: avd boot build prepare login shoot frame cleanup, or all)
# DRY_RUN=1 prints the commands instead of running them.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
OUT="${OUT:-$HERE/out}"
AVD="${AVD:-SchulyShots_Pixel8_API35}"
IMAGE="${IMAGE:-system-images;android-35;google_apis;x86_64}"
PORT="${EMU_PORT:-5580}"
SERIAL="emulator-$PORT"
API_PORT="${API_PORT:-5591}"
PKG=com.schuly.app.dev
CLOCK="${CLOCK:-110609412026.00}" # MMDDhhmmYYYY.ss: Fri 6.11.2026, 09:41
PY="${PY:-$HERE/.venv/Scripts/python}"; [ -x "$PY" ] || PY="$HERE/.venv/bin/python"

run() { if [ -n "${DRY_RUN:-}" ]; then echo "+ $*"; else "$@"; fi; }
# MSYS_NO_PATHCONV stops Git Bash on Windows from rewriting device paths such as /sdcard/... for adb.
adbs() { if [ -n "${DRY_RUN:-}" ]; then echo "+ adb -s $SERIAL $*"; else MSYS_NO_PATHCONV=1 adb -s "$SERIAL" "$@"; fi; }
quiet() { if [ -n "${DRY_RUN:-}" ]; then adbs "$@"; else adbs "$@" >/dev/null; fi; }
demo() { quiet shell am broadcast -a com.android.systemui.demo -e command "$@"; }
tap() { adbs shell input tap "$1" "$2"; sleep "${3:-1.5}"; }
tab() { tap "$1" 2256; } # bottom navigation: 118 home, 330 timetable, 540 grades, 750 absences, 961 account

# Resets the clock and status bar, then saves a 1080x2400 PNG.
shot() {
  quiet shell date "$CLOCK"
  demo network -e wifi show -e level 4 -e fully true
  demo network -e mobile hide
  demo clock -e hhmm 0941
  demo notifications -e visible false
  sleep "${WAIT:-1}"
  mkdir -p "$OUT/raw"
  if [ -n "${DRY_RUN:-}" ]; then echo "+ adb -s $SERIAL exec-out screencap -p > $OUT/raw/$1.png"; else MSYS_NO_PATHCONV=1 adb -s "$SERIAL" exec-out screencap -p > "$OUT/raw/$1.png"; fi
  echo "saved $1"
}

step_avd() {
  # Pixel 8 (1080x2400, 420 dpi) on API 35 with Google APIs, so adb root works for setting the clock.
  run sdkmanager "$IMAGE"
  if [ -n "${DRY_RUN:-}" ]; then echo "+ echo no | avdmanager create avd -n $AVD -k $IMAGE -d pixel_8"; else echo no | avdmanager create avd -n "$AVD" -k "$IMAGE" -d pixel_8; fi
  local cfg="$HOME/.android/avd/$AVD.avd/config.ini"
  run sed -i 's/^hw.ramSize=.*/hw.ramSize=2048/; s/^hw.keyboard=.*/hw.keyboard=yes/; s/^hw.gpu.enabled=.*/hw.gpu.enabled=yes/' "$cfg"
}

step_boot() {
  if [ -n "${DRY_RUN:-}" ]; then echo "+ emulator -avd $AVD -port $PORT -no-snapshot -no-boot-anim -gpu host -memory 2048 &"; else emulator -avd "$AVD" -port "$PORT" -no-snapshot -no-boot-anim -gpu host -memory 2048 >"$OUT/emulator.log" 2>&1 & fi
  adbs wait-for-device
  [ -n "${DRY_RUN:-}" ] && return
  until [ "$(adb -s "$SERIAL" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do sleep 3; done
  echo booted
}

step_build() {
  # Dev flavor, release mode, pointed at the fake API through the emulator's host alias.
  (cd "$ROOT" && run flutter build apk --flavor dev --release --target-platform android-x64 --dart-define=BACKEND_BASE_URL="http://10.0.2.2:$API_PORT")
}

step_prepare() {
  quiet root; sleep 3
  adbs install -r "$ROOT/build/app/outputs/flutter-apk/app-dev-release.apk"
  adbs shell settings put global auto_time 0
  adbs shell settings put global auto_time_zone 0
  adbs shell cmd alarm set-timezone Europe/Zurich
  adbs shell setprop persist.sys.timezone Europe/Zurich
  adbs shell date "$CLOCK"
  adbs shell settings put system time_12_24 24
  adbs shell cmd uimode night yes
  adbs shell settings put global sysui_demo_allowed 1
  demo enter
  demo battery -e level 100 -e plugged false
}

step_login() {
  # Coordinates are for the Pixel 8 screen. If the app's onboarding changed, find the new ones with ui.sh.
  quiet shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1; sleep 10
  for _ in 1 2 3 4; do tap 540 2238 1.2; done # through the onboarding pages
  tap 540 850 0.5; tap 540 2240              # account mode, continue
  tap 540 1764                               # pick the school system
  tap 540 790 0.5; adbs shell input text mia.muster
  tap 540 990 0.5; adbs shell input text Beispiel2026
  adbs shell input keyevent 111; sleep 0.5   # hide the keyboard
  tap 540 1147 5                             # sign in (the fake API accepts any login)
}

step_shoot() {
  adbs shell am force-stop "$PKG"
  quiet shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1; sleep 7
  shot home-dark
  tab 540; shot grades-dark
  tab 750; shot absences-dark
  tab 961; WAIT=2 shot account-dark
  # Timetable on Tue 10.11.: swipe the date strip one week on, then tap the day.
  tab 330
  adbs shell input swipe 900 430 300 430 300; sleep 1.5
  tap 326 430 1.2; shot agenda-dark
}

step_frame() {
  mkdir -p "$OUT/framed"
  for p in "home-dark start" "agenda-dark agenda" "grades-dark grades" "absences-dark absences" "account-dark account"; do
    set -- $p
    run "$PY" "$HERE/frame.py" "$OUT/raw/$1.png" "$OUT/framed/schuly-$2-page-v2.png" "$OUT/framed/schuly-$2-page-v2.webp"
  done
}

step_cleanup() {
  adbs emu kill || true
  run avdmanager delete avd -n "$AVD"
}

[ $# -gt 0 ] || { sed -n '2,4p' "$0"; exit 1; }
[ "$1" = all ] && set -- avd boot build prepare login shoot frame
mkdir -p "$OUT"
for s in "$@"; do "step_$s"; done
