# Source CachyOS Fish configuration
source /usr/share/cachyos-fish-config/cachyos-config.fish

# Set paths
set -Ux PATH $HOME/.cargo/bin $PATH
set -x PATH $PATH ~/.emacs.d/bin
set -gx PATH $HOME/depot_tools $PATH

# Initialize Starship prompt
starship init fish | source


alias ls 'lsd'
alias cat 'bat'
alias vim 'nvim'

# Emacs aliases
alias ec 'emacsclient -c -a "" &; disown'
alias et 'emacsclient -t -a ""'

set -Ux LS_COLORS "di=01;34:ln=01;36:ex=01;32:ow=01;36:st=01;35:tw=01;36"

# Ollama model storage location
set -gx OLLAMA_MODELS "/home/il1v3y/Ollama"

# ============================================
# Podman Configuration for Security Research
# ============================================

# Docker compatibility aliases
alias docker '/usr/bin/docker'
alias docker-compose '/usr/bin/docker compose'

# Podman shortcuts
alias pod 'podman'
alias podi 'podman images'
alias podps 'podman ps -a'
alias podrm 'podman rm'
alias podrmi 'podman rmi'
alias podclean 'podman system prune -af --volumes'
alias podstats 'podman stats --no-stream'

# Security-focused container aliases
alias malware-box 'podman run -it --rm --security-opt seccomp=unconfined --cap-add=SYS_PTRACE --network malware-isolated --name malware-analysis'
alias kali 'podman run -it --rm --network host --privileged kalilinux/kali-rolling /bin/bash'
alias metasploit 'podman run -it --rm --network host -v ~/security/msf-data:/root/.msf4 metasploitframework/metasploit-framework'

# Podman socket for Docker API compatibility (Fish syntax)
# Force docker CLI to use Docker daemon
set -gx DOCKER_HOST "unix:///var/run/docker.sock"

# Codex Container Aliases
alias codex-run 'codex-container run'
alias codex-shell 'codex-container shell'
alias codex-clean 'codex-container clean'

# Livey Codex Toolkit path
if test -d "$HOME/livey-codex-toolkit/bin"
  set -gx PATH "$HOME/livey-codex-toolkit/bin" $PATH
end

# PYENV CONFIG FOR FISH
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

status is-interactive; and source (pyenv init -| psub)
status is-interactive; and source (pyenv virtualenv-init -| psub)

# MatteriaTrack
alias mtrack 'materiatrack'

# Prism Terminal
if test -f "$HOME/.config/prism/prism.fish"
    source "$HOME/.config/prism/prism.fish"
end

# Open Notebook Docker helper
function open-notebook
  /media/il1v3y/HD2/open-notebook/scripts/open_notebook_docker.sh $argv
end
set -gx PATH $HOME/.opencode/bin $PATH

# Livey Sib Gr0up Eco-Workflow entrypoints
set -gx PATH $PATH ~/dotfiles/bin

# Added by LM Studio CLI tool (lms)
set -gx PATH $PATH /home/il1v3y/.lmstudio/bin

# SSH Agent Auto-Start for Git Operations (Obsidian Git)
# ═══════════════════════════════════════════════════════════════

if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
end
