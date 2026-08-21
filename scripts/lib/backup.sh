# shellcheck shell=bash
# scripts/lib/backup.sh — copy-only backups with manifest, checksums, restore.
#
# Public:
#   dotfiles_backup_root            Print backup root directory.
#   dotfiles_backup_begin [ID]      Create a backup session (no-op in dry-run).
#   dotfiles_backup_file PATH [OP]  Copy PATH into the session (file/symlink/dir/missing).
#   dotfiles_backup_finalize        Write manifest.json, checksums, restore.sh.
#   dotfiles_backup_restore ID      Restore that session.
#   dotfiles_backup_rollback        Restore the current session.
#   dotfiles_backup_latest          Print newest backup id (empty if none).
#   dotfiles_backup_list            Print ids, newest last.
#
# Environment:
#   DOTFILES_BACKUP_ROOT            Override store (tests).
#   DOTFILES_DRY_RUN                1 = log only, no writes.
#
# Never deletes user data. Never follows dest symlinks when copying
# (cp -a / cp -P). Dry-run does not create directories.

_DOTFILES_BACKUP_SEQ=0
DOTFILES_BACKUP_ID="${DOTFILES_BACKUP_ID:-}"
DOTFILES_BACKUP_DIR="${DOTFILES_BACKUP_DIR:-}"

dotfiles_backup_root() {
  local xdg="${XDG_STATE_HOME:-${HOME}/.local/state}"
  printf '%s' "${DOTFILES_BACKUP_ROOT:-${xdg}/dotfiles/backups}"
}

_dotfiles_backup_now_id() {
  date -u +'%Y-%m-%dT%H%M%SZ'
}

_dotfiles_json_escape() {
  local s="${1:-}"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\t'/\\t}"
  printf '%s' "${s}"
}

_dotfiles_stat_mode() {
  local path="$1"
  if stat -c '%a' "${path}" >/dev/null 2>&1; then
    stat -c '%a' "${path}"
  else
    stat -f '%OLp' "${path}"
  fi
}

_dotfiles_stat_owner() {
  local path="$1"
  if stat -c '%U' "${path}" >/dev/null 2>&1; then
    stat -c '%U' "${path}"
  else
    stat -f '%Su' "${path}"
  fi
}

_dotfiles_stat_group() {
  local path="$1"
  if stat -c '%G' "${path}" >/dev/null 2>&1; then
    stat -c '%G' "${path}"
  else
    stat -f '%Sg' "${path}"
  fi
}

_dotfiles_sha256_file() {
  local path="$1"
  if dotfiles_have_cmd sha256sum; then
    sha256sum -- "${path}" | awk '{print $1}'
  elif dotfiles_have_cmd shasum; then
    shasum -a 256 -- "${path}" | awk '{print $1}'
  else
    printf 'unavailable'
  fi
}

_dotfiles_sha256_string() {
  local data="$1"
  if dotfiles_have_cmd sha256sum; then
    printf '%s' "${data}" | sha256sum | awk '{print $1}'
  elif dotfiles_have_cmd shasum; then
    printf '%s' "${data}" | shasum -a 256 | awk '{print $1}'
  else
    printf 'unavailable'
  fi
}

dotfiles_backup_list() {
  local root
  root="$(dotfiles_backup_root)"
  if [[ ! -d "${root}" ]]; then
    return 0
  fi
  find "${root}" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
    | LC_ALL=C sort
}

dotfiles_backup_latest() {
  dotfiles_backup_list | tail -n 1
}

dotfiles_backup_begin() {
  local requested="${1:-}"
  local root
  root="$(dotfiles_backup_root)"

  if [[ -n "${requested}" ]]; then
    DOTFILES_BACKUP_ID="${requested}"
  else
    DOTFILES_BACKUP_ID="$(_dotfiles_backup_now_id)"
    if [[ -d "${root}/${DOTFILES_BACKUP_ID}" ]]; then
      DOTFILES_BACKUP_ID="${DOTFILES_BACKUP_ID}-$$"
    fi
  fi

  DOTFILES_BACKUP_DIR="${root}/${DOTFILES_BACKUP_ID}"
  _DOTFILES_BACKUP_SEQ=0

  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    dotfiles_log_info "would create backup ${DOTFILES_BACKUP_ID} at ${DOTFILES_BACKUP_DIR}"
    return 0
  fi

  mkdir -p -- "${DOTFILES_BACKUP_DIR}/files"
  : >"${DOTFILES_BACKUP_DIR}/restore.tsv"
  : >"${DOTFILES_BACKUP_DIR}/checksums.sha256"
  dotfiles_log_info "backup session ${DOTFILES_BACKUP_ID}"
}

