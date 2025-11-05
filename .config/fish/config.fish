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
set -gx OLLAMA_MODELS "/media/il1v3y/HD2/HDfiles/AI/Ollama"

# ============================================
# Podman Configuration for Security Research
# ============================================

# Docker compatibility aliases
alias docker 'podman'
alias docker-compose 'podman-compose'

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
set -gx DOCKER_HOST "unix:///run/user/1000/podman/podman.sock"

