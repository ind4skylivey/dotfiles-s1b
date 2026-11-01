#!/usr/bin/env bash
# Dynamic Title Script for Alacritty
# Shows: user@hostname:git-branch or user@hostname:path

[[ "${BASH_SOURCE[0]}" == "$0" ]] && set -euo pipefail  # solo si se ejecuta directo, no al hacer source

# Get current git branch if in a git repo
get_git_branch() {
    local branch=""
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        branch=$(git branch --show-current 2>/dev/null || echo "detached")
        # Shorten branch name if too long
        if [ ${#branch} -gt 15 ]; then
            branch="${branch:0:12}..."
        fi
        echo "[$branch]"
    fi
}

# Update terminal title
update_title() {
    local title=""
    local git_info=""
    local pwd_name="${PWD##*/}"

    # Get git branch
    git_info=$(get_git_branch)

    # Build title
    if [ -n "$git_info" ]; then
        title="${USER}@${HOSTNAME}:${pwd_name} ${git_info}"
    else
        title="${USER}@${HOSTNAME}:${pwd_name}"
    fi

    # Set title (works with bash)
    echo -ne "\033]0;${title}\007"
}

# Run update
update_title

# If in bash, set PROMPT_COMMAND to auto-update
if [ -n "${BASH_VERSION:-}" ]; then
    # Only set PROMPT_COMMAND if not already set
    if [[ ! "${PROMPT_COMMAND:-}" =~ update_title ]]; then
        PROMPT_COMMAND="update_title${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
    fi
fi
