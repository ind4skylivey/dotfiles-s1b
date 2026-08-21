# shellcheck shell=bash
# scripts/lib/module.sh — read module manifests and plan declared links.
#
# Public:
#   dotfiles_module_root NAME     Print modules/NAME
#   dotfiles_module_plan NAME     Add [link]/[skip] rows from links.tsv
#   dotfiles_module_has NAME      Return 0 if module.toml exists
#   dotfiles_plan_named_modules NAME...
#   dotfiles_desktop_backend      niri|dwm|plasma|empty
#   dotfiles_plan_desktop_backend
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

dotfiles_plan_named_modules() {
  local name
  for name in "$@"; do
    if dotfiles_module_has "${name}"; then
      dotfiles_module_plan "${name}"
    else
      dotfiles_plan_add skip "${name}" "module missing"
    fi
  done
}

dotfiles_desktop_backend() {
  if [[ -n "${DOTFILES_DESKTOP:-}" ]]; then
    printf '%s' "${DOTFILES_DESKTOP}"
    return 0
  fi
  case "${DOTFILES_PROFILE:-}" in
    desktop|full)
      printf 'niri'
      ;;
    *)
      printf ''
      ;;
  esac
}

dotfiles_plan_desktop_backend() {
  local backend
  backend="$(dotfiles_desktop_backend)"
  case "${backend}" in
    niri)
      dotfiles_plan_named_modules niri
      dotfiles_plan_add skip "dwm" "mutually exclusive: this plan is --desktop niri (Wayland)"
      dotfiles_plan_add skip "waybar" "Waybar is --desktop plasma only; Niri uses Noctalia, not Waybar"
      ;;
    dwm)
      dotfiles_plan_named_modules dwm
      dotfiles_plan_add skip "niri" "mutually exclusive: this plan is --desktop dwm (X11)"
      dotfiles_plan_add skip "waybar" "Waybar is --desktop plasma only; DWM uses slstatus"
      ;;
    plasma)
      dotfiles_plan_named_modules waybar
      dotfiles_plan_add skip "niri" "mutually exclusive: this plan is --desktop plasma (KDE Wayland)"
      dotfiles_plan_add skip "dwm" "mutually exclusive: this plan is --desktop plasma"
      ;;
    "")
      dotfiles_plan_add skip "niri" "pass --profile desktop or --desktop niri (Wayland default)"
      dotfiles_plan_add skip "dwm" "pass --desktop dwm for the X11 session"
      dotfiles_plan_add skip "waybar" "pass --desktop plasma; never with niri"
      ;;
    *)
      dotfiles_plan_add skip "desktop ${backend}" "unknown --desktop (use niri|dwm|plasma)"
      ;;
  esac
}

dotfiles_plan_for_profile() {
  dotfiles_plan_reset
  dotfiles_plan_add skip "package install" "package layer not implemented yet"

  case "${DOTFILES_PROFILE:-}" in
    minimal)
      dotfiles_plan_named_modules shell git editor
      dotfiles_plan_add skip "terminal module" "not in minimal; use --profile workstation"
      dotfiles_plan_add skip "mux module" "not in minimal; use --profile workstation"
      ;;
    workstation|developer|security)
      dotfiles_plan_named_modules shell git editor terminal mux
      ;;
    full)
      dotfiles_plan_named_modules shell git editor terminal mux gaming themes browser
      ;;
    desktop)
      dotfiles_plan_add skip "shell module" "not in this profile; use --profile minimal"
      dotfiles_plan_add skip "git module" "not in this profile; use --profile minimal"
      dotfiles_plan_add skip "editor module" "not in this profile; use --profile minimal"
      dotfiles_plan_add skip "terminal module" "not in this profile; use --profile workstation"
      dotfiles_plan_add skip "mux module" "not in this profile; use --profile workstation"
      ;;
    gaming)
      dotfiles_plan_named_modules gaming
      ;;
    "")
      dotfiles_plan_add skip "shell module" "pass --profile minimal to include portable shell links"
      dotfiles_plan_add skip "git module" "pass --profile minimal to include portable git config"
      dotfiles_plan_add skip "editor module" "pass --profile minimal to include portable nvim"
      dotfiles_plan_add skip "terminal module" "pass --profile workstation for kitty/alacritty"
      dotfiles_plan_add skip "mux module" "pass --profile workstation for tmux/zellij"
      ;;
    *)
      dotfiles_plan_add skip "profile ${DOTFILES_PROFILE}" "unknown profile"
      ;;
  esac

  if [[ "${DOTFILES_PROFILE:-}" == "security" ]]; then
    dotfiles_plan_add warn "security profile" "opt-in lab overlay (Burp/ZAP binds); not for shared machines; dump kali privileged aliases stay out"
    dotfiles_plan_named_modules security
  else
    dotfiles_plan_add skip "security tools" "requires --profile security (explicit opt-in)"
  fi

  if [[ "${DOTFILES_PROFILE:-}" != "gaming" && "${DOTFILES_PROFILE:-}" != "full" ]]; then
    dotfiles_plan_add skip "gaming" "pass --profile gaming or --profile full"
  fi
  if [[ "${DOTFILES_PROFILE:-}" != "full" ]]; then
    dotfiles_plan_add skip "themes" "optional aesthetics; pass --profile full"
    dotfiles_plan_add skip "browser userChrome" "theme only; pass --profile full; never prefs.js"
  fi

  dotfiles_plan_desktop_backend
}
