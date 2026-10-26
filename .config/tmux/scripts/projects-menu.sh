#!/usr/bin/env bash
# Fzf menu: proyectos fijos + browse bajo shenanigans/Repos.

set -euo pipefail

CONFIG_DIR="${HOME}/.config/tmux"
PROJECTS_FILE="${CONFIG_DIR}/projects.list"
SHENANIGANS_REPOS="/media/il1v3y/HD2/HDfiles/shenanigans/Repos"
SESSIONIZER="${CONFIG_DIR}/scripts/sessionizer.sh"

pick_from_list() {
  awk -F'|' '!/^#/ && NF >= 2 { print $2 "\t" $1 }' "$PROJECTS_FILE" \
    | fzf --reverse --delimiter=$'\t' --with-nth=2,1 \
      --header "Proyectos fijos  |  Enter: abrir  |  Esc: cancelar" \
    | cut -f1
}

pick_from_repos() {
  if [[ ! -d "$SHENANIGANS_REPOS" ]]; then
    tmux display-message -d 4000 "No montado: $SHENANIGANS_REPOS"
    exit 1
  fi

  find "$SHENANIGANS_REPOS" -mindepth 1 -maxdepth 3 -type d \
    \( -name node_modules -o -name vendor -o -name .git -o -name .worktrees \) -prune \
    -o -type d -print 2>/dev/null \
    | fzf --reverse --header "Browse Repos (depth 3)  |  Enter: abrir"
}

action="$(printf '%s\n%s\n' "[lista] Proyectos fijos" "[browse] Explorar Repos/")" \
  | fzf --reverse --header "Project picker")

case "$action" in
  "[lista]"*) selected="$(pick_from_list)" || exit 0 ;;
  "[browse]"*) selected="$(pick_from_repos)" || exit 0 ;;
  *) exit 0 ;;
esac

[[ -n "$selected" ]] && exec "$SESSIONIZER" "$selected"
