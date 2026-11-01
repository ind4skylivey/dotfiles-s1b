# Aliases compartidos (zsh). Docker real = lab SEC; Podman = alias pod*.

# Audio (Razer Hammerhead BT)
alias fixmic='$HOME/.local/bin/fix-hammerhead-mic'

# Docker real (daemon del sistema: traefik, wazuh, crowdsec…)
export DOCKER_HOST="unix:///var/run/docker.sock"
# sin alias docker=podman — usa /usr/bin/docker

# Podman
alias pod='podman'
alias pods='podman ps -a'
alias podi='podman images'
alias podps='podman ps -a'
alias podrm='podman rm'
alias podrmi='podman rmi'
alias podclean='podman system prune -af --volumes'
alias podstats='podman stats --no-stream'

# Contenedores de seguridad (alineados con bash/fish)
alias malware-box='podman run -it --rm --security-opt seccomp=unconfined --cap-add=SYS_PTRACE --network malware-isolated --name malware-analysis'
alias kali='podman run -it --rm --network host --privileged kalilinux/kali-rolling /bin/bash'

# Pre-commit secret scanning
alias scan-commit='git diff --cached | rg -i "password|api_key|secret|token|private_key|aws_|bearer"'
alias safe-commit='scan-commit && git commit'

# Escaneos rápidos (nmap)
alias quick-scan='nmap -T4 -F'
alias full-scan='nmap -p- -sV -sC -O'

# Engram
alias engram-backup='cd ~/.engram && engram export && git add . && git commit -m "sync $(date +%Y-%m-%d)" && git push'