_dotfiles_backup_require_session() {
  if [[ -z "${DOTFILES_BACKUP_DIR:-}" ]]; then
    dotfiles_log_error "no backup session; call dotfiles_backup_begin first"
    return 1
  fi
}

_dotfiles_tsv_cell() {
  if [[ -n "${1:-}" ]]; then
    printf '%s' "$1"
  else
    printf '-'
  fi
}

# Records one TSV row. Empty fields are stored as '-'.
_dotfiles_backup_record() {
  local orig="$1" stored="$2" type="$3" mode="$4" owner="$5" group="$6" sha="$7" target="$8" op="$9"
  local ts
  ts="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "${orig}" \
    "$(_dotfiles_tsv_cell "${stored}")" \
    "$(_dotfiles_tsv_cell "${type}")" \
    "$(_dotfiles_tsv_cell "${mode}")" \
    "$(_dotfiles_tsv_cell "${owner}")" \
    "$(_dotfiles_tsv_cell "${group}")" \
    "$(_dotfiles_tsv_cell "${sha}")" \
    "$(_dotfiles_tsv_cell "${target}")" \
    "$(_dotfiles_tsv_cell "${op}")" \
    "${ts}" \
    >>"${DOTFILES_BACKUP_DIR}/restore.tsv"
}

dotfiles_backup_file() {
  local src="${1:?path required}"
  local op="${2:-backup}"

  _dotfiles_backup_require_session || return 1

  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    if [[ -e "${src}" || -L "${src}" ]]; then
      dotfiles_log_info "would backup ${src} (${op})"
    else
      dotfiles_log_info "would record missing ${src} (${op})"
    fi
    return 0
  fi

  _DOTFILES_BACKUP_SEQ=$((_DOTFILES_BACKUP_SEQ + 1))
  local seq
  printf -v seq '%04d' "${_DOTFILES_BACKUP_SEQ}"
  local slot="${DOTFILES_BACKUP_DIR}/files/${seq}"
  mkdir -p -- "${slot}"

  local type="missing" mode="" owner="" group="" sha="" target="" stored=""

  if [[ -L "${src}" ]]; then
    type="symlink"
    target="$(readlink -- "${src}" 2>/dev/null || readlink "${src}")"
    mode="$(_dotfiles_stat_mode "${src}")"
    owner="$(_dotfiles_stat_owner "${src}")"
    group="$(_dotfiles_stat_group "${src}")"
    sha="$(_dotfiles_sha256_string "${target}")"
    stored="files/${seq}/link"
    printf '%s' "${target}" >"${slot}/link"
    printf '%s' "${src}" >"${slot}/original-path"
    printf '%s\n' "${sha}  ${stored}" >>"${DOTFILES_BACKUP_DIR}/checksums.sha256"
    dotfiles_log_debug "backed up symlink ${src} -> ${target}"
  elif [[ -f "${src}" ]]; then
    type="file"
    mode="$(_dotfiles_stat_mode "${src}")"
    owner="$(_dotfiles_stat_owner "${src}")"
    group="$(_dotfiles_stat_group "${src}")"
    local base
    base="$(basename -- "${src}")"
    stored="files/${seq}/${base}"
    cp -a -- "${src}" "${slot}/${base}"
    sha="$(_dotfiles_sha256_file "${slot}/${base}")"
    printf '%s' "${src}" >"${slot}/original-path"
    printf '%s\n' "${sha}  ${stored}" >>"${DOTFILES_BACKUP_DIR}/checksums.sha256"
    dotfiles_log_debug "backed up file ${src}"
  elif [[ -d "${src}" ]]; then
    type="directory"
    mode="$(_dotfiles_stat_mode "${src}")"
    owner="$(_dotfiles_stat_owner "${src}")"
    group="$(_dotfiles_stat_group "${src}")"
    stored="files/${seq}/dir"
    cp -a -- "${src}" "${slot}/dir"
    sha="$(_dotfiles_sha256_string "dir:${src}")"
    printf '%s' "${src}" >"${slot}/original-path"
    dotfiles_log_debug "backed up directory ${src}"
  else
    type="missing"
    stored=""
    printf '%s' "${src}" >"${slot}/original-path"
    printf 'missing' >"${slot}/missing"
    dotfiles_log_debug "recorded missing path ${src}"
  fi

  _dotfiles_backup_record "${src}" "${stored}" "${type}" "${mode}" "${owner}" "${group}" "${sha}" "${target}" "${op}"
}

