#!/usr/bin/env bash
# Wrapper to run applications without picom (for problematic apps on multi-monitor)

APPS_WITH_ISSUES=("es-de" "OpenRGB" "retroarch")

if [[ " ${APPS_WITH_ISSUES[@]} " =~ " ${1} " ]]; then
    pkill -x picom 2>/dev/null || true
    sleep 0.3
fi

"$@"

# Wait for the app to close, then restart picom
if [[ " ${APPS_WITH_ISSUES[@]} " =~ " ${1} " ]]; then
    wait $!
    sleep 0.5
    picom -b --config "$HOME/.config/picom/picom.conf" 2>/dev/null &
fi