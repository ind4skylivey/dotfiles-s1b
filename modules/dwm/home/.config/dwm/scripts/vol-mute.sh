#!/bin/bash
# Toggle mute with pactl and show notification

pactl set-sink-mute @DEFAULT_SINK@ toggle
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
dunstify -r 9991 -u low "Output: $([ "$muted" = yes ] && echo Muted || echo Live)"