#!/usr/bin/env bash
# restore.sh — restore files from a backup session. Never deletes user data.

set -Eeuo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_ROOT
# shellcheck source=scripts/lib/load.sh
source "${DOTFILES_ROOT}/scripts/lib/load.sh"

dotfiles_require_bash4

usage() {
  cat <<'EOF'
Usage: ./restore.sh [OPTIONS]

Restore files copied by the backup layer.

Options:
  --latest              Restore the newest backup
  --backup-id ID        Restore a specific backup
  --list                List backup ids
  --from-dir DIR        Backup directory (used by generated restore.sh)
  --dry-run             Show what would be restored
  --verbose             Debug logs
  --help                This help

Default backup root:
  ${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/

Exit codes:
  0  success
  1  error
  2  usage error
EOF
}

FLAG_LATEST=0
FLAG_LIST=0
BACKUP_ID=""
FROM_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) usage; exit "${DOTFILES_E_OK}" ;;
    --latest) FLAG_LATEST=1; shift ;;
    --list) FLAG_LIST=1; shift ;;
    --backup-id)
      BACKUP_ID="${2:-}"
      if [[ -z "${BACKUP_ID}" ]]; then
        printf '%s\n' "--backup-id needs a value" >&2
        exit "${DOTFILES_E_USAGE}"
      fi
      shift 2
      ;;
    --from-dir)
      FROM_DIR="${2:-}"
      shift 2
      ;;
    --dry-run) DOTFILES_DRY_RUN=1; export DOTFILES_DRY_RUN; shift ;;
    --verbose|-v) DOTFILES_VERBOSE=1; export DOTFILES_VERBOSE; shift ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit "${DOTFILES_E_USAGE}"
      ;;
  esac
done

dotfiles_log_init

if [[ "${FLAG_LIST}" -eq 1 ]]; then
  mapfile -t ids < <(dotfiles_backup_list)
  if ((${#ids[@]} == 0)); then
    printf 'No backups found in %s\n' "$(dotfiles_backup_root)"
    exit "${DOTFILES_E_OK}"
  fi
  printf 'Backups in %s\n' "$(dotfiles_backup_root)"
  local_id=""
  for local_id in "${ids[@]}"; do
    printf '  %s\n' "${local_id}"
  done
  exit "${DOTFILES_E_OK}"
fi

if [[ "${FLAG_LATEST}" -eq 1 ]]; then
  BACKUP_ID="$(dotfiles_backup_latest)"
  if [[ -z "${BACKUP_ID}" ]]; then
    dotfiles_log_error "no backups found"
    exit "${DOTFILES_E_ERR}"
  fi
fi

if [[ -z "${BACKUP_ID}" ]]; then
  usage >&2
  exit "${DOTFILES_E_USAGE}"
fi

if [[ -n "${FROM_DIR}" ]]; then
  dotfiles_backup_restore "${BACKUP_ID}" "${FROM_DIR}"
else
  dotfiles_backup_restore "${BACKUP_ID}"
fi
exit "${DOTFILES_E_OK}"
