#!/usr/bin/env bash
# scripts/backup.sh — copy paths into a backup session. Does not delete sources.

set -Eeuo pipefail

_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "${_script_dir}/.." && pwd)"
export DOTFILES_ROOT
# shellcheck source=lib/load.sh
source "${_script_dir}/lib/load.sh"
unset _script_dir

dotfiles_require_bash4

usage() {
  cat <<'EOF'
Usage: backup.sh [OPTIONS] PATH [PATH...]

Copy existing files into a timestamped backup. Missing paths are recorded,
not created. Sources are never deleted.

Options:
  --id ID       Use this backup id instead of a timestamp
  --dry-run     Log actions without writing
  --verbose     Debug logs
  --help        This help

Override store with DOTFILES_BACKUP_ROOT.
EOF
}

BACKUP_ID=""
PATHS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) usage; exit "${DOTFILES_E_OK}" ;;
    --id)
      BACKUP_ID="${2:-}"
      shift 2
      ;;
    --dry-run) DOTFILES_DRY_RUN=1; export DOTFILES_DRY_RUN; shift ;;
    --verbose|-v) DOTFILES_VERBOSE=1; export DOTFILES_VERBOSE; shift ;;
    --)
      shift
      PATHS+=("$@")
      break
      ;;
    -*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit "${DOTFILES_E_USAGE}"
      ;;
    *)
      PATHS+=("$1")
      shift
      ;;
  esac
done

if ((${#PATHS[@]} == 0)); then
  usage >&2
  exit "${DOTFILES_E_USAGE}"
fi

dotfiles_log_init
if [[ -n "${BACKUP_ID}" ]]; then
  dotfiles_backup_begin "${BACKUP_ID}"
else
  dotfiles_backup_begin
fi

for p in "${PATHS[@]}"; do
  dotfiles_backup_file "${p}"
done
dotfiles_backup_finalize
printf '%s\n' "${DOTFILES_BACKUP_ID}"
exit "${DOTFILES_E_OK}"
