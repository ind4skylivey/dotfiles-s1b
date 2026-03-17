#!/bin/bash
# Launch Steam with compositing disabled (fixes Xwayland flickering)

# Set DISPLAY for X11
export DISPLAY=:0

# Disable compositing
kwriteconfig5 --file ~/.config/kwinrc --group Compositing --key "Enabled" "false"
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null

# Wait for compositing to disable
sleep 1

# Launch Steam
steam &
STEAM_PID=$!

# Wait for Steam to close
wait $STEAM_PID

# Re-enable compositing
kwriteconfig5 --file ~/.config/kwinrc --group Compositing --key "Enabled" "true"
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null

echo "Steam closed. Compositing re-enabled."