dotfiles_backup_finalize() {
  _dotfiles_backup_require_session || return 1

  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    dotfiles_log_info "would finalize backup ${DOTFILES_BACKUP_ID}"
    return 0
  fi

  local manifest="${DOTFILES_BACKUP_DIR}/manifest.json"
  local host
  host="$(hostname 2>/dev/null || printf unknown)"
  {
    printf '{\n'
    printf '  "id": "%s",\n' "$(_dotfiles_json_escape "${DOTFILES_BACKUP_ID}")"
    printf '  "created_at": "%s",\n' "$(_dotfiles_json_escape "$(date -u +'%Y-%m-%dT%H:%M:%SZ')")"
    printf '  "hostname": "%s",\n' "$(_dotfiles_json_escape "${host}")"
    printf '  "user": "%s",\n' "$(_dotfiles_json_escape "${USER:-unknown}")"
    printf '  "files": [\n'
    local first=1
    if [[ -s "${DOTFILES_BACKUP_DIR}/restore.tsv" ]]; then
      local orig stored type mode owner group sha target op ts
      while IFS=$'\t' read -r orig stored type mode owner group sha target op ts; do
        if [[ "${first}" -eq 0 ]]; then
          printf ',\n'
        fi
        first=0
        printf '    {\n'
        printf '      "original": "%s",\n' "$(_dotfiles_json_escape "${orig}")"
        printf '      "stored_as": "%s",\n' "$(_dotfiles_json_escape "${stored}")"
        printf '      "type": "%s",\n' "$(_dotfiles_json_escape "${type}")"
        printf '      "mode": "%s",\n' "$(_dotfiles_json_escape "${mode}")"
        printf '      "owner": "%s",\n' "$(_dotfiles_json_escape "${owner}")"
        printf '      "group": "%s",\n' "$(_dotfiles_json_escape "${group}")"
        printf '      "sha256": "%s",\n' "$(_dotfiles_json_escape "${sha}")"
        printf '      "symlink_target": "%s",\n' "$(_dotfiles_json_escape "${target}")"
        printf '      "operation": "%s",\n' "$(_dotfiles_json_escape "${op}")"
        printf '      "timestamp": "%s"\n' "$(_dotfiles_json_escape "${ts}")"
        printf '    }'
      done <"${DOTFILES_BACKUP_DIR}/restore.tsv"
      printf '\n'
    fi
    printf '  ]\n'
    printf '}\n'
  } >"${manifest}"

  cat >"${DOTFILES_BACKUP_DIR}/restore.sh" <<'RESTORE'
#!/usr/bin/env bash
set -Eeuo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "${1:-}" == "--dry-run" ]]; then
  printf 'Would restore backup from %s\n' "${HERE}"
  cat "${HERE}/restore.tsv"
  exit 0
fi
while IFS=$'\t' read -r orig stored type mode owner group sha target op ts; do
  [[ -z "${orig:-}" ]] && continue
  [[ "${stored}" == "-" ]] && stored=""
  [[ "${target}" == "-" ]] && target=""
  case "${type}" in
    missing)
      printf 'skip missing %s\n' "${orig}"
      ;;
    file)
      if [[ -e "${orig}" || -L "${orig}" ]]; then
        if [[ -L "${orig}" || -d "${orig}" ]]; then
          printf 'skip %s: destination is not a regular file\n' "${orig}" >&2
          continue
        fi
      else
        mkdir -p -- "$(dirname -- "${orig}")"
      fi
      cp -a -- "${HERE}/${stored}" "${orig}"
      if [[ -n "${mode}" ]]; then
        chmod "${mode}" "${orig}" 2>/dev/null || true
      fi
      printf 'restored file %s\n' "${orig}"
      ;;
    symlink)
      if [[ -e "${orig}" || -L "${orig}" ]]; then
        if [[ ! -L "${orig}" ]]; then
          printf 'skip %s: destination is not a symlink\n' "${orig}" >&2
          continue
        fi
        rm -f -- "${orig}"
      else
        mkdir -p -- "$(dirname -- "${orig}")"
      fi
      ln -s -- "${target}" "${orig}"
      printf 'restored symlink %s -> %s\n' "${orig}" "${target}"
      ;;
    directory)
      printf 'skip directory %s: refusing to merge into an existing tree\n' "${orig}"
      if [[ ! -e "${orig}" ]]; then
        mkdir -p -- "$(dirname -- "${orig}")"
        cp -a -- "${HERE}/${stored}" "${orig}"
        printf 'restored directory %s\n' "${orig}"
      fi
      ;;
  esac
