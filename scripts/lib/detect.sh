# shellcheck shell=bash
# scripts/lib/detect.sh — inspect the host. Read-only. Mockable for tests.
#
# Public:
#   dotfiles_detect_platform      Populate DOTFILES_DETECT_* variables.
#   dotfiles_detect_report        Human-readable summary to stdout.
#   dotfiles_detect_kv            KEY=VALUE lines to stdout (stable contract).
#
# Environment (tests / overrides):
#   DOTFILES_OS_RELEASE_FILE      Default /etc/os-release
#   DOTFILES_UNAME_S / _M / _R    Override uname fields
#   DOTFILES_PROC1_CGROUP         Override /proc/1/cgroup path
#   DOTFILES_DOCKERENV_FILE       Override /.dockerenv path
#   DOTFILES_SYSTEMD_DIR          Override /run/systemd/system
#   DOTFILES_MOCK_CMDS/MISSING    See common.sh
#   DOTFILES_FORCE_USER/HOME      Override id/home (tests)
#   DOTFILES_FORCE_SHELL          Override $SHELL
#   DOTFILES_FORCE_SESSION_TYPE   wayland|x11|none
#   DOTFILES_FORCE_DESKTOP        niri|dwm|plasma|gnome|unknown|none
#   DOTFILES_FORCE_VIRT           container|vm|none
#
# Does not: install packages, write files, call sudo (unless
# DOTFILES_CHECK_SUDO_USABLE=1), or probe the network.

dotfiles_detect_platform() {
  _dotfiles_detect_kernel
  _dotfiles_detect_os_release
  _dotfiles_detect_pkg
  _dotfiles_detect_identity
  _dotfiles_detect_xdg
  _dotfiles_detect_session
  _dotfiles_detect_privileges
  _dotfiles_detect_virt
  _dotfiles_detect_tier
  _dotfiles_detect_desktop_available
}

_dotfiles_uname() {
  local flag="$1"
  case "${flag}" in
    -s) printf '%s' "${DOTFILES_UNAME_S:-$(uname -s)}" ;;
    -m) printf '%s' "${DOTFILES_UNAME_M:-$(uname -m)}" ;;
    -r) printf '%s' "${DOTFILES_UNAME_R:-$(uname -r)}" ;;
    *)  uname "${flag}" ;;
  esac
}

_dotfiles_detect_kernel() {
  local sys
  sys="$(_dotfiles_uname -s)"
  case "${sys}" in
    Linux)  DOTFILES_DETECT_OS="linux" ;;
    Darwin) DOTFILES_DETECT_OS="darwin" ;;
    *)      DOTFILES_DETECT_OS="unknown" ;;
  esac
  DOTFILES_DETECT_ARCH="$(_dotfiles_uname -m)"
  DOTFILES_DETECT_KERNEL="$(_dotfiles_uname -r)"
}

_dotfiles_detect_os_release() {
  local file="${DOTFILES_OS_RELEASE_FILE:-/etc/os-release}"
  DOTFILES_DETECT_DISTRO="unknown"
  DOTFILES_DETECT_DISTRO_LIKE=""
  DOTFILES_DETECT_DISTRO_VERSION=""
  DOTFILES_DETECT_DISTRO_PRETTY=""

  if [[ "${DOTFILES_DETECT_OS}" == "darwin" ]]; then
    DOTFILES_DETECT_DISTRO="macos"
    if dotfiles_have_cmd sw_vers; then
      DOTFILES_DETECT_DISTRO_VERSION="$(sw_vers -productVersion 2>/dev/null || true)"
    fi
    DOTFILES_DETECT_DISTRO_PRETTY="macOS ${DOTFILES_DETECT_DISTRO_VERSION}"
    return 0
  fi

  if [[ ! -r "${file}" ]]; then
    dotfiles_log_debug "os-release not readable: ${file}"
    return 0
  fi

  # Parse without sourcing (avoid executing unknown files).
  local line key value
  while IFS= read -r line || [[ -n "${line}" ]]; do
    [[ "${line}" =~ ^[[:space:]]*# ]] && continue
    [[ "${line}" != *=* ]] && continue
    key="${line%%=*}"
    value="${line#*=}"
    value="${value%\"}"
    value="${value#\"}"
    value="${value%\'}"
    value="${value#\'}"
    case "${key}" in
      ID)          DOTFILES_DETECT_DISTRO="${value}" ;;
      ID_LIKE)     DOTFILES_DETECT_DISTRO_LIKE="${value}" ;;
      VERSION_ID)  DOTFILES_DETECT_DISTRO_VERSION="${value}" ;;
      PRETTY_NAME) DOTFILES_DETECT_DISTRO_PRETTY="${value}" ;;
    esac
  done <"${file}"
}

