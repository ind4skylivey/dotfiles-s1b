# shellcheck shell=bash
# scripts/lib/log.sh — structured logging. Never writes secrets.
#
# Public:
#   dotfiles_log_init             Apply DOTFILES_LOG_LEVEL / verbose / dry-run.
#   dotfiles_log_debug MSG...
#   dotfiles_log_info  MSG...
#   dotfiles_log_warn  MSG...
#   dotfiles_log_error MSG...
#   dotfiles_log_step  MSG...     High-level phase marker.
#   dotfiles_redact    TEXT       Mask token-like values before logging.
#
# Environment:
#   DOTFILES_LOG_LEVEL            debug|info|warn|error  (default: info)
#   DOTFILES_VERBOSE              1 enables debug
#   DOTFILES_DRY_RUN              1 prefixes messages with [dry-run]
#   DOTFILES_NO_COLOR             1 disables ANSI
#   DOTFILES_LOG_FILE             Optional extra sink (0600 if created)

# Levels: debug=0 info=1 warn=2 error=3
_DOTFILES_LOG_LEVEL_N=1

_dotfiles_log_color() {
  if [[ -n "${DOTFILES_NO_COLOR:-}" ]] || [[ ! -t 2 ]]; then
    return 0
  fi
  case "$1" in
    debug) printf '\033[2m' ;;
    info)  printf '\033[34m' ;;
    warn)  printf '\033[33m' ;;
    error) printf '\033[31m' ;;
    step)  printf '\033[36m' ;;
    *)     printf '\033[0m' ;;
  esac
}

_dotfiles_log_reset() {
  if [[ -n "${DOTFILES_NO_COLOR:-}" ]] || [[ ! -t 2 ]]; then
    return 0
  fi
  printf '\033[0m'
}

dotfiles_redact() {
  local text="${1:-}"
  # Redact assignment-like secrets: TOKEN=..., password: ..., Bearer ...
  text="$(printf '%s' "${text}" | sed -E \
    -e 's/([Tt]oken|[Pp]assword|[Ss]ecret|[Aa]pi[_-]?[Kk]ey|[Bb]earer)([=:[:space:]]+)[^[:space:]]+/\1\2***/g')"
  printf '%s' "${text}"
}

dotfiles_log_init() {
  local level="${DOTFILES_LOG_LEVEL:-info}"
  if dotfiles_is_truthy "${DOTFILES_VERBOSE:-0}"; then
    level="debug"
  fi
  case "${level,,}" in
    debug) _DOTFILES_LOG_LEVEL_N=0 ;;
    info)  _DOTFILES_LOG_LEVEL_N=1 ;;
    warn)  _DOTFILES_LOG_LEVEL_N=2 ;;
    error) _DOTFILES_LOG_LEVEL_N=3 ;;
    *)     _DOTFILES_LOG_LEVEL_N=1 ;;
  esac

  if [[ -n "${DOTFILES_LOG_FILE:-}" ]]; then
    local dir
    dir="$(dirname -- "${DOTFILES_LOG_FILE}")"
    mkdir -p -- "${dir}"
    : >>"${DOTFILES_LOG_FILE}"
    chmod 600 -- "${DOTFILES_LOG_FILE}" 2>/dev/null || true
  fi
}

_dotfiles_log_emit() {
  local level="$1"
  local rank="$2"
  shift 2
  if ((rank < _DOTFILES_LOG_LEVEL_N)); then
    return 0
  fi
  local prefix=""
  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    prefix="[dry-run] "
  fi
  local ts
  ts="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  local msg
  msg="$(dotfiles_redact "$*")"
  local line
  line="$(printf '%s%s[%s] %s' "${prefix}" "${level^^}" "${ts}" "${msg}")"

  {
    _dotfiles_log_color "${level}"
    printf '%s' "${line}"
    _dotfiles_log_reset
    printf '\n'
  } >&2

  if [[ -n "${DOTFILES_LOG_FILE:-}" ]]; then
    printf '%s\n' "${line}" >>"${DOTFILES_LOG_FILE}"
  fi
}

dotfiles_log_debug() { _dotfiles_log_emit debug 0 "$*"; }
dotfiles_log_info()  { _dotfiles_log_emit info  1 "$*"; }
dotfiles_log_warn()  { _dotfiles_log_emit warn  2 "$*"; }
dotfiles_log_error() { _dotfiles_log_emit error 3 "$*"; }

dotfiles_log_step() {
  _dotfiles_log_emit step 1 "$*"
}
