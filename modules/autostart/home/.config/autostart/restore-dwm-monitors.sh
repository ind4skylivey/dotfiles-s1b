#!/bin/bash
# Restore DWM monitor configuration for X11 session
# Applies correct xrandr settings for 3-monitor setup:
# - DP-0 (LG): Primary 1920x1080 @ 180Hz
# - DP-1 (ASUS): Vertical 1080x1920 rotated left
# - HDMI-A-0 (Samsung): 1920x1080 @ 60Hz

xrandr \
    --output DisplayPort-0 --primary --mode 1920x1080 --rate 180 --pos 1080x0 \
    --output DisplayPort-1 --mode 1920x1080 --rate 60 --left-of DisplayPort-0 --rotate left --pos 0x0 \
    --output HDMI-A-0 --mode 1920x1080 --rate 60 --above DisplayPort-0 --pos 1080x1080

# Log success
echo "[$(date '+%Y-%m-%d %H:%M:%S')] DWM monitors (3x) restored" >> ~/.cache/monitor_restore.log
