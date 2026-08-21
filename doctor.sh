#!/usr/bin/env bash
# doctor.sh — non-destructive checks for the new platform layer.
#
# Status: PASS | WARN | FAIL | SKIP
# Exit 0 if no FAIL, 1 otherwise.

set -Eeuo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_ROOT
# shellcheck source=scripts/lib/load.sh
source "${DOTFILES_ROOT}/scripts/lib/load.sh"

dotfiles_require_bash4
dotfiles_log_init

PASSED=0
FAILED=0
WARNED=0
SKIPPED=0

print_status() {
  local status="$1"
  local msg="$2"
  case "${status}" in
    PASS) printf 'PASS  %s\n' "${msg}"; PASSED=$((PASSED + 1)) ;;
    WARN) printf 'WARN  %s\n' "${msg}"; WARNED=$((WARNED + 1)) ;;
    FAIL) printf 'FAIL  %s\n' "${msg}"; FAILED=$((FAILED + 1)) ;;
    SKIP) printf 'SKIP  %s\n' "${msg}"; SKIPPED=$((SKIPPED + 1)) ;;
  esac
}

dotfiles_detect_platform

printf 'Doctor (platform layer)\n\n'

if ((BASH_VERSINFO[0] >= 4)); then
  print_status PASS "Bash ${BASH_VERSION}"
else
  print_status FAIL "Bash 4+ required (found ${BASH_VERSION})"
fi

if [[ -f "${DOTFILES_ROOT}/scripts/lib/detect.sh" ]]; then
  print_status PASS "detect library present"
else
  print_status FAIL "detect library missing"
fi

if [[ "${DOTFILES_DETECT_IS_ROOT}" == "yes" ]]; then
  print_status WARN "running as root — installer should be run as your user"
else
  print_status PASS "not running as root (${DOTFILES_DETECT_USER})"
fi

if [[ "${DOTFILES_DETECT_TIER}" == "1" ]]; then
  print_status PASS "support tier 1 (${DOTFILES_DETECT_DISTRO})"
elif [[ "${DOTFILES_DETECT_TIER}" == "2" ]]; then
  print_status WARN "support tier 2 (${DOTFILES_DETECT_DISTRO}) — portable modules only"
elif [[ "${DOTFILES_DETECT_TIER}" == "4" ]]; then
  print_status WARN "support tier 4 (macOS) — CLI subset only"
elif [[ "${DOTFILES_DETECT_TIER}" == "3" ]]; then
  print_status WARN "support tier 3 (${DOTFILES_DETECT_DISTRO}) — best-effort"
else
  print_status FAIL "unsupported platform"
fi

if [[ "${DOTFILES_DETECT_PKG_MANAGER}" == "unknown" ]]; then
  print_status WARN "no known package manager on PATH"
else
  print_status PASS "package manager: ${DOTFILES_DETECT_PKG_MANAGER}"
fi

if [[ "${DOTFILES_DETECT_HAS_SUDO}" == "no" ]]; then
  print_status WARN "sudo not found — package installs that need root will be skipped"
else
  print_status PASS "sudo: ${DOTFILES_DETECT_HAS_SUDO}"
fi

if [[ "${DOTFILES_DETECT_HAS_SYSTEMD}" == "no" ]]; then
  print_status WARN "systemd not detected — user units will be skipped"
else
  print_status PASS "systemd available"
fi

case "${DOTFILES_DETECT_DESKTOP}" in
  niri)
    print_status PASS "desktop session: niri (Wayland backend of record)"
    ;;
  dwm)
    print_status PASS "desktop session: dwm (X11)"
    ;;
  plasma)
    print_status PASS "desktop session: plasma"
    print_status WARN "Niri is the recommended Wayland backend; plasma uses Waybar"
    ;;
  none)
    print_status SKIP "no graphical session"
    ;;
  *)
    print_status WARN "desktop session: ${DOTFILES_DETECT_DESKTOP}"
    ;;
esac

if [[ "${DOTFILES_DETECT_NIRI_BIN}" == "yes" ]]; then
  print_status PASS "niri binary on PATH"
else
  print_status SKIP "niri not installed (optional; --desktop niri later)"
fi

if [[ "${DOTFILES_DETECT_SESSION_TYPE}" == "wayland" && "${DOTFILES_DETECT_DESKTOP}" != "niri" ]]; then
  print_status WARN "Wayland session without niri — --desktop niri is the default when desktop is selected"
fi

print_status SKIP "symlink audit (linker not implemented)"
print_status SKIP "git identity (git module not migrated)"
print_status SKIP "font check (desktop/themes not migrated)"

printf '\nResults: %s passed, %s warned, %s failed, %s skipped\n' \
  "${PASSED}" "${WARNED}" "${FAILED}" "${SKIPPED}"

if ((FAILED > 0)); then
  exit "${DOTFILES_E_ERR}"
fi
exit "${DOTFILES_E_OK}"
