# shellcheck shell=bash
# scripts/lib/plan.sh — collect a dry-run / confirm plan. No side effects.
#
# Public:
#   dotfiles_plan_reset
#   dotfiles_plan_add KIND TARGET [REASON]
#       KIND: install | link | backup | skip | configure | warn
#   dotfiles_plan_count
#   dotfiles_plan_report           Print the plan (stdout).
#   dotfiles_plan_stub_current     Plan for this phase (detect-only).

dotfiles_plan_reset() {
  DOTFILES_PLAN_KINDS=()
  DOTFILES_PLAN_TARGETS=()
  DOTFILES_PLAN_REASONS=()
}

dotfiles_plan_add() {
  local kind="${1:?kind required}"
  local target="${2:?target required}"
  local reason="${3:-}"
  DOTFILES_PLAN_KINDS+=("${kind}")
  DOTFILES_PLAN_TARGETS+=("${target}")
  DOTFILES_PLAN_REASONS+=("${reason}")
}

dotfiles_plan_count() {
  printf '%s' "${#DOTFILES_PLAN_KINDS[@]}"
}

dotfiles_plan_report() {
  local i kind target reason
  printf 'Plan\n'
  if ((${#DOTFILES_PLAN_KINDS[@]} == 0)); then
    printf '  (empty — nothing would change)\n'
    return 0
  fi
  for i in "${!DOTFILES_PLAN_KINDS[@]}"; do
    kind="${DOTFILES_PLAN_KINDS[$i]}"
    target="${DOTFILES_PLAN_TARGETS[$i]}"
    reason="${DOTFILES_PLAN_REASONS[$i]}"
    if [[ -n "${reason}" ]]; then
      printf '  [%s] %s — %s\n' "${kind}" "${target}" "${reason}"
    else
      printf '  [%s] %s\n' "${kind}" "${target}"
    fi
  done
  printf '\nNothing in this plan modifies the system.\n'
}

dotfiles_plan_stub_current() {
  dotfiles_plan_reset
  dotfiles_plan_add skip "package install" "package layer not implemented yet"
  dotfiles_plan_add skip "symlinks" "linker not implemented yet"
  dotfiles_plan_add skip "file changes" "no linker yet — backup library is ready"
  dotfiles_plan_add skip "niri" "desktop import pending; live config is NiriPURA"
  dotfiles_plan_add skip "dwm" "desktop module not migrated"
  dotfiles_plan_add skip "security tools" "requires --profile security (not implemented)"
}
