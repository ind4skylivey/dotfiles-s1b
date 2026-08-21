#!/usr/bin/env bash
# detect-platform.sh — print host facts. Read-only.
#
# Usage:
#   ./scripts/detect-platform.sh
#   ./scripts/detect-platform.sh --kv
#   ./scripts/detect-platform.sh --verbose
#
# Exit: 0 on success, 2 on usage error.

set -Eeuo pipefail

_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/load.sh
source "${_script_dir}/lib/load.sh"
unset _script_dir

dotfiles_require_bash4

usage() {
  cat <<'EOF'
Usage: detect-platform.sh [OPTIONS]

Detect OS, distro, package manager, session, and support tier.
This command never modifies the system.

Options:
  --kv         Print KEY=VALUE (stable for scripts)
  --verbose    Include debug logs on stderr
  --help       Show this help

Exit codes:
  0  success
  2  usage error
EOF
}

DOTFILES_KV=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --kv) DOTFILES_KV=1; shift ;;
    --verbose|-v) DOTFILES_VERBOSE=1; export DOTFILES_VERBOSE; shift ;;
    --help|-h) usage; exit "${DOTFILES_E_OK}" ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit "${DOTFILES_E_USAGE}"
      ;;
  esac
done

dotfiles_log_init
dotfiles_log_debug "DOTFILES_ROOT=${DOTFILES_ROOT}"
dotfiles_detect_platform

if [[ "${DOTFILES_KV}" -eq 1 ]]; then
  dotfiles_detect_kv
else
  dotfiles_detect_report
fi

exit "${DOTFILES_E_OK}"