_dotfiles_id_like_has() {
  local needle="$1"
  [[ " ${DOTFILES_DETECT_DISTRO} ${DOTFILES_DETECT_DISTRO_LIKE} " == *" ${needle} "* ]]
}

_dotfiles_detect_pkg() {
  DOTFILES_DETECT_PKG_MANAGER="unknown"
  DOTFILES_DETECT_AUR_HELPER="none"

  if [[ "${DOTFILES_DETECT_OS}" == "darwin" ]]; then
    if dotfiles_have_cmd brew; then
      DOTFILES_DETECT_PKG_MANAGER="brew"
    fi
    return 0
  fi

  if dotfiles_have_cmd pacman; then
    DOTFILES_DETECT_PKG_MANAGER="pacman"
    if dotfiles_have_cmd yay; then
      DOTFILES_DETECT_AUR_HELPER="yay"
    elif dotfiles_have_cmd paru; then
      DOTFILES_DETECT_AUR_HELPER="paru"
    fi
  elif dotfiles_have_cmd apt-get; then
    DOTFILES_DETECT_PKG_MANAGER="apt"
  elif dotfiles_have_cmd dnf; then
    DOTFILES_DETECT_PKG_MANAGER="dnf"
  elif dotfiles_have_cmd zypper; then
    DOTFILES_DETECT_PKG_MANAGER="zypper"
  elif dotfiles_have_cmd apk; then
    DOTFILES_DETECT_PKG_MANAGER="apk"
  elif dotfiles_have_cmd brew; then
    DOTFILES_DETECT_PKG_MANAGER="brew"
  fi

  DOTFILES_DETECT_HAS_FLATPAK="no"
  if dotfiles_have_cmd flatpak; then
    DOTFILES_DETECT_HAS_FLATPAK="yes"
  fi
}

_dotfiles_detect_identity() {
  if [[ -n "${DOTFILES_FORCE_USER:-}" ]]; then
    DOTFILES_DETECT_USER="${DOTFILES_FORCE_USER}"
  else
    DOTFILES_DETECT_USER="${USER:-$(id -un 2>/dev/null || printf unknown)}"
  fi

  if [[ -n "${DOTFILES_FORCE_HOME:-}" ]]; then
    DOTFILES_DETECT_HOME="${DOTFILES_FORCE_HOME}"
  else
    DOTFILES_DETECT_HOME="${HOME:-/}"
  fi

  if [[ -n "${DOTFILES_FORCE_SHELL:-}" ]]; then
    DOTFILES_DETECT_SHELL="${DOTFILES_FORCE_SHELL}"
  else
    DOTFILES_DETECT_SHELL="${SHELL:-unknown}"
  fi
  DOTFILES_DETECT_SHELL_NAME="$(basename -- "${DOTFILES_DETECT_SHELL}")"

  if [[ -n "${DOTFILES_FORCE_USER:-}" ]]; then
    DOTFILES_DETECT_IS_ROOT="no"
  elif [[ "$(id -u 2>/dev/null || printf 1)" == "0" ]]; then
    DOTFILES_DETECT_IS_ROOT="yes"
  else
    DOTFILES_DETECT_IS_ROOT="no"
  fi
}

_dotfiles_detect_xdg() {
  local home="${DOTFILES_DETECT_HOME}"
  DOTFILES_DETECT_XDG_CONFIG="${XDG_CONFIG_HOME:-${home}/.config}"
  DOTFILES_DETECT_XDG_DATA="${XDG_DATA_HOME:-${home}/.local/share}"
  DOTFILES_DETECT_XDG_STATE="${XDG_STATE_HOME:-${home}/.local/state}"
  DOTFILES_DETECT_XDG_CACHE="${XDG_CACHE_HOME:-${home}/.cache}"
}

