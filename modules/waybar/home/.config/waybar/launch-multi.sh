#!/bin/bash

# Kill existing waybar instances
killall waybar 2>/dev/null
sleep 2

# Launch waybar on DP-1 only with full config
waybar -c ~/.config/waybar/config-dp1.jsonc -s ~/.config/waybar/style-dp1.css > /tmp/waybar-dp1.log 2>&1 &

sleep 2
echo "Waybar launched on all monitors"
ps aux | grep waybar | grep -v grep | wc -l
echo "waybar instances running"
