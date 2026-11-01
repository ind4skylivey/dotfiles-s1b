# ============================================
# zsh (ZDOTDIR) — alineado con fish/bash (2026-10-06)
# ============================================

# TERM=dumb: desactiva p10k (Factory/Droid / script sin TTY)
if [[ $TERM == "dumb" ]]; then
  POWERLEVEL9K_INSTANT_PROMPT=off
  POWERLEVEL9K_TRANSIENT_PROMPT=off
  POWERLEVEL9K_MODE='none'
  DISABLE_P10K_INSTANT_PROMPT=1
fi

# Powerlevel10k instant prompt (debe ir arriba)
if [[ -z "$DISABLE_P10K_INSTANT_PROMPT" ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" 2>/dev/null
fi

# --- SSH agent (systemd --user); environment.d lo fija tras re-login ---
if [[ -n ${XDG_RUNTIME_DIR:-} && -S $XDG_RUNTIME_DIR/ssh-agent.socket && -z ${SSH_CONNECTION:-} ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
if [[ -o interactive && -n ${SSH_AUTH_SOCK:-} ]]; then
  ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_bitflow 2>/dev/null
fi

# --- PATH interactivo (idempotente; .zshenv ya puso .local/bin y .cargo/bin) ---
typeset -U path PATH
for _d in \
  "$HOME/.pi/bin" \
  "$HOME/.local/share/fnm/node-versions/v22.23.2/installation/bin" \
  "$HOME/.config/composer/vendor/bin" \
  "$HOME/bin" \
  "$HOME/.spicetify" \
  /home/linuxbrew/.linuxbrew/bin \
  /home/linuxbrew/.linuxbrew/sbin
do
  [[ -d $_d ]] && path=("$_d" $path)
done
unset _d
export PATH

# Docker real (también en aliases.zsh; aquí para shells sin aliases)
export DOCKER_HOST="unix:///var/run/docker.sock"

# --- Zinit ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" 2>/dev/null
fi
[[ -f ${ZINIT_HOME}/zinit.zsh ]] && source "${ZINIT_HOME}/zinit.zsh" 2>/dev/null

if [[ $TERM != "dumb" ]]; then
  [[ -n $ZINIT_HOME ]] && { zinit ice depth=1; zinit light romkatv/powerlevel10k 2>/dev/null; }
  zinit light zsh-users/zsh-syntax-highlighting 2>/dev/null
  zinit light Aloxaf/fzf-tab 2>/dev/null
else
  PS1='%F{red}💀%f %F{cyan}%~%f %F{yellow}$%f '
fi
zinit light zsh-users/zsh-completions 2>/dev/null
zinit light zsh-users/zsh-autosuggestions 2>/dev/null

zinit snippet OMZL::git.zsh 2>/dev/null
zinit snippet OMZP::git 2>/dev/null
zinit snippet OMZP::sudo 2>/dev/null
zinit snippet OMZP::archlinux 2>/dev/null
zinit snippet OMZP::command-not-found 2>/dev/null

autoload -Uz compinit && compinit 2>/dev/null
zinit cdreplay -q 2>/dev/null

# p10k: el que carga .zshrc es ~/.p10k.zsh (home), no $ZDOTDIR/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 2>/dev/null

# Keybindings
bindkey -e 2>/dev/null
bindkey '^p' history-search-backward 2>/dev/null
bindkey '^n' history-search-forward 2>/dev/null
bindkey '^[w' kill-region 2>/dev/null

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups 2>/dev/null

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 2>/dev/null
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 2>/dev/null
zstyle ':completion:*' menu no 2>/dev/null
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath' 2>/dev/null
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color=always $realpath' 2>/dev/null

# Aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
alias ls='lsd'
alias vim='nvim'
alias c='clear'
alias cat='bat'

# Codex
alias codex-run='codex-container run'
alias codex-shell='codex-container shell'
alias codex-clean='codex-container clean'

# Pi
if [[ -x $HOME/.local/bin/pi-mcp-env ]]; then
  eval "$("$HOME/.local/bin/pi-mcp-env" shell 2>/dev/null || true)"
fi
[[ -x $HOME/.pi/bin/switch_model ]] && alias switch_model='$HOME/.pi/bin/switch_model'
alias godlike-init='source ~/.pi/agent/init-godlike.sh'
alias godlike-status='source ~/.pi/agent/init-godlike.sh'

# Shell integrations
command -v fzf >/dev/null && eval "$(fzf --zsh)" 2>/dev/null
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)" 2>/dev/null
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)" 2>/dev/null

zoxide-boost() {
  "/media/$USER/HD2/Scripts & Tools/zoxide-boost.sh" "$@"
}

# Limpieza final de PATH (por si brew shellenv duplicó)
typeset -U path PATH
path=($^path(N-/))
export PATH

# >>> s1b cargo-safe (2026-10-16) >>>
alias cargo="$HOME/.local/bin/cargo-safe"
# <<< s1b cargo-safe <<<

# Lerd
export PATH="$HOME/.local/share/lerd/bin:$PATH"

# Lerd completions
fpath=($HOME/.local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
