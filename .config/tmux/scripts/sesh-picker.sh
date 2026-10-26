#!/usr/bin/env bash
# Launcher sesh + fzf-tmux (requiere sesh en PATH).

set -euo pipefail

if ! command -v sesh >/dev/null 2>&1; then
  tmux display-message -d 5000 "sesh no instalado. Ver ~/.config/tmux/docs/sesh.md"
  exit 1
fi

if ! command -v fzf-tmux >/dev/null 2>&1; then
  tmux display-message -d 5000 "fzf-tmux no encontrado"
  exit 1
fi

sesh connect "$(
  sesh list --icons 2>/dev/null | fzf-tmux -p 80%,70% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all  ^t tmux  ^g configs  ^x zoxide  ^d kill  ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 3 -t d -E .git -E node_modules -E vendor . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
    --preview-window 'right:55%' \
    --preview 'sesh preview {}' 2>/dev/null
)"
