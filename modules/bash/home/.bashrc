#!/usr/bin/env bash
iatest=$(expr index "$-" i)

# ═══════════════════════════════════════════════════════════════
# PATH (bloque único e idempotente; la limpieza final está al final del archivo)
# ═══════════════════════════════════════════════════════════════
path_prepend() { [[ -d $1 && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"; return 0; }
path_append()  { [[ -d $1 && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"; return 0; }

for _d in \
    "$HOME/.cargo/bin" \
    "$HOME/.config/composer/vendor/bin" \
    "$HOME/.local/bin" \
    "$HOME/.local/share/fnm/node-versions/v22.23.2/installation/bin" \
    "$HOME/.pi/bin" \
    "$HOME/bin"; do
    path_prepend "$_d"
done
# Homebrew (engram, etc.) al final para no tapar las herramientas del sistema
path_append /home/linuxbrew/.linuxbrew/bin
path_append /home/linuxbrew/.linuxbrew/sbin

# Fastfetch al abrir un shell interactivo
if command -v ff &> /dev/null; then
    if [[ $- == *i* ]]; then
        ff
    fi
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

#######################################################
# EXPORTS
#######################################################

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTTIMEFORMAT="%F %T" # add timestamp to history

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
    export SUDO_EDITOR=nvim  # para sudoedit / svi
else
    export EDITOR=vim
    export VISUAL=vim
fi
alias snano='sudo nano'

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated

# Check if ripgrep is installed
if command -v rg &> /dev/null; then
    # Alias grep to rg if ripgrep is installed
    alias grep='rg'
else
    # Alias grep to /usr/bin/grep with GREP_OPTIONS if ripgrep is not installed
    alias grep="/usr/bin/grep $GREP_OPTIONS"
fi
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################

#######################################################
# Seguridad (conservado de la sección de aliases)
#######################################################
# rm va a la papelera si existe trash-cli (reversible)
if command -v trash &> /dev/null; then
    alias rm="trash -v"
else
    alias rm="rm -i"
fi

[[ $- == *i* ]] && echo "(bash de respaldo — tu shell principal es fish: escribí [36mfish[0m para volver)"

#######################################################
# Prompt / navegación
#######################################################

# Check if the shell is interactive
if [[ $- == *i* ]]; then
    # Bind Ctrl+f to insert 'cdi' (zoxide interactivo) followed by a newline
    bind '"\C-f":"cdi\n"'
fi

eval "$(starship init bash)"

alias ls='lsd'
alias cat='bat'
alias vim='nvim'

# Initialize zoxide and bind 'cd' to zoxide
eval "$(zoxide init --cmd cd bash)"

# Doom Emacs (zsh + bash)
[[ -f ~/.config/emacs/doom-shell.sh ]] && source ~/.config/emacs/doom-shell.sh

# ============================================
# Podman Configuration for Security Research
# ============================================

# Docker y Podman separados
# docker = Docker real (lab SEC); podman queda con los alias pod*

# Podman shortcuts
alias pod='podman'
alias podi='podman images'
alias podps='podman ps -a'
alias podrm='podman rm'
alias podrmi='podman rmi'
alias podclean='podman system prune -af --volumes'
alias podstats='podman stats --no-stream'

# Security-focused container aliases
alias malware-box='podman run -it --rm --security-opt seccomp=unconfined --cap-add=SYS_PTRACE --network malware-isolated --name malware-analysis'
alias kali='podman run -it --rm --network host --privileged kalilinux/kali-rolling /bin/bash'

# Docker API: socket del Docker real
export DOCKER_HOST="unix:///var/run/docker.sock"

# Codex Container Aliases
alias codex-run='codex-container run'
alias codex-shell='codex-container shell'
alias codex-clean='codex-container clean'

# ═══════════════════════════════════════════════════════════════
# QWEN MODE SWITCHER (Ollama Local → OpenAI API Compatibility)
# ═══════════════════════════════════════════════════════════════
# This function makes Ollama compatible with tools expecting OpenAI API
# Sets OPENAI_* variables to point to local Ollama server
# ═══════════════════════════════════════════════════════════════

function qwen-mode() {
  case $1 in
    local-coder)
      echo "🏠 Using LOCAL: qwen2.5-coder:14b (coding-specialized)"
      export OPENAI_API_KEY="sk-xxxx-xxxx-xxxx-xxxx"  # Placeholder for Ollama compatibility
      export OPENAI_BASE_URL="http://localhost:11434/v1"
      export OPENAI_MODEL="qwen2.5-coder:14b"
      ;;
    off)
      echo "🔴 Qwen mode disabled (using default OpenAI settings)"
      unset OPENAI_API_KEY
      unset OPENAI_BASE_URL
      unset OPENAI_MODEL
      ;;
    status)
      echo "📊 Current Qwen/Ollama configuration:"
      echo "  API Key: ${OPENAI_API_KEY:-[default/cloud]}"
      echo "  Base URL: ${OPENAI_BASE_URL:-[default/cloud]}"
      echo "  Model: ${OPENAI_MODEL:-[default/cloud]}"
      echo ""
      echo "💡 Ollama server status:"
      if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        echo "  ✅ Ollama is running"
        ollama list 2>/dev/null | grep -E "NAME|qwen" | sed 's/^/    /'
      else
        echo "  ❌ Ollama is not running (start with: ollama serve)"
      fi
      ;;
    *)
      echo "Usage: qwen-mode [local-coder|off|status]"
      echo ""
      echo "Available modes:"
      echo "  local-coder  - Use qwen2.5-coder:14b via Ollama (OpenAI compatible)"
      echo "  off          - Disable Qwen mode (use default OpenAI settings)"
      echo "  status       - Show current configuration and Ollama status"
      echo ""
      echo "Example:"
      echo "  qwen-mode local-coder   # Enable Ollama for OpenAI-compatible tools"
      echo "  qwen-mode status         # Check configuration"
      ;;
  esac
}

# Dynamic terminal title (shows git branch and path)
if [ -f "$HOME/.config/alacritty/dynamic_title.sh" ]; then
  source "$HOME/.config/alacritty/dynamic_title.sh"
fi

export MAKEFLAGS="-j8"
export CMAKE_BUILD_PARALLEL_LEVEL=8

# TidaLuna update alias
alias tu='"/media/$USER/HD2/Scripts & Tools/tidaluna-update"'
alias tu-force='"/media/$USER/HD2/Scripts & Tools/tidaluna-update" --force'

# Ollama with Vulkan GPU support
alias ollama-start='"/media/$USER/HD2/Scripts & Tools/vulkna Ollama/ollama-start.sh"'
alias ollama-chat='python3 "/media/$USER/HD2/Scripts & Tools/vulkna Ollama/ollama-chat-interactive.py"'

# GPG TTY for commit signing
export GPG_TTY=$(tty)

# Zoxide boost - score management
zoxide-boost() {
    "/media/$USER/HD2/Scripts & Tools/zoxide-boost.sh" "$@"
}
alias engram-backup='cd ~/.engram && engram export && git add . && git commit -m "sync $(date +%Y-%m-%d)" && git push'

# SSH agent: el de systemd --user (ssh-agent.service / ssh-agent.socket), uno solo para toda la sesión
if [[ -n ${XDG_RUNTIME_DIR:-} && -S $XDG_RUNTIME_DIR/ssh-agent.socket && -z ${SSH_CONNECTION:-} ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
if [[ $- == *i* && -n ${SSH_AUTH_SOCK:-} ]]; then
    ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_bitflow 2>/dev/null
fi

# GitHub profile auto-switch
[[ -f ~/.bash/gh-profile.bash ]] && source ~/.bash/gh-profile.bash

# =============================================================================
# MCP Servers - API Tokens (Security Architecture)
# =============================================================================
# Solo se carga si es tuyo y tiene modo 600 (HD2 es un disco compartido)
_mcp_secrets=/media/$USER/HD2/tokens/mcp_secrets.sh
if [[ -f $_mcp_secrets && -O $_mcp_secrets && $(stat -c %a "$_mcp_secrets") == 600 ]]; then
    source "$_mcp_secrets"
fi
unset _mcp_secrets

alias vibe='$HOME/.vibe/launch_vibe.sh'

# GOD-LIKE / Pi workflow
alias godlike-init='source ~/.pi/agent/init-godlike.sh'
alias godlike-status='source ~/.pi/agent/init-godlike.sh'
alias zaap='G_TLS_GNUTLS_PRIORITY="NORMAL:%COMPAT" /media/$USER/HD2/App/zaap-launcher_0.2.0_amd64.AppImage'
# Pi MCP (Linear/Sentry + gh de la cuenta activa via gh-use)
if [[ $- == *i* && -x $HOME/.local/bin/pi-mcp-env ]]; then
    eval "$("$HOME/.local/bin/pi-mcp-env" shell 2>/dev/null || true)"
fi
[[ -x $HOME/.pi/bin/switch_model ]] && alias switch_model='$HOME/.pi/bin/switch_model'

# ═══════════════════════════════════════════════════════════════
# pyenv (después de PROMPT_COMMAND para que su hook no se pierda)
# ═══════════════════════════════════════════════════════════════
export PYENV_ROOT="$HOME/.pyenv"
path_prepend "$PYENV_ROOT/bin"
if command -v pyenv >/dev/null; then
    eval "$(pyenv init - --no-rehash bash)"   # sin rehash en cada shell (~45 ms)
    eval "$(pyenv virtualenv-init -)"
fi

# Quita duplicados y carpetas que no existen (sesión, pyenv, doom, shells anidados)
_newpath=
IFS=: read -ra _parts <<< "$PATH"
for _d in "${_parts[@]}"; do
    [[ -n $_d && -d $_d && ":$_newpath:" != *":$_d:"* ]] && _newpath="${_newpath:+$_newpath:}$_d"
done
export PATH="$_newpath"
unset _d _parts _newpath

# El título de /etc/bash.bashrc pisaría el de dynamic_title.sh (update_title): se filtra
if [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
    _pc=()
    for _c in "${PROMPT_COMMAND[@]}"; do
        [[ -z $_c || $_c == 'printf "\033]0;'* ]] || _pc+=("$_c")
    done
    PROMPT_COMMAND=("${_pc[@]}")
    unset _pc _c
fi

# >>> s1b cargo-safe (2026-10-16) >>>
alias cargo="$HOME/.local/bin/cargo-safe"
# <<< s1b cargo-safe <<<
