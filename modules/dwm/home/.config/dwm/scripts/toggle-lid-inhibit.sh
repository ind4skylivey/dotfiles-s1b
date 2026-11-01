#!/usr/bin/env bash
set -euo pipefail

if pgrep -f "systemd-inhibit --what=handle-lid-switch --who=dwm" >/dev/null; then
  pkill -f "systemd-inhibit --what=handle-lid-switch --who=dwm"
  dunstify -r 9997 -u low "Lid action" "Laptop lid follows default behavior"
else
  systemd-inhibit --what=handle-lid-switch --who=dwm --why="Docked / external monitors" sleep infinity &
  dunstify -r 9997 -u low "Lid action" "Lid switch inhibited (docked)"
fi
