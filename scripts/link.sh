#!/usr/bin/env bash
# scripts/link.sh — link one declared repo path into home. Not GNU Stow.
#
# Does not walk the repo root. Does not rm -rf. Dry-run writes nothing.

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
Usage: link.sh [OPTIONS] SRC DEST
       link.sh --status DEST

Create an idempotent symlink from a path in this repository to DEST.

SRC is absolute or relative to the repository root.
DEST is absolute or relative to $HOME (override DOTFILES_LINK_HOME).

Options:
  --dry-run     Log actions without writing
  --status      Print dest kind: already|missing|file|symlink|directory
                (with --status DEST; "already" if DEST points at SRC)
  --verbose     Debug logs
  --help        This help

This command never stows the repo root. Modules will declare paths later.
See docs/linker.md.
EOF
}

FLAG_DRY_RUN=0
FLAG_STATUS=0
ARGS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) usage; exit "${DOTFILES_E_OK}" ;;
    --dry-run) FLAG_DRY_RUN=1; shift ;;
    --status) FLAG_STATUS=1; shift ;;
    --verbose|-v) DOTFILES_VERBOSE=1; export DOTFILES_VERBOSE; shift ;;
    --)
      shift
      ARGS+=("$@")
      break
      ;;
    -*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit "${DOTFILES_E_USAGE}"
      ;;
    *)
      ARGS+=("$1")
      shift
      ;;
  esac
done

if [[ "${FLAG_DRY_RUN}" -eq 1 ]]; then
  DOTFILES_DRY_RUN=1
  export DOTFILES_DRY_RUN
fi

dotfiles_log_init

if [[ "${FLAG_STATUS}" -eq 1 ]]; then
  if ((${#ARGS[@]} < 1)); then
    printf '%s\n' "--status needs DEST" >&2
    exit "${DOTFILES_E_USAGE}"
  fi
  dest="${ARGS[0]}"
  src="${ARGS[1]:-}"
  if [[ "${dest}" != /* ]]; then
    dest="$(dotfiles_link_home)/${dest}"
  fi
  kind="$(dotfiles_link_status "${dest}")"
  if [[ -n "${src}" ]]; then
    if [[ "${src}" != /* ]]; then
      src="${DOTFILES_ROOT}/${src}"
    fi
    if [[ -e "${src}" || -L "${src}" ]]; then
      src_abs="$(_dotfiles_abs_path "${src}")"
      if _dotfiles_link_already "${dest}" "${src_abs}"; then
        printf 'already\n'
        exit "${DOTFILES_E_OK}"
      fi
    fi
  fi
  printf '%s\n' "${kind}"
  exit "${DOTFILES_E_OK}"
fi

if ((${#ARGS[@]} != 2)); then
  usage >&2
  exit "${DOTFILES_E_USAGE}"
fi

dotfiles_link_config "${ARGS[0]}" "${ARGS[1]}"
exit $?
