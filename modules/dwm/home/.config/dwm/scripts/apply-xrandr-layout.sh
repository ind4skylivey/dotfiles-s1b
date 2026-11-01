#!/usr/bin/env bash
set -euo pipefail

dp0="DisplayPort-0"
dp1="DisplayPort-1"
hdmi="HDMI-A-0"

is_connected() {
  xrandr --query | awk -v out="$1" '$1==out {print $2; exit}' | grep -qx "connected"
}

cmd=(xrandr)

if is_connected "$dp0"; then
  cmd+=(--output "$dp0" --primary --mode 1920x1080 --rate 180)
fi

if is_connected "$dp1"; then
  cmd+=(--output "$dp1" --mode 1920x1080 --rate 60 --left-of "$dp0" --rotate left --pos 0x0)
fi

if is_connected "$hdmi"; then
  cmd+=(--output "$hdmi" --mode 1920x1080 --rate 60 --above "$dp0" --pos 0x1080)
fi

"${cmd[@]}"