_dotfiles_detect_session() {
  if [[ -n "${DOTFILES_FORCE_SESSION_TYPE:-}" ]]; then
    DOTFILES_DETECT_SESSION_TYPE="${DOTFILES_FORCE_SESSION_TYPE}"
  elif [[ -n "${WAYLAND_DISPLAY:-}" || "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    DOTFILES_DETECT_SESSION_TYPE="wayland"
  elif [[ -n "${DISPLAY:-}" || "${XDG_SESSION_TYPE:-}" == "x11" ]]; then
    DOTFILES_DETECT_SESSION_TYPE="x11"
  else
    DOTFILES_DETECT_SESSION_TYPE="none"
  fi

  if [[ "${DOTFILES_DETECT_SESSION_TYPE}" == "none" ]]; then
    DOTFILES_DETECT_GRAPHICAL="no"
  else
    DOTFILES_DETECT_GRAPHICAL="yes"
  fi

  if [[ -n "${DOTFILES_FORCE_DESKTOP:-}" ]]; then
    DOTFILES_DETECT_DESKTOP="${DOTFILES_FORCE_DESKTOP}"
    return 0
  fi

  local desktop="${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-}}"
  desktop="${desktop,,}"
  case "${desktop}" in
    *niri*)   DOTFILES_DETECT_DESKTOP="niri" ;;
    *kde*|*plasma*) DOTFILES_DETECT_DESKTOP="plasma" ;;
    *gnome*)  DOTFILES_DETECT_DESKTOP="gnome" ;;
    *hypr*)   DOTFILES_DETECT_DESKTOP="hyprland" ;;
    *sway*)   DOTFILES_DETECT_DESKTOP="sway" ;;
    *xfce*)   DOTFILES_DETECT_DESKTOP="xfce" ;;
    "")
      if [[ -n "${DISPLAY:-}" ]] && dotfiles_have_cmd pgrep && pgrep -x dwm >/dev/null 2>&1; then
        DOTFILES_DETECT_DESKTOP="dwm"
      elif [[ "${DOTFILES_DETECT_GRAPHICAL}" == "no" ]]; then
        DOTFILES_DETECT_DESKTOP="none"
      else
        DOTFILES_DETECT_DESKTOP="unknown"
      fi
      ;;
    *) DOTFILES_DETECT_DESKTOP="unknown" ;;
  esac
}

_dotfiles_detect_privileges() {
  local systemd_dir="${DOTFILES_SYSTEMD_DIR:-/run/systemd/system}"
  if [[ -d "${systemd_dir}" ]]; then
    DOTFILES_DETECT_HAS_SYSTEMD="yes"
  else
    DOTFILES_DETECT_HAS_SYSTEMD="no"
  fi

  if [[ "${DOTFILES_DETECT_IS_ROOT}" == "yes" ]]; then
    DOTFILES_DETECT_HAS_SUDO="n/a-root"
    return 0
  fi

  if ! dotfiles_have_cmd sudo; then
    DOTFILES_DETECT_HAS_SUDO="no"
    return 0
  fi

  DOTFILES_DETECT_HAS_SUDO="binary"
  if dotfiles_is_truthy "${DOTFILES_CHECK_SUDO_USABLE:-0}"; then
    if sudo -n true >/dev/null 2>&1; then
      DOTFILES_DETECT_HAS_SUDO="usable"
    else
      DOTFILES_DETECT_HAS_SUDO="needs-password"
    fi
  fi
}

_dotfiles_detect_virt() {
  if [[ -n "${DOTFILES_FORCE_VIRT:-}" ]]; then
    DOTFILES_DETECT_VIRT="${DOTFILES_FORCE_VIRT}"
    return 0
  fi

  DOTFILES_DETECT_VIRT="none"
  local dockerenv="${DOTFILES_DOCKERENV_FILE:-/.dockerenv}"
  local cgroup="${DOTFILES_PROC1_CGROUP:-/proc/1/cgroup}"

  if [[ -n "${container:-}" || -e "${dockerenv}" ]]; then
    DOTFILES_DETECT_VIRT="container"
    return 0
  fi
  if [[ -r "${cgroup}" ]] && grep -Eqi 'docker|lxc|containerd|podman|kubepods' "${cgroup}"; then
    DOTFILES_DETECT_VIRT="container"
    return 0
  fi
  if [[ -f /run/.containerenv ]]; then
    DOTFILES_DETECT_VIRT="container"
    return 0
  fi

  if dotfiles_have_cmd systemd-detect-virt; then
    local virt
    virt="$(systemd-detect-virt 2>/dev/null || true)"
    case "${virt}" in
      none|"") ;;
      docker|lxc|podman|container-other|systemd-nspawn)
        DOTFILES_DETECT_VIRT="container"
        return 0
        ;;
      *)
        DOTFILES_DETECT_VIRT="vm"
        return 0
        ;;
    esac
  fi
}

_dotfiles_detect_tier() {
  DOTFILES_DETECT_TIER="unsupported"
  case "${DOTFILES_DETECT_OS}" in
    darwin)
      DOTFILES_DETECT_TIER="4"
      ;;
    linux)
      if _dotfiles_id_like_has arch || [[ "${DOTFILES_DETECT_DISTRO}" == "cachyos" ]]; then
        DOTFILES_DETECT_TIER="1"
      elif _dotfiles_id_like_has fedora || _dotfiles_id_like_has debian || _dotfiles_id_like_has ubuntu \
        || [[ "${DOTFILES_DETECT_DISTRO}" =~ ^(fedora|debian|ubuntu|linuxmint|pop)$ ]]; then
        DOTFILES_DETECT_TIER="2"
      else
        DOTFILES_DETECT_TIER="3"
      fi
      ;;
  esac
}

_dotfiles_detect_desktop_available() {
  DOTFILES_DETECT_NIRI_BIN="no"
  DOTFILES_DETECT_DWM_BIN="no"
  if dotfiles_have_cmd niri; then
    DOTFILES_DETECT_NIRI_BIN="yes"
  fi
  if dotfiles_have_cmd dwm; then
    DOTFILES_DETECT_DWM_BIN="yes"
  fi
}

