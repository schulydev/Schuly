#!/usr/bin/env bash
# Captures the app screenshots on an Android emulator against the fake API, then frames them.
# Usage: tools/store-screenshots/capture.sh <step>...   (run from the repo root; steps: avd boot build prepare login shoot frame cleanup, or all)
# DRY_RUN=1 prints the commands instead of running them.
set -euo pipefail

# pwd -W gives C:/... paths in Git Bash, which adb needs because MSYS_NO_PATHCONV stops the path rewriting.
HERE="$(cd "$(dirname "$0")" && (pwd -W 2>/dev/null || pwd))"
ROOT="$(cd "$HERE/../.." && (pwd -W 2>/dev/null || pwd))"
OUT="${OUT:-$HERE/out}"
AVD="${AVD:-SchulyShots_Pixel8_API35}"
IMAGE="${IMAGE:-system-images;android-35;google_apis;x86_64}"
PORT="${EMU_PORT:-5580}"
SERIAL="emulator-$PORT"
API_PORT="${API_PORT:-5591}"
PKG=com.schuly.app.dev
CLOCK="${CLOCK:-110609412026.00}" # MMDDhhmmYYYY.ss: Fri 6.11.2026, 09:41
PY="${PY:-$HERE/.venv/Scripts/python}"; [ -x "$PY" ] || PY="$HERE/.venv/bin/python"
FLUTTER="${FLUTTER:-flutter}"
LOCALE="${LOCALE:-en}"            # the website shows the English app; login and shoot find buttons by their English labels
TT_DAY="${TT_DAY:-November 10, 2026}" # the day the timetable shot shows
SUFFIX="${SUFFIX:-v3}"            # name suffix of the framed files; bump it whenever the images change

run() { if [ -n "${DRY_RUN:-}" ]; then echo "+ $*"; else "$@"; fi; }
# MSYS_NO_PATHCONV stops Git Bash on Windows from rewriting device paths such as /sdcard/... for adb.
adbs() { if [ -n "${DRY_RUN:-}" ]; then echo "+ adb -s $SERIAL $*"; else MSYS_NO_PATHCONV=1 adb -s "$SERIAL" "$@"; fi; }
quiet() { if [ -n "${DRY_RUN:-}" ]; then adbs "$@"; else adbs "$@" >/dev/null; fi; }
demo() { quiet shell am broadcast -a com.android.systemui.demo -e command "$@"; }

# Prints the centre "x y" of an on-screen node, found in a uiautomator dump.
# $1 is a regex matched against the node's text or content-desc (Flutter puts its semantics labels there, lines joined by \n).
# $2 picks the match: 1 is the first, -1 (the default) the last, which is the bottom navigation when a label is on the page too.
# $3 limits the search to one class, such as EditText.
find_ui() {
  MSYS_NO_PATHCONV=1 adb -s "$SERIAL" shell uiautomator dump /sdcard/ui.xml >/dev/null 2>&1 || return 1
  MSYS_NO_PATHCONV=1 adb -s "$SERIAL" exec-out cat /sdcard/ui.xml | "$PY" -c '
import html, re, sys
pat, nth, cls = re.compile(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
hits = []
for n in re.findall(r"<node [^>]*>", sys.stdin.read()):
    g = lambda k: html.unescape((re.search(k + "=\"([^\"]*)\"", n) or [0, ""])[1])
    if cls and not g("class").endswith(cls): continue
    if not pat.search(g("text") or g("content-desc")): continue
    x1, y1, x2, y2 = map(int, re.findall(r"\d+", g("bounds")))
    hits.append(f"{(x1 + x2) // 2} {(y1 + y2) // 2}")
if not hits or abs(nth) > len(hits) or nth == 0: sys.exit(1)
print(hits[nth - 1 if nth > 0 else nth])
' "$1" "${2:--1}" "${3:-}"
}

# Taps the node find_ui finds for $1 (trying up to 20 times; a dump can take 10 s while the app animates), then waits $2 seconds (1.5 by default).
# $3 and $4 are passed on to find_ui as the match number and class.
tap_ui() {
  if [ -n "${DRY_RUN:-}" ]; then echo "+ tap '$1'"; return; fi
  local xy="" i
  for i in $(seq 20); do xy="$(find_ui "$1" "${3:--1}" "${4:-}")" && break; sleep 1; done
  [ -n "$xy" ] || { echo "not on screen: $1 (run ui.sh to see what is)" >&2; exit 1; }
  adbs shell input tap $xy; sleep "${2:-1.5}"
}
has_ui() { [ -n "${DRY_RUN:-}" ] || find_ui "$@" >/dev/null; }
tab() { tap_ui "^$1(\$|\n)" 2; } # bottom navigation: Home, Timetable, Grades, Absences, Account

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
  # Dev flavor (the prod flavor blocks plain HTTP to the fake API), pointed at it through the emulator's host alias.
  # Release mode, because a debug build draws Flutter's DEBUG ribbon over the corner of every screen.
  (cd "$ROOT" && run "$FLUTTER" build apk --flavor dev --release --target-platform android-x64 --dart-define=BACKEND_BASE_URL="http://10.0.2.2:$API_PORT")
}

step_prepare() {
  quiet root; sleep 3
  adbs install -r "$ROOT/build/app/outputs/flutter-apk/app-dev-release.apk"
  # Start from nothing: no sign-in, default accent and theme settings.
  adbs shell pm clear "$PKG"
  adbs shell cmd locale set-app-locales "$PKG" --locales "$LOCALE"
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
  # Finds the buttons by their labels, so the app has to be in English (LOCALE=en).
  quiet shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1
  tap_ui '^Next$' 1.2                                        # welcome
  for _ in 1 2 3 4 5 6; do has_ui '^Which server\?' && break; tap_ui '^Next$' 1.2; done # the intro pages
  tap_ui '^Schuly Cloud' 0.5; tap_ui '^Next$' 1.2             # BACKEND_BASE_URL stands in for the cloud
  tap_ui '^Schuly account' 0.5; tap_ui '^Next$' 1.5
  tap_ui '^I already have an account$'
  tap_ui '' 0.5 1 EditText; adbs shell input text mia.muster@bfs-beispielstadt.ch
  tap_ui '' 0.5 2 EditText; adbs shell input text Beispiel2026
  adbs shell input keyevent 111; sleep 0.5                  # hide the keyboard
  tap_ui '^Continue$' 3                                      # the fake API accepts any login
  tap_ui '^Home$' 1                                          # waits for the home screen
}

step_shoot() {
  adbs shell am force-stop "$PKG"
  quiet shell date "$CLOCK"
  quiet shell monkey -p "$PKG" -c android.intent.category.LAUNCHER 1
  tab Home; sleep 3; shot home-dark
  # Timetable on Tue 10.11.: the date carousel starts at today, so swipe it on until the day is there.
  tab Timetable
  for _ in 1 2 3; do has_ui "^$TT_DAY" && break; adbs shell input swipe 900 530 300 530 300; sleep 1; done
  tap_ui "^$TT_DAY" 1.5; shot agenda-dark
  tab Grades; shot grades-dark
  tab Account; WAIT=2 shot account-dark
  tab Absences; shot absences-dark
}

step_frame() {
  mkdir -p "$OUT/framed"
  for p in "home-dark start" "agenda-dark agenda" "grades-dark grades" "absences-dark absences" "account-dark account"; do
    set -- $p
    run "$PY" "$HERE/frame.py" "$OUT/raw/$1.png" "$OUT/framed/schuly-$2-page-$SUFFIX.png" "$OUT/framed/schuly-$2-page-$SUFFIX.webp"
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
