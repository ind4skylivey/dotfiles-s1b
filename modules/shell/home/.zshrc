# Portable zshrc (shell module).
# Not the repo-root dump (.zshrc at the clone root).
# No host paths, no offensive aliases, no /tmp overlays.

# History (XDG if possible; fall back to ~/.zsh_history)
if [[ -n "${XDG_STATE_HOME:-}" ]]; then
  HISTFILE="${XDG_STATE_HOME}/zsh/history"
else
  HISTFILE="${HOME}/.zsh_history"
fi
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

bindkey -e

typeset -U path PATH
path=("${HOME}/.local/bin" "${HOME}/bin" ${path})

alias reload-zsh='source ${ZDOTDIR:-$HOME}/.zshrc'

if command -v ls >/dev/null 2>&1; then
  alias ls='ls --color=auto'
fi

# Optional prompt: Powerlevel10k if both theme and config exist, else Starship.
if [[ -f "${HOME}/.p10k.zsh" && -r /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
  source "${HOME}/.p10k.zsh"
elif command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  _fzf_zsh="$(fzf --zsh 2>/dev/null)" || _fzf_zsh=""
  if [[ -n "${_fzf_zsh}" ]]; then
    eval "${_fzf_zsh}"
  fi
  unset _fzf_zsh
fi

# Host overlay (not versioned). Copy from config/local.example.toml notes.
_zsh_local="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/local.zsh"
if [[ -f "${_zsh_local}" ]]; then
  source "${_zsh_local}"
fi
unset _zsh_local

# Opt-in security overlay (linked only with --profile security).
_zsh_sec="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/security.zsh"
if [[ -f "${_zsh_sec}" ]]; then
  source "${_zsh_sec}"
fi
unset _zsh_sec
