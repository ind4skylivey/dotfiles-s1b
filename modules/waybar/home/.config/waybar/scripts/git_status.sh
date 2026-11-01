#!/bin/bash

# Get active window PID and check if it's in a git repo
get_git_status() {
    local current_dir=$(pwd)
    
    # Try to find git repo from current directory
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local git_dir=$(git rev-parse --git-dir)
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local status=$(git status --short 2>/dev/null | wc -l)
        
        if [ "$status" -gt 0 ]; then
            echo " 󰊢 $branch ●"
        else
            echo " 󰊢 $branch"
        fi
    else
        echo ""
    fi
}

get_git_status
