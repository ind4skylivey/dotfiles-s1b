#!/usr/bin/env bash
set -euo pipefail

if pgrep -x gammastep >/dev/null; then
  pkill -x gammastep
  dunstify -r 9993 -u low "Night light" "Disabled"
else
  gammastep -O 4500 -l 0:0 >/dev/null 2>&1 &
  dunstify -r 9993 -u low "Night light" "Enabled (4500K)"
fi
