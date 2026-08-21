#!/usr/bin/env bash
# tests/run.sh — unit tests for detect, log, CLI, backup, restore, rollback, linker.
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

# dry-run must not create backup dirs in real state
before_backups="$(find "${XDG_STATE_HOME:-${HOME}/.local/state}/dotfiles/backups" -mindepth 1 -maxdepth 1 2>/dev/null | wc -l || true)"
DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --dry-run --backup >/dev/null 2>&1 || true
after_backups="$(find "${XDG_STATE_HOME:-${HOME}/.local/state}/dotfiles/backups" -mindepth 1 -maxdepth 1 2>/dev/null | wc -l || true)"
assert_eq "${after_backups}" "${before_backups}" "dry-run --backup creates no backup dirs"

# --- backup / restore ---
export DOTFILES_BACKUP_ROOT="${WORKDIR}/backups"
export DOTFILES_DRY_RUN=0
unset DOTFILES_MOCK_CMDS DOTFILES_MOCK_MISSING

sample="${WORKDIR}/home/.zshrc"
mkdir -p "$(dirname -- "${sample}")"
printf 'original\n' >"${sample}"
chmod 644 "${sample}"

id1="$(bash "${ROOT}/scripts/backup.sh" --id test-file "${sample}")"
assert_eq "${id1}" "test-file" "backup.sh prints id"
assert_file "${DOTFILES_BACKUP_ROOT}/test-file/manifest.json" "manifest.json written"
assert_file "${DOTFILES_BACKUP_ROOT}/test-file/checksums.sha256" "checksums.sha256 written"
assert_file "${DOTFILES_BACKUP_ROOT}/test-file/restore.sh" "restore.sh written"

printf 'changed\n' >"${sample}"
dotfiles_backup_restore "test-file"
got="$(cat "${sample}")"
assert_eq "${got}" "original" "restore regular file content"

# permissions
mode="$(_dotfiles_stat_mode "${sample}")"
assert_eq "${mode}" "644" "restore keeps mode 644"

# symlink
link="${WORKDIR}/home/.vimrc"
ln -s .zshrc "${link}"
id2="$(bash "${ROOT}/scripts/backup.sh" --id test-link "${link}")"
rm -f "${link}"
ln -s /tmp/wrong "${link}"
dotfiles_backup_restore "test-link"
target="$(readlink "${link}")"
assert_eq "${target}" ".zshrc" "restore symlink target"

# missing path
missing="${WORKDIR}/home/does-not-exist"
id3="$(bash "${ROOT}/scripts/backup.sh" --id test-missing "${missing}")"
assert_file "${DOTFILES_BACKUP_ROOT}/test-missing/restore.tsv" "missing path recorded"
dotfiles_backup_restore "test-missing"
if [[ ! -e "${missing}" ]]; then
  ok "restore missing path does not create a file"
else
  fail "restore missing path created ${missing}"
fi

# rollback after modify
roll="${WORKDIR}/home/rollback.txt"
printf 'v1\n' >"${roll}"
dotfiles_backup_begin "test-rollback"
dotfiles_backup_file "${roll}"
dotfiles_backup_finalize
printf 'v2\n' >"${roll}"
dotfiles_backup_rollback
got="$(cat "${roll}")"
assert_eq "${got}" "v1" "rollback restores previous content"

# Repeated snapshots: restore newer then older
printf 'a\n' >"${sample}"
bash "${ROOT}/scripts/backup.sh" --id repeat-1 "${sample}" >/dev/null
printf 'b\n' >"${sample}"
bash "${ROOT}/scripts/backup.sh" --id repeat-2 "${sample}" >/dev/null
printf 'c\n' >"${sample}"
dotfiles_backup_restore "repeat-2"
got="$(cat "${sample}")"
assert_eq "${got}" "b" "restore newer snapshot"
dotfiles_backup_restore "repeat-1"
got="$(cat "${sample}")"
assert_eq "${got}" "a" "restore older snapshot still works"

# dry-run backup writes nothing new
export DOTFILES_DRY_RUN=1
count_before="$(find "${DOTFILES_BACKUP_ROOT}" -mindepth 1 -maxdepth 1 -type d | wc -l)"
dotfiles_backup_begin "dry-should-not-exist"
dotfiles_backup_file "${sample}"
dotfiles_backup_finalize
count_after="$(find "${DOTFILES_BACKUP_ROOT}" -mindepth 1 -maxdepth 1 -type d | wc -l)"
assert_eq "${count_after}" "${count_before}" "dry-run backup creates no session dir"
export DOTFILES_DRY_RUN=0

# restore.sh --list
list_out="$(DOTFILES_BACKUP_ROOT="${DOTFILES_BACKUP_ROOT}" bash "${ROOT}/restore.sh" --list)"
assert_contains "${list_out}" "test-file" "restore --list shows backup id"

# CLI restore --backup-id
printf 'mutated\n' >"${sample}"
DOTFILES_BACKUP_ROOT="${DOTFILES_BACKUP_ROOT}" bash "${ROOT}/restore.sh" --backup-id test-file
got="$(cat "${sample}")"
assert_eq "${got}" "original" "restore.sh --backup-id restores file"

# wrong-type skip: file dest vs symlink backup
rm -f -- "${link}"
printf 'keep-me\n' >"${link}"
# ${link} is now a regular file. Restoring test-link (symlink) should skip.
DOTFILES_BACKUP_ROOT="${DOTFILES_BACKUP_ROOT}" bash "${ROOT}/restore.sh" --backup-id test-link >/dev/null 2>&1 || true
if [[ -f "${link}" && ! -L "${link}" ]]; then
  got="$(cat "${link}")"
  assert_eq "${got}" "keep-me" "restore skips when dest type differs (does not delete file)"
