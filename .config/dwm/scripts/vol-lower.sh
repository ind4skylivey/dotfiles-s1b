#!/bin/bash
# Lower volume with pactl and show notification

pactl set-sink-volume @DEFAULT_SINK@ -5%
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}')
dunstify -r 9991 -u low "Volume $vol"