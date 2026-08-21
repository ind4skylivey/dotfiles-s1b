# shellcheck shell=bash
# scripts/lib/load.sh — source the core library in order.
_dotfiles_this="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "${_dotfiles_this}/common.sh"
# shellcheck source=log.sh
source "${_dotfiles_this}/log.sh"
# shellcheck source=detect.sh
source "${_dotfiles_this}/detect.sh"
# shellcheck source=plan.sh
source "${_dotfiles_this}/plan.sh"
unset _dotfiles_this
