# ============================================
# Powerlevel10k Instant Prompt - DISABLED
# ============================================
# Disabled to allow custom config to load properly
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Load Powerlevel10k theme (from system - CachyOS)
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Load custom p10k config AFTER theme (CRITICAL!)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

eval "(zoxide init zsh)"

 
export PATH=$HOME/.local/bin:$PATH

# Emacs aliases
alias ec="emacsclient -c -a \"\" &"
alias et="emacsclient -t -a \"\""

# opencode
export PATH=/home/il1v3y/.opencode/bin:$PATH

# Ollama model storage location
export OLLAMA_MODELS="/media/il1v3y/HD2/HDfiles/AI/Ollama"

# ============================================
# Podman Configuration for Security Research
# ============================================

# Docker compatibility aliases
alias docker='podman'
alias docker-compose='podman-compose'

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
alias metasploit='podman run -it --rm --network host -v ~/security/msf-data:/root/.msf4 metasploitframework/metasploit-framework'

# Podman socket for Docker API compatibility
export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"

# ============================================
# Security Research Workflow Aliases
# ============================================

# Droid security workflow shortcuts
alias droid-exploit='cd ~/security/research && droid'
alias droid-malware='malware-box archlinux && droid'
alias droid-web='cd ~/security/web && burpsuite > /dev/null 2>&1 & disown && droid'
alias droid-ctf='cd ~/security/ctf && droid'

# Pre-commit secret scanning
alias scan-commit='git diff --cached | rg -i "password|api_key|secret|token|private_key|aws_|bearer"'
alias safe-commit='scan-commit && git commit'

# Quick container environments
alias sec-lab='podman run -it --rm --network sec-tools kalilinux/kali-rolling'
alias isolated='podman run -it --rm --network malware-isolated archlinux'

# Exploit development helpers
alias rop-search='ropper -f'
alias shellcode-gen='msfvenom -p linux/x64/shell_reverse_tcp'
alias pattern-create='python3 -c "from pwn import *; print(cyclic(256))"'

# Quick scans
alias quick-scan='nmap -T4 -F'
alias full-scan='nmap -p- -sV -sC -O'

# Project templates
alias new-exploit='cp ~/.factory/templates/exploit-template.py'
alias new-research='mkdir -p {analysis,exploits,notes,reports,loot}'

# ============================================
# Factory Droid CLI Configuration
# ============================================
export FACTORY_API_KEY="fk-zKkiNn5MyuUjGaq71vh3-WjVwWSoTTeMzKufqrG8WvRlJNA72MdcuBqzAKtR1D48"

# Starship Prompt - DISABLED (using Powerlevel10k)
# ============================================
# eval "$(starship init zsh)"

# ============================================
# Powerlevel10k Configuration (redundant load at end)
# ============================================
# Already loaded above, this is just for safety
