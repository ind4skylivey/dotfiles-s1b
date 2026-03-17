#!/bin/bash

# Session time (time since user logged in)
get_session_time() {
    local login_time=$(ps -eo lstart,pid | grep " $(pgrep -u $USER systemd | head -1)" | awk '{print $1, $2, $3, $4, $5}')
    
    if [ -z "$login_time" ]; then
        local uptime=$(uptime | awk -F'up' '{print $2}' | cut -d',' -f1 | xargs)
        echo "󰥔 $uptime"
    else
        echo "󰥔 $(date '+%H:%M')"
    fi
}

# System uptime
get_uptime() {
    uptime | awk -F'up' '{print $2}' | cut -d',' -f1 | xargs
}

get_session_time
