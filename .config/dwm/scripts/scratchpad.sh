#!/usr/bin/env bash
set -euo pipefail

CLASS="scratchpad"
TITLE="scratchpad"

wid=$(xdotool search --classname "$CLASS" 2>/dev/null | head -n1 || true)

if [[ -z "$wid" ]]; then
  kitty --class "$CLASS" --title "$TITLE" --name "$TITLE" --detach --hold >/dev/null 2>&1 &
  sleep 0.2
  wid=$(xdotool search --classname "$CLASS" 2>/dev/null | head -n1 || true)
fi

if [[ -z "$wid" ]]; then
  dunstify -r 9996 -u low "Scratchpad" "Failed to launch kitty"
  exit 1
fi

mapped_state=$(xwininfo -id "$wid" | awk '/Map State:/ {print $3}')

if [[ "$mapped_state" == "IsUnMapped" ]]; then
  xdotool windowmap "$wid"
  xdotool windowactivate "$wid"
else
  xdotool windowunmap "$wid"
fi