else
  fail "restore replaced a regular file with a symlink"
fi

# --- linker ---
unset DOTFILES_BACKUP_ID DOTFILES_BACKUP_DIR
export DOTFILES_LINK_HOME="${WORKDIR}/link-home"
mkdir -p "${DOTFILES_LINK_HOME}"
export DOTFILES_DRY_RUN=0
src_rel="config/defaults.toml"
src_abs="$(_dotfiles_abs_path "${ROOT}/${src_rel}")"
link_dest=".config/dotfiles/defaults.toml"
link_abs="${DOTFILES_LINK_HOME}/${link_dest}"

DOTFILES_DRY_RUN=1
dotfiles_link_config "${src_rel}" "${link_dest}"
DOTFILES_DRY_RUN=0
if [[ ! -e "${link_abs}" && ! -L "${link_abs}" ]]; then
  ok "dry-run link creates no dest"
else
  fail "dry-run link created ${link_abs}"
fi

dotfiles_link_config "${src_rel}" "${link_dest}"
assert_eq "$(readlink -- "${link_abs}")" "${src_abs}" "link creates absolute symlink"
dotfiles_link_config "${src_rel}" "${link_dest}"
assert_eq "$(readlink -- "${link_abs}")" "${src_abs}" "link is idempotent"

# replace a regular file (backup first, do not write through)
before_hash="$(_dotfiles_sha256_file "${src_abs}")"
rm -f -- "${link_abs}"
printf 'old-content\n' >"${link_abs}"
dotfiles_link_config "${src_rel}" "${link_dest}"
assert_eq "$(readlink -- "${link_abs}")" "${src_abs}" "replaces regular file with symlink"
assert_eq "$(_dotfiles_sha256_file "${src_abs}")" "${before_hash}" "replacing dest does not mutate repo source"
link_backups="$(find "${DOTFILES_BACKUP_ROOT}" -maxdepth 1 -type d -name 'link-*' | wc -l)"
if [[ "${link_backups}" -ge 1 ]]; then
  ok "replace created a link-* backup session"
else
  fail "replace did not create a backup session"
fi

# refuse real directory
dir_dest="${DOTFILES_LINK_HOME}/keep-dir"
mkdir -p "${dir_dest}/nested"
set +e
dotfiles_link_config "${src_rel}" "${dir_dest}"
st=$?
set -e
assert_eq "${st}" "1" "refuse to replace a directory"
if [[ -d "${dir_dest}" && ! -L "${dir_dest}" && -d "${dir_dest}/nested" ]]; then
  ok "directory dest left intact"
else
  fail "linker removed or replaced a directory"
fi

# refuse dest inside the repo
set +e
dotfiles_link_config "${src_rel}" "${ROOT}/should-not-be-linked"
st=$?
set -e
assert_eq "${st}" "1" "refuse dest inside repository"
if [[ ! -e "${ROOT}/should-not-be-linked" && ! -L "${ROOT}/should-not-be-linked" ]]; then
  ok "no symlink created inside repository"
else
  fail "linker wrote inside the repository"
  rm -f -- "${ROOT}/should-not-be-linked"
fi

# missing source
set +e
dotfiles_link_config "no-such-source.toml" "${DOTFILES_LINK_HOME}/missing-src"
st=$?
set -e
assert_eq "${st}" "1" "missing source is an error"

# CLI
help_link="$(DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --help)"
assert_contains "${help_link}" "--link" "install --help mentions --link"
cli_dest="${DOTFILES_LINK_HOME}/from-cli"
DOTFILES_LINK_HOME="${DOTFILES_LINK_HOME}" bash "${ROOT}/scripts/link.sh" --dry-run "${src_rel}" "${cli_dest}" >/dev/null
if [[ ! -e "${cli_dest}" && ! -L "${cli_dest}" ]]; then
  ok "link.sh --dry-run writes nothing"
else
  fail "link.sh --dry-run created dest"
fi
DOTFILES_LINK_HOME="${DOTFILES_LINK_HOME}" bash "${ROOT}/install.sh" --link "${src_rel}" "${cli_dest}" >/dev/null
assert_eq "$(readlink -- "${cli_dest}")" "${src_abs}" "install.sh --link creates symlink"

# --- shell module ---
assert_file "${ROOT}/modules/shell/home/.zshrc" "portable zshrc exists"
assert_file "${ROOT}/modules/shell/home/.config/fish/config.fish" "portable fish config exists"
if grep -R -E 'alias[[:space:]]+kali|/tmp/\.tmp|/home/il1v3y|/media/il1v3y' "${ROOT}/modules/shell/home" >/dev/null 2>&1; then
  fail "portable shell contains forbidden host or offensive strings"
else
  ok "portable shell has no dump/host/offensive strings"
fi
if grep -qE 'alias[[:space:]]+kali=' "${ROOT}/.zshrc"; then
  ok "repo-root dump zshrc still has kali (not copied into the module)"
else
  fail "expected dump .zshrc to still contain kali alias (module must be a new file)"
fi

dry_min="$(DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --dry-run --profile minimal 2>/dev/null)"
assert_contains "${dry_min}" "[link]" "minimal dry-run plans links"
assert_contains "${dry_min}" ".zshrc" "minimal dry-run plans .zshrc"
assert_contains "${dry_min}" "No files were modified" "minimal dry-run still writes nothing"

dry_none="$(DOTFILES_NO_COLOR=1 bash "${ROOT}/install.sh" --dry-run 2>/dev/null)"
assert_contains "${dry_none}" "pass --profile minimal" "no-profile dry-run skips shell until asked"

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