dotfiles_detect_kv() {
  cat <<EOF
OS=${DOTFILES_DETECT_OS}
DISTRO=${DOTFILES_DETECT_DISTRO}
DISTRO_LIKE=${DOTFILES_DETECT_DISTRO_LIKE}
DISTRO_VERSION=${DOTFILES_DETECT_DISTRO_VERSION}
DISTRO_PRETTY=${DOTFILES_DETECT_DISTRO_PRETTY}
ARCH=${DOTFILES_DETECT_ARCH}
KERNEL=${DOTFILES_DETECT_KERNEL}
PKG_MANAGER=${DOTFILES_DETECT_PKG_MANAGER}
AUR_HELPER=${DOTFILES_DETECT_AUR_HELPER}
HAS_FLATPAK=${DOTFILES_DETECT_HAS_FLATPAK}
SHELL=${DOTFILES_DETECT_SHELL}
SHELL_NAME=${DOTFILES_DETECT_SHELL_NAME}
USER=${DOTFILES_DETECT_USER}
HOME=${DOTFILES_DETECT_HOME}
XDG_CONFIG=${DOTFILES_DETECT_XDG_CONFIG}
XDG_DATA=${DOTFILES_DETECT_XDG_DATA}
XDG_STATE=${DOTFILES_DETECT_XDG_STATE}
XDG_CACHE=${DOTFILES_DETECT_XDG_CACHE}
SESSION_TYPE=${DOTFILES_DETECT_SESSION_TYPE}
GRAPHICAL=${DOTFILES_DETECT_GRAPHICAL}
DESKTOP=${DOTFILES_DETECT_DESKTOP}
NIRI_BIN=${DOTFILES_DETECT_NIRI_BIN}
DWM_BIN=${DOTFILES_DETECT_DWM_BIN}
IS_ROOT=${DOTFILES_DETECT_IS_ROOT}
HAS_SUDO=${DOTFILES_DETECT_HAS_SUDO}
HAS_SYSTEMD=${DOTFILES_DETECT_HAS_SYSTEMD}
VIRT=${DOTFILES_DETECT_VIRT}
TIER=${DOTFILES_DETECT_TIER}
EOF
}

dotfiles_detect_report() {
  printf 'Detected platform\n'
  printf '  OS:            %s\n' "${DOTFILES_DETECT_OS}"
  printf '  Distro:        %s (%s)\n' "${DOTFILES_DETECT_DISTRO_PRETTY:-${DOTFILES_DETECT_DISTRO}}" "${DOTFILES_DETECT_DISTRO}"
  printf '  Version:       %s\n' "${DOTFILES_DETECT_DISTRO_VERSION:-unknown}"
  printf '  Arch:          %s\n' "${DOTFILES_DETECT_ARCH}"
  printf '  Kernel:        %s\n' "${DOTFILES_DETECT_KERNEL}"
  printf '  Package mgr:   %s\n' "${DOTFILES_DETECT_PKG_MANAGER}"
  printf '  AUR helper:    %s\n' "${DOTFILES_DETECT_AUR_HELPER}"
  printf '  Flatpak:       %s\n' "${DOTFILES_DETECT_HAS_FLATPAK}"
  printf '  Shell:         %s\n' "${DOTFILES_DETECT_SHELL}"
  printf '  User:          %s\n' "${DOTFILES_DETECT_USER}"
  printf '  HOME:          %s\n' "${DOTFILES_DETECT_HOME}"
  printf '  XDG config:    %s\n' "${DOTFILES_DETECT_XDG_CONFIG}"
  printf '  XDG state:     %s\n' "${DOTFILES_DETECT_XDG_STATE}"
  printf '  Session:       %s (graphical=%s)\n' "${DOTFILES_DETECT_SESSION_TYPE}" "${DOTFILES_DETECT_GRAPHICAL}"
  printf '  Desktop:       %s\n' "${DOTFILES_DETECT_DESKTOP}"
  printf '  Niri binary:   %s\n' "${DOTFILES_DETECT_NIRI_BIN}"
  printf '  DWM binary:    %s\n' "${DOTFILES_DETECT_DWM_BIN}"
  printf '  Root:          %s\n' "${DOTFILES_DETECT_IS_ROOT}"
  printf '  Sudo:          %s\n' "${DOTFILES_DETECT_HAS_SUDO}"
  printf '  systemd:       %s\n' "${DOTFILES_DETECT_HAS_SYSTEMD}"
  printf '  Virt:          %s\n' "${DOTFILES_DETECT_VIRT}"
  printf '  Support tier:  %s\n' "${DOTFILES_DETECT_TIER}"
}
