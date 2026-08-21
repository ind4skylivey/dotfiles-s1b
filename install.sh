#!/usr/bin/env bash
# install.sh — CLI dispatcher.
#
# Without flags, runs the legacy Arch/stow installer (compatibility).
# New flags (--dry-run, --help, --doctor, --link) never call the legacy path.
#
# Dry-run: detect → plan → report. No files, packages, or destructive commands.

set -Eeuo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_ROOT
# shellcheck source=scripts/lib/load.sh
source "${DOTFILES_ROOT}/scripts/lib/load.sh"

dotfiles_require_bash4

LEGACY_INSTALLER="${DOTFILES_ROOT}/scripts/legacy/install.sh"

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Reproducible Unix/Linux configuration installer.

Modes:
  (no flags)              Run the legacy installer (Arch, interactive, ~/dotfiles)
  --legacy                Same as no flags, explicit
  --dry-run               Detect platform, print plan, change nothing
  --doctor                Non-destructive health checks
  --backup                show backup root and existing ids
  --link SRC DEST         idempotent symlink (repo SRC → DEST under home)
  --help                  This help

Declared (not implemented yet — exit 3):
  --profile NAME          minimal|workstation|developer|security|desktop|gaming|full
  --desktop NAME          niri (default Wayland) | dwm | plasma
  --components LIST       comma-separated modules
  --exclude LIST          comma-separated modules
  --yes / -y              skip confirmation (future install path)
  --non-interactive       refuse prompts
  --config PATH           config/local.toml
  --uninstall             safe uninstall (future)
  --verbose / -v          debug logging
  --debug                 alias for --verbose

Desktop backends (when implemented):
  niri     Wayland + Noctalia (recommended)
  dwm      X11
  plasma   KDE + Waybar

Exit codes:
  0  success
  1  error
  2  usage error
  3  flag recognized but not implemented yet

See docs/architecture.md.
EOF
}

run_legacy() {
  if [[ ! -x "${LEGACY_INSTALLER}" && ! -f "${LEGACY_INSTALLER}" ]]; then
    dotfiles_log_error "Legacy installer missing: ${LEGACY_INSTALLER}"
    exit "${DOTFILES_E_ERR}"
  fi
  printf '%s\n' "Running legacy installer. New CLI: ./install.sh --help" >&2
  exec bash "${LEGACY_INSTALLER}"
}

run_dry_run() {
  DOTFILES_DRY_RUN=1
  export DOTFILES_DRY_RUN
  dotfiles_log_init
  dotfiles_log_step "detect"
  dotfiles_detect_platform
  printf '\n'
  dotfiles_detect_report
  printf '\n'
  dotfiles_log_step "plan"
  dotfiles_plan_stub_current
  if [[ -n "${DOTFILES_PROFILE:-}" ]]; then
    printf 'Selected profile: %s\n\n' "${DOTFILES_PROFILE}"
  else
    printf 'Selected profile: (none — pass --profile minimal or workstation)\n\n'
  fi
  printf 'Selected desktop default (when implemented): niri\n\n'
  dotfiles_plan_report
  printf '\nNo files were modified. No packages were installed.\n'
}

run_doctor() {
  exec bash "${DOTFILES_ROOT}/doctor.sh"
}

FLAG_HELP=0
FLAG_DRY_RUN=0
FLAG_DOCTOR=0
FLAG_LEGACY=0
FLAG_BACKUP=0
FLAG_LINK=0
LINK_SRC=""
LINK_DEST=""
FLAG_NOTIMPL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) FLAG_HELP=1; shift ;;
    --dry-run) FLAG_DRY_RUN=1; shift ;;
    --doctor) FLAG_DOCTOR=1; shift ;;
    --legacy) FLAG_LEGACY=1; shift ;;
    --verbose|-v|--debug)
      DOTFILES_VERBOSE=1
      export DOTFILES_VERBOSE
      shift
      ;;
    --profile)
      DOTFILES_PROFILE="${2:-}"
      export DOTFILES_PROFILE
      FLAG_NOTIMPL+=("--profile")
      shift 2 || { printf '%s\n' "--profile needs a value" >&2; exit "${DOTFILES_E_USAGE}"; }
      ;;
    --desktop|--components|--exclude|--config)
      FLAG_NOTIMPL+=("$1")
      if [[ $# -lt 2 ]]; then
        printf '%s needs a value\n' "$1" >&2
        exit "${DOTFILES_E_USAGE}"
      fi
      shift 2
      ;;
    --backup) FLAG_BACKUP=1; shift ;;
    --link)
      FLAG_LINK=1
      LINK_SRC="${2:-}"
      LINK_DEST="${3:-}"
      if [[ -z "${LINK_SRC}" || -z "${LINK_DEST}" ]]; then
        printf '%s\n' "--link needs SRC DEST" >&2
        exit "${DOTFILES_E_USAGE}"
      fi
      shift 3
      ;;
    --yes|-y|--non-interactive|--uninstall)
      FLAG_NOTIMPL+=("$1")
      shift
      ;;
    *)
      printf 'Unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit "${DOTFILES_E_USAGE}"
      ;;
  esac
done

if [[ "${FLAG_HELP}" -eq 1 ]]; then
  usage
  exit "${DOTFILES_E_OK}"
fi

if [[ "${FLAG_LEGACY}" -eq 1 ]]; then
  run_legacy
fi

if [[ "${FLAG_DOCTOR}" -eq 1 ]]; then
  run_doctor
fi

if [[ "${FLAG_LINK}" -eq 1 ]]; then
  if [[ "${FLAG_DRY_RUN}" -eq 1 ]]; then
    DOTFILES_DRY_RUN=1
    export DOTFILES_DRY_RUN
  fi
  dotfiles_log_init
  dotfiles_link_config "${LINK_SRC}" "${LINK_DEST}"
  exit $?
fi

if [[ "${FLAG_DRY_RUN}" -eq 1 ]]; then
  # Dry-run is allowed together with --profile (profile is informational).
  if ((${#FLAG_NOTIMPL[@]} > 0)); then
    local_list="${FLAG_NOTIMPL[*]}"
    dotfiles_log_init
    dotfiles_log_warn "Flags not implemented yet (ignored in dry-run): ${local_list}"
  fi
  run_dry_run
  if [[ "${FLAG_BACKUP}" -eq 1 ]]; then
    printf '\nBackup root (no files written): %s\n' "$(dotfiles_backup_root)"
  fi
  exit "${DOTFILES_E_OK}"
fi

if [[ "${FLAG_BACKUP}" -eq 1 && "${FLAG_LINK}" -eq 0 && "${FLAG_DRY_RUN}" -eq 0 ]]; then
  dotfiles_log_init
  printf 'Backup root: %s\n' "$(dotfiles_backup_root)"
  printf 'Backups are created automatically before file changes.\n'
  printf 'Restore: ./restore.sh --list | --latest | --backup-id ID\n'
  printf 'Manual snapshot: ./scripts/backup.sh PATH [PATH...]\n'
  mapfile -t _ids < <(dotfiles_backup_list)
  if ((${#_ids[@]} > 0)); then
    printf '\nExisting backups:\n'
    printf '  %s\n' "${_ids[@]}"
  fi
  exit "${DOTFILES_E_OK}"
fi

if ((${#FLAG_NOTIMPL[@]} > 0)); then
  printf 'Not implemented yet: %s\n' "${FLAG_NOTIMPL[*]}" >&2
  printf 'Use --dry-run or --legacy. See ./install.sh --help\n' >&2
  exit "${DOTFILES_E_NOTIMPL}"
fi

run_legacy
