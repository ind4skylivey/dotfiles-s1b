#!/usr/bin/env bash
# Jump to (or create) a tmux session for a project directory.

set -euo pipefail

selected="${1:-}"

if [[ -z "$selected" ]]; then
  tmux display-message -d 3000 "sessionizer: falta el path"
  exit 1
fi

if [[ ! -d "$selected" ]]; then
  tmux display-message -d 4000 "No existe: $selected"
  exit 1
fi

selected="$(cd "$selected" && pwd)"
selected_name="$(basename "$selected" | tr '.-' '__')"

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
