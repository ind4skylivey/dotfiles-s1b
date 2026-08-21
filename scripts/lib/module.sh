# shellcheck shell=bash
# scripts/lib/module.sh — read module manifests and plan declared links.
#
# Public:
#   dotfiles_module_root NAME     Print modules/NAME
#   dotfiles_module_plan NAME     Add [link]/[skip] rows from links.tsv
#   dotfiles_module_has NAME      Return 0 if module.toml exists
#   dotfiles_plan_for_profile     Fill the plan from DOTFILES_PROFILE

dotfiles_module_root() {
  local name="${1:?module name required}"
  printf '%s/modules/%s' "${DOTFILES_ROOT}" "${name}"
}

dotfiles_module_has() {
  local name="${1:?module name required}"
  [[ -f "$(dotfiles_module_root "${name}")/module.toml" ]]
}

# Reads links.tsv: src<TAB>dest  (# comments and blank lines skipped)
dotfiles_module_plan() {
  local name="${1:?module name required}"
  local tsv src dest
  tsv="$(dotfiles_module_root "${name}")/links.tsv"
  if [[ ! -f "${tsv}" ]]; then
    dotfiles_plan_add skip "module ${name}" "no links.tsv"
    return 0
  fi
  while IFS=$'\t' read -r src dest || [[ -n "${src:-}" ]]; do
    [[ -z "${src}" || "${src}" == \#* ]] && continue
    if [[ ! -e "${DOTFILES_ROOT}/${src}" && ! -L "${DOTFILES_ROOT}/${src}" ]]; then
      dotfiles_plan_add skip "${src}" "declared but missing in repo"
      continue
    fi
    dotfiles_plan_add link "${dest}" "module ${name}: ${src}"
  done <"${tsv}"
}

dotfiles_plan_for_profile() {
  dotfiles_plan_reset
  dotfiles_plan_add skip "package install" "package layer not implemented yet"

  case "${DOTFILES_PROFILE:-}" in
    minimal|workstation|developer|full|security)
      if dotfiles_module_has shell; then
        dotfiles_module_plan shell
      else
        dotfiles_plan_add skip "shell" "module missing"
      fi
      ;;
    desktop|gaming)
      dotfiles_plan_add skip "shell module" "not in this profile; use --profile minimal"
      ;;
    "")
      dotfiles_plan_add skip "shell module" "pass --profile minimal to include portable shell links"
      ;;
    *)
      dotfiles_plan_add skip "profile ${DOTFILES_PROFILE}" "unknown profile"
      ;;
  esac

  if [[ "${DOTFILES_PROFILE:-}" == "security" ]]; then
    dotfiles_plan_add skip "offensive aliases" "security module not migrated; portable shell has none"
  else
    dotfiles_plan_add skip "security tools" "requires --profile security (not implemented)"
  fi

  dotfiles_plan_add skip "git module" "not migrated yet"
  dotfiles_plan_add skip "niri" "desktop import pending; live config is NiriPURA"
  dotfiles_plan_add skip "dwm" "desktop module not migrated"
}
