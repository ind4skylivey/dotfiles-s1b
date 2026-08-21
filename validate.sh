#!/usr/bin/env bash
# validate.sh — validate the repository. Does not modify the host system.

set -Eeuo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_ROOT
# shellcheck source=scripts/lib/load.sh
source "${DOTFILES_ROOT}/scripts/lib/load.sh"

dotfiles_require_bash4
dotfiles_log_init

FAILED=0

check_syntax() {
  local file="$1"
  if bash -n "${file}"; then
    dotfiles_log_info "syntax ok: ${file#"${DOTFILES_ROOT}/"}"
  else
    dotfiles_log_error "syntax fail: ${file}"
    FAILED=1
  fi
}

SCRIPTS=(
  "${DOTFILES_ROOT}/install.sh"
  "${DOTFILES_ROOT}/doctor.sh"
  "${DOTFILES_ROOT}/validate.sh"
  "${DOTFILES_ROOT}/scripts/detect-platform.sh"
  "${DOTFILES_ROOT}/scripts/lib/common.sh"
  "${DOTFILES_ROOT}/scripts/lib/log.sh"
  "${DOTFILES_ROOT}/scripts/lib/detect.sh"
  "${DOTFILES_ROOT}/scripts/lib/plan.sh"
  "${DOTFILES_ROOT}/scripts/lib/backup.sh"
  "${DOTFILES_ROOT}/scripts/lib/link.sh"
  "${DOTFILES_ROOT}/scripts/lib/load.sh"
  "${DOTFILES_ROOT}/scripts/backup.sh"
  "${DOTFILES_ROOT}/scripts/link.sh"
  "${DOTFILES_ROOT}/restore.sh"
)

for f in "${SCRIPTS[@]}"; do
  check_syntax "${f}"
done

if dotfiles_have_cmd shellcheck; then
  if shellcheck --shell=bash --external-sources -e SC1091 \
    "${DOTFILES_ROOT}/install.sh" \
    "${DOTFILES_ROOT}/doctor.sh" \
    "${DOTFILES_ROOT}/validate.sh" \
    "${DOTFILES_ROOT}/scripts/detect-platform.sh" \
    "${DOTFILES_ROOT}/scripts/backup.sh" \
    "${DOTFILES_ROOT}/scripts/link.sh" \
    "${DOTFILES_ROOT}/restore.sh" \
    "${DOTFILES_ROOT}/scripts/lib/"*.sh; then
    dotfiles_log_info "shellcheck ok"
  else
    dotfiles_log_error "shellcheck reported issues"
    FAILED=1
  fi
else
  dotfiles_log_warn "shellcheck not installed — skipped"
fi

if [[ ! -f "${DOTFILES_ROOT}/docs/linker.md" ]]; then
  dotfiles_log_error "missing docs/linker.md"
  FAILED=1
fi

if ((FAILED > 0)); then
  exit "${DOTFILES_E_ERR}"
fi
dotfiles_log_info "repository validation passed"
exit "${DOTFILES_E_OK}"
