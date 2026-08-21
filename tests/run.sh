#!/usr/bin/env bash
# tests/run.sh — unit tests for detect, log, and the dry-run CLI.
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../scripts/lib/load.sh
source "${ROOT}/scripts/lib/load.sh"

PASS=0
FAIL=0
WORKDIR=""

cleanup() {
  if [[ -n "${WORKDIR}" && -d "${WORKDIR}" ]]; then
    rm -rf -- "${WORKDIR}"
  fi
}
trap cleanup EXIT

WORKDIR="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-test.XXXXXX")"

ok() {
  printf 'PASS  %s\n' "$1"
  PASS=$((PASS + 1))
}

fail() {
  printf 'FAIL  %s\n' "$1"
  FAIL=$((FAIL + 1))
}

assert_eq() {
  local got="$1" want="$2" msg="$3"
  if [[ "${got}" == "${want}" ]]; then
    ok "${msg}"
  else
    fail "${msg} (got '${got}' want '${want}')"
  fi
}

assert_file() {
  if [[ -f "$1" ]]; then
    ok "$2"
  else
    fail "$2 (missing $1)"
  fi
}

assert_contains() {
  local haystack="$1" needle="$2" msg="$3"
  if [[ "${haystack}" == *"${needle}"* ]]; then
    ok "${msg}"
  else
    fail "${msg} (missing '${needle}')"
  fi
}

reset_detect_env() {
  unset WAYLAND_DISPLAY DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP DESKTOP_SESSION container
  export DOTFILES_UNAME_S=Linux
  export DOTFILES_UNAME_M=x86_64
  export DOTFILES_UNAME_R=6.8.0-test
  export DOTFILES_FORCE_USER=tester
  export DOTFILES_FORCE_HOME="${WORKDIR}/home"
  export DOTFILES_FORCE_SHELL=/bin/bash
  export DOTFILES_FORCE_SESSION_TYPE=none
  export DOTFILES_FORCE_DESKTOP=none
  export DOTFILES_FORCE_VIRT=none
  export DOTFILES_SYSTEMD_DIR="${WORKDIR}/no-systemd"
  export DOTFILES_DOCKERENV_FILE="${WORKDIR}/no-dockerenv"
  export DOTFILES_PROC1_CGROUP="${WORKDIR}/empty-cgroup"
  : >"${DOTFILES_PROC1_CGROUP}"
  mkdir -p "${DOTFILES_FORCE_HOME}"
}

# --- detect ---

reset_detect_env
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-arch"
export DOTFILES_MOCK_CMDS="pacman yay"
export DOTFILES_MOCK_MISSING="apt-get dnf brew paru flatpak"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_OS}" "linux" "detect linux"
assert_eq "${DOTFILES_DETECT_DISTRO}" "arch" "detect arch"
assert_eq "${DOTFILES_DETECT_PKG_MANAGER}" "pacman" "detect pacman"
assert_eq "${DOTFILES_DETECT_AUR_HELPER}" "yay" "detect yay"
assert_eq "${DOTFILES_DETECT_TIER}" "1" "arch is tier 1"
assert_eq "${DOTFILES_DETECT_HAS_SYSTEMD}" "no" "no systemd dir => no"
assert_eq "${DOTFILES_DETECT_HAS_SUDO}" "no" "sudo mocked missing"

reset_detect_env
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-ubuntu"
export DOTFILES_MOCK_CMDS="apt-get"
export DOTFILES_MOCK_MISSING="pacman dnf brew yay paru"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_DISTRO}" "ubuntu" "detect ubuntu"
assert_eq "${DOTFILES_DETECT_PKG_MANAGER}" "apt" "detect apt"
assert_eq "${DOTFILES_DETECT_TIER}" "2" "ubuntu is tier 2"
assert_eq "${DOTFILES_DETECT_AUR_HELPER}" "none" "no AUR on ubuntu"

reset_detect_env
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-fedora"
export DOTFILES_MOCK_CMDS="dnf"
export DOTFILES_MOCK_MISSING="pacman apt-get brew"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_PKG_MANAGER}" "dnf" "detect dnf"
assert_eq "${DOTFILES_DETECT_TIER}" "2" "fedora is tier 2"

