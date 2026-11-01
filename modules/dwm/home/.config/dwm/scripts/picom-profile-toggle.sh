#!/usr/bin/env bash
# Picom Profile Toggle - Switch between FULL and MINIMAL (focus) modes
# Keybind: MODKEY+Shift+C (Super+Shift+c)
# Uses switch-mode.sh for the actual switching logic.
set -euo pipefail

SWITCHER="$HOME/.config/picom/switch-mode.sh"
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/dwm-picom-profile"

if [[ -L "$STATE_FILE" ]]; then
    echo "Refusing to follow symlink" >&2
    exit 1
fi

detect_current_mode() {
    "$SWITCHER" status 2>/dev/null | grep "Current mode:" | awk '{print $NF}'
}

current=$(detect_current_mode)

if [[ "$current" == "minimal" ]]; then
    # Currently minimal -> switch to full
    "$SWITCHER" full
    echo "full" > "$STATE_FILE"
    dunstify -r 9994 -u low "Compositor" "Full mode - all effects on"
else
    # Currently full (or unknown) -> switch to minimal
    "$SWITCHER" minimal
    echo "minimal" > "$STATE_FILE"
    dunstify -r 9994 -u low "Compositor" "Minimal mode - focus, no distractions"
fi
