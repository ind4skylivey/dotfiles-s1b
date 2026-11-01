#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/dwm-xrandr-profile"

if [[ -L "$STATE_FILE" ]]; then
    echo "Refusing to follow symlink" >&2
    exit 1
fi

set_triple() {
  xrandr \
    --fb 1920x1080 \
    --output DisplayPort-0 --primary --mode 1920x1080 --rate 180 \
    --output DisplayPort-1 --mode 1920x1080 --rate 60 --left-of DisplayPort-0 --rotate left --pos 0x0 \
    --output HDMI-A-0 --mode 1920x1080 --rate 60 --above DisplayPort-0 --pos 0x1080 \
    --output eDP --off 2>/dev/null || true
  echo "triple" > "$STATE_FILE"
  dunstify -r 9995 -u low "Display profile" "Triple-monitor layout"
}

set_solo() {
  xrandr \
    --fb 1920x1080 \
    --output DisplayPort-0 --primary --mode 1920x1080 --rate 180 \
    --output DisplayPort-1 --off \
    --output HDMI-A-0 --off \
    --output eDP --off 2>/dev/null || true
  echo "solo" > "$STATE_FILE"
  dunstify -r 9995 -u low "Display profile" "Solo (DisplayPort-0 only)"
}

if [[ -f "$STATE_FILE" ]] && grep -q "solo" "$STATE_FILE"; then
  set_triple
else
  set_solo
fi