reset_detect_env
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-debian"
export DOTFILES_MOCK_CMDS="apt-get"
export DOTFILES_MOCK_MISSING="pacman dnf"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_DISTRO}" "debian" "detect debian"

reset_detect_env
export DOTFILES_UNAME_S=Darwin
export DOTFILES_OS_RELEASE_FILE="${WORKDIR}/no-os-release"
export DOTFILES_MOCK_CMDS="brew"
export DOTFILES_MOCK_MISSING="pacman apt-get dnf"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_OS}" "darwin" "detect darwin"
assert_eq "${DOTFILES_DETECT_PKG_MANAGER}" "brew" "detect brew"
assert_eq "${DOTFILES_DETECT_TIER}" "4" "macos is tier 4"

reset_detect_env
export DOTFILES_FORCE_SESSION_TYPE=wayland
export DOTFILES_FORCE_DESKTOP=niri
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-arch"
export DOTFILES_MOCK_CMDS="pacman niri"
export DOTFILES_MOCK_MISSING="apt-get"
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_SESSION_TYPE}" "wayland" "session wayland"
assert_eq "${DOTFILES_DETECT_DESKTOP}" "niri" "desktop niri"
assert_eq "${DOTFILES_DETECT_NIRI_BIN}" "yes" "niri binary mocked present"

reset_detect_env
export DOTFILES_FORCE_VIRT=container
export DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-arch"
export DOTFILES_MOCK_CMDS="pacman"
export DOTFILES_MOCK_MISSING=""
dotfiles_detect_platform
assert_eq "${DOTFILES_DETECT_VIRT}" "container" "virt override container"

# --- log redact ---
redacted="$(dotfiles_redact 'token=abc123 password: hunter2 Bearer xyz')"
assert_contains "${redacted}" "token=***" "redact token"
assert_contains "${redacted}" "password: ***" "redact password"

# --- CLI ---
help_out="$(DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --help)"
assert_contains "${help_out}" "--dry-run" "install --help mentions dry-run"
assert_contains "${help_out}" "niri" "install --help mentions niri"

set +e
bash "${ROOT}/install.sh" --not-a-flag >/dev/null 2>&1
st=$?
set -e
assert_eq "${st}" "2" "unknown flag exit 2"

set +e
bash "${ROOT}/install.sh" --profile developer >/dev/null 2>&1
st=$?
set -e
assert_eq "${st}" "3" "unimplemented profile exit 3"

dry="$(DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --dry-run 2>/dev/null)"
assert_contains "${dry}" "Detected platform" "dry-run prints detect"
assert_contains "${dry}" "Plan" "dry-run prints plan"
assert_contains "${dry}" "No files were modified" "dry-run promises no writes"

# --- detect-platform.sh --kv ---
kv="$(
  DOTFILES_OS_RELEASE_FILE="${ROOT}/tests/fixtures/os-release-arch" \
  DOTFILES_UNAME_S=Linux DOTFILES_UNAME_M=x86_64 DOTFILES_UNAME_R=1 \
  DOTFILES_FORCE_USER=tester DOTFILES_FORCE_HOME="${WORKDIR}/home" \
  DOTFILES_FORCE_SHELL=/bin/bash DOTFILES_FORCE_SESSION_TYPE=none \
  DOTFILES_FORCE_DESKTOP=none DOTFILES_FORCE_VIRT=none \
  DOTFILES_MOCK_CMDS="pacman" DOTFILES_MOCK_MISSING="apt-get dnf brew" \
  DOTFILES_SYSTEMD_DIR="${WORKDIR}/no-systemd" \
  bash "${ROOT}/scripts/detect-platform.sh" --kv
)"
assert_contains "${kv}" "DISTRO=arch" "detect-platform --kv"

printf '\n%s passed, %s failed\n' "${PASS}" "${FAIL}"
if ((FAIL > 0)); then
  exit 1
fi
exit 0
