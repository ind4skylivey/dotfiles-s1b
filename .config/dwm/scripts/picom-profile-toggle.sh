#!/usr/bin/env bash
set -euo pipefail

STATE_FILE=/tmp/dwm-picom-profile
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/picom"
TRANSPARENT_CONF="$CONFIG_DIR/picom.conf"
SOLID_CONF="$CONFIG_DIR/picom-solid.conf"

start_picom() {
  local conf="$1"
  pkill -x picom 2>/dev/null || true
  if [[ -f "$conf" ]]; then
    picom -b --config "$conf"
  else
    picom -b
  fi
}

if [[ -f "$STATE_FILE" ]] && grep -q "solid" "$STATE_FILE"; then
  start_picom "$TRANSPARENT_CONF"
  echo "transparent" > "$STATE_FILE"
  dunstify -r 9994 -u low "Compositor" "Transparent profile"
else
  start_picom "$SOLID_CONF"
  echo "solid" > "$STATE_FILE"
  dunstify -r 9994 -u low "Compositor" "Solid profile"
fi
