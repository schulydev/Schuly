#!/usr/bin/env bash
# Lists the text and clickable nodes on the emulator screen with their bounds, to find tap coordinates for capture.sh.
# Usage: tools/store-screenshots/ui.sh   (EMU_PORT=5580 by default)
export MSYS_NO_PATHCONV=1
SERIAL="emulator-${EMU_PORT:-5580}"
adb -s "$SERIAL" shell uiautomator dump /sdcard/ui.xml >/dev/null 2>&1
adb -s "$SERIAL" exec-out cat /sdcard/ui.xml | python -c "
import sys, re
x = sys.stdin.read()
for m in re.finditer(r'<node [^>]*>', x):
    n = m.group(0)
    g = lambda k: (re.search(k + '=\"([^\"]*)\"', n) or [None, ''])[1]
    t = g('text') or g('content-desc')
    if t or g('clickable') == 'true':
        print(repr(t[:60]), g('clickable'), g('bounds'))
"
