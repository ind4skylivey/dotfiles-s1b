# shellcheck shell=bash
# scripts/lib/link.sh — idempotent per-path linker. Not GNU Stow.
#
# Public:
#   dotfiles_link_home              Print link home (DOTFILES_LINK_HOME or HOME).
#   dotfiles_link_config SRC DEST   Symlink SRC (in repo) to DEST (under home).
#   dotfiles_link_status DEST       Print already|missing|file|symlink|directory.
#
# Rules:
#   - Absolute symlink to the repo path (clone is not always ~/dotfiles).
#   - Idempotent: correct symlink is a no-op.
#   - Existing file or wrong symlink: backup, then replace dest (never write through it).
#   - Existing real directory: refuse (no rm -rf).
#   - Dest inside the repo: refuse.
#   - Src outside the repo: refuse.
#   - Dry-run: log only.
#
# Environment:
#   DOTFILES_LINK_HOME   Override home for dest (tests).
#   DOTFILES_DRY_RUN     1 = no writes.

dotfiles_link_home() {
  printf '%s' "${DOTFILES_LINK_HOME:-${HOME}}"
}

_dotfiles_abs_path() {
  local p="${1:?path required}"
  local dir base
  if [[ -d "${p}" && ! -L "${p}" ]]; then
    (cd -- "${p}" && pwd)
    return
  fi
  dir="$(dirname -- "${p}")"
  base="$(basename -- "${p}")"
  if [[ ! -d "${dir}" ]]; then
    printf '%s/%s' "${dir}" "${base}"
    return
  fi
  printf '%s/%s' "$(cd -- "${dir}" && pwd)" "${base}"
}

_dotfiles_under_root() {
  local path="$1" root="$2"
  [[ "${path}" == "${root}" || "${path}" == "${root}"/* ]]
}

dotfiles_link_status() {
  local dest="${1:?dest required}"
  if [[ -L "${dest}" ]]; then
    printf 'symlink'
  elif [[ -f "${dest}" ]]; then
    printf 'file'
  elif [[ -d "${dest}" ]]; then
    printf 'directory'
  else
    printf 'missing'
  fi
}

_dotfiles_link_already() {
  local dest="$1" src_abs="$2"
  [[ -L "${dest}" ]] || return 1
  [[ "$(readlink -- "${dest}")" == "${src_abs}" ]]
}

_dotfiles_link_backup_replace() {
  local dest="$1"
  local saved_id="${DOTFILES_BACKUP_ID:-}"
  local saved_dir="${DOTFILES_BACKUP_DIR:-}"
  local saved_seq="${_DOTFILES_BACKUP_SEQ:-0}"
  DOTFILES_BACKUP_ID=""
  DOTFILES_BACKUP_DIR=""
  _DOTFILES_BACKUP_SEQ=0
  dotfiles_backup_begin "link-$(date -u +'%Y-%m-%dT%H%M%SZ')"
  dotfiles_backup_file "${dest}" "link-replace"
  dotfiles_backup_finalize
  DOTFILES_BACKUP_ID="${saved_id}"
  DOTFILES_BACKUP_DIR="${saved_dir}"
  _DOTFILES_BACKUP_SEQ="${saved_seq}"
}

# Returns 0 on created / replaced / already. 1 on error.
dotfiles_link_config() {
  local src="${1:?source required}"
  local dest="${2:?destination required}"
  local root_abs src_abs dest_abs dest_parent

  root_abs="$(cd -- "${DOTFILES_ROOT}" && pwd)"

  if [[ "${src}" != /* ]]; then
    src="${DOTFILES_ROOT}/${src}"
  fi
  if [[ ! -e "${src}" && ! -L "${src}" ]]; then
    dotfiles_log_error "link source missing: ${src}"
    return 1
  fi
  src_abs="$(_dotfiles_abs_path "${src}")"
  if ! _dotfiles_under_root "${src_abs}" "${root_abs}"; then
    dotfiles_log_error "refusing to link source outside the repository: ${src_abs}"
    return 1
  fi

  if [[ "${dest}" != /* ]]; then
    dest="$(dotfiles_link_home)/${dest}"
  fi
  dest_parent="$(dirname -- "${dest}")"
  if [[ -d "${dest_parent}" ]]; then
    dest_abs="$(_dotfiles_abs_path "${dest}")"
  else
    dest_abs="${dest}"
  fi
  if _dotfiles_under_root "${dest_abs}" "${root_abs}"; then
    dotfiles_log_error "refusing to create a link inside the repository: ${dest_abs}"
    return 1
  fi

  if _dotfiles_link_already "${dest}" "${src_abs}"; then
    dotfiles_log_info "already linked ${dest} -> ${src_abs}"
    return 0
  fi

  if [[ -d "${dest}" && ! -L "${dest}" ]]; then
    dotfiles_log_error "refusing to replace directory ${dest} (no rm -rf); move it aside first"
    return 1
  fi

  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    if [[ -e "${dest}" || -L "${dest}" ]]; then
      dotfiles_log_info "would backup and replace ${dest} -> ${src_abs}"
    else
      dotfiles_log_info "would link ${dest} -> ${src_abs}"
    fi
    return 0
  fi

  if [[ -e "${dest}" || -L "${dest}" ]]; then
    _dotfiles_link_backup_replace "${dest}"
    rm -- "${dest}"
  fi

  mkdir -p -- "$(dirname -- "${dest}")"
  ln -s -- "${src_abs}" "${dest}"
  dotfiles_log_info "linked ${dest} -> ${src_abs}"
}
