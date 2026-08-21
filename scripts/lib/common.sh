# shellcheck shell=bash
# scripts/lib/common.sh — constants, repo root, shared helpers.
#
# Public:
#   DOTFILES_ROOT                 Absolute path to the repository.
#   dotfiles_require_bash4        Exit if Bash is older than 4.
#   dotfiles_is_truthy NAME       Return 0 if the named var is 1/true/yes.
#   dotfiles_have_cmd CMD         Return 0 if CMD is on PATH (mockable).
#
# Environment:
#   DOTFILES_ROOT                 Override repo root (tests).
#   DOTFILES_MOCK_CMDS            Space-separated command names that exist.
#   DOTFILES_MOCK_MISSING         Space-separated command names that do not.

if [[ -z "${DOTFILES_ROOT:-}" ]]; then
  _dotfiles_lib_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  DOTFILES_ROOT="$(cd "${_dotfiles_lib_dir}/../.." && pwd)"
  unset _dotfiles_lib_dir
fi

readonly DOTFILES_E_OK=0
readonly DOTFILES_E_ERR=1
readonly DOTFILES_E_USAGE=2
readonly DOTFILES_E_NOTIMPL=3
export DOTFILES_E_OK DOTFILES_E_ERR DOTFILES_E_USAGE DOTFILES_E_NOTIMPL

dotfiles_require_bash4() {
  if ((BASH_VERSINFO[0] < 4)); then
    printf '%s\n' "This installer requires Bash 4 or newer (found ${BASH_VERSION})." >&2
    exit "${DOTFILES_E_ERR}"
  fi
}

dotfiles_is_truthy() {
  local value="${1:-}"
  case "${value,,}" in
    1|true|yes|on) return 0 ;;
    *) return 1 ;;
  esac
}

# Override in tests via DOTFILES_MOCK_CMDS / DOTFILES_MOCK_MISSING.
dotfiles_have_cmd() {
  local cmd="${1:?command name required}"
  if [[ -n "${DOTFILES_MOCK_MISSING:-}" && " ${DOTFILES_MOCK_MISSING} " == *" ${cmd} "* ]]; then
    return 1
  fi
  if [[ -n "${DOTFILES_MOCK_CMDS:-}" ]]; then
    [[ " ${DOTFILES_MOCK_CMDS} " == *" ${cmd} "* ]]
    return
  fi
  command -v "${cmd}" >/dev/null 2>&1
}