done <"${HERE}/restore.tsv"
RESTORE
  chmod +x -- "${DOTFILES_BACKUP_DIR}/restore.sh"
  dotfiles_log_info "backup finalized ${DOTFILES_BACKUP_ID}"
}

_dotfiles_same_kind() {
  local dest="$1" type="$2"
  case "${type}" in
    file)
      [[ -f "${dest}" && ! -L "${dest}" ]]
      ;;
    symlink)
      [[ -L "${dest}" ]]
      ;;
    directory)
      [[ -d "${dest}" && ! -L "${dest}" ]]
      ;;
    *)
      return 1
      ;;
  esac
}

_dotfiles_restore_one() {
  local orig="$1" stored="$2" type="$3" mode="$4" target="$5"
  local dir="${6:?backup dir}"

  case "${type}" in
    missing)
      dotfiles_log_info "skip restore of missing path ${orig}"
      return 0
      ;;
    file)
      if [[ -e "${orig}" || -L "${orig}" ]]; then
        if ! _dotfiles_same_kind "${orig}" file; then
          dotfiles_log_warn "skip restore ${orig}: destination exists as a different type"
          return 0
        fi
      else
        mkdir -p -- "$(dirname -- "${orig}")"
      fi
      cp -a -- "${dir}/${stored}" "${orig}"
      if [[ -n "${mode}" ]]; then
        chmod -- "${mode}" "${orig}" 2>/dev/null || chmod "${mode}" "${orig}" 2>/dev/null || true
      fi
      dotfiles_log_info "restored file ${orig}"
      ;;
    symlink)
      if [[ -e "${orig}" || -L "${orig}" ]]; then
        if ! _dotfiles_same_kind "${orig}" symlink; then
          dotfiles_log_warn "skip restore ${orig}: destination exists as a different type (not replacing with symlink)"
          return 0
        fi
        rm -f -- "${orig}"
      else
        mkdir -p -- "$(dirname -- "${orig}")"
      fi
      ln -s -- "${target}" "${orig}"
      dotfiles_log_info "restored symlink ${orig} -> ${target}"
      ;;
    directory)
      if [[ -e "${orig}" || -L "${orig}" ]]; then
        if ! _dotfiles_same_kind "${orig}" directory; then
          dotfiles_log_warn "skip restore ${orig}: destination exists as a different type"
          return 0
        fi
        dotfiles_log_warn "skip restore ${orig}: directory already exists (refusing to merge/delete)"
        return 0
      fi
      mkdir -p -- "$(dirname -- "${orig}")"
      cp -a -- "${dir}/${stored}" "${orig}"
      dotfiles_log_info "restored directory ${orig}"
      ;;
    *)
      dotfiles_log_error "unknown backup type ${type} for ${orig}"
      return 1
      ;;
  esac
}

dotfiles_backup_restore() {
  local id="${1:?backup id required}"
  local dir="${2:-$(dotfiles_backup_root)/${id}}"

  if dotfiles_is_truthy "${DOTFILES_DRY_RUN:-0}"; then
    dotfiles_log_info "would restore backup ${id} from ${dir}"
    return 0
  fi

  if [[ ! -d "${dir}" ]]; then
    dotfiles_log_error "backup not found: ${id}"
    return 1
  fi
  if [[ ! -f "${dir}/restore.tsv" ]]; then
    dotfiles_log_error "backup ${id} has no restore.tsv"
    return 1
  fi

  local orig stored type mode owner group sha target op ts
  while IFS=$'\t' read -r orig stored type mode owner group sha target op ts; do
    [[ -z "${orig}" ]] && continue
    [[ "${stored}" == "-" ]] && stored=""
    [[ "${type}" == "-" ]] && type=""
    [[ "${mode}" == "-" ]] && mode=""
    [[ "${target}" == "-" ]] && target=""
    _dotfiles_restore_one "${orig}" "${stored}" "${type}" "${mode}" "${target}" "${dir}"
  done <"${dir}/restore.tsv"
}

dotfiles_backup_rollback() {
  if [[ -z "${DOTFILES_BACKUP_ID:-}" ]]; then
    dotfiles_log_error "no active backup session to roll back"
    return 1
  fi
  dotfiles_log_warn "rollback to backup ${DOTFILES_BACKUP_ID}"
  dotfiles_backup_restore "${DOTFILES_BACKUP_ID}" "${DOTFILES_BACKUP_DIR}"
}
