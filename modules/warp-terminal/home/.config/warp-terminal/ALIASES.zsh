# ============================================
# Warp Terminal: Red Team & Full Stack Aliases
# ============================================
# Add these to ~/.zshrc or source this file:
# source ~/.config/warp-terminal/ALIASES.zsh

# Networking & Reconnaissance
alias recon='nmap -sV -sC -T4'
alias stealth-scan='nmap -sS -T2 -f'
alias full-enum='nmap -p- -sV -sC -O'
alias net-listen='ss -tulpn | grep LISTEN'
alias ps-watch='watch -n 1 ps aux'
alias whoami-info='whoami && hostname && pwd && id'

# Web Security & Scanning
alias web-scan='gobuster dir -u'
alias check-vulns='searchsploit'
alias sqlmap-quick='sqlmap -u'
alias xss-check='grep -ri "innerHTML\|eval\|document.write"'
alias burp='burpsuite > /dev/null 2>&1 & disown'

# Malware Analysis & Reverse Engineering
alias strings-hunt='strings'
alias bin-analyze='file && objdump -d'
alias strace-monitor='strace -f -e trace=network,file'
alias ltrace-monitor='ltrace -C'
alias ghidra='ghidra > /dev/null 2>&1 & disown'

# Exploit Development (Rapid)
alias pattern-gen='python3 -c "from pwn import *; print(cyclic(256))"'
alias shellcode-gen='msfvenom -p linux/x64/shell_reverse_tcp'
alias gdb-debug='gdb-peda'

# Full Stack Development
alias php-server='php -S localhost:8000'
alias rust-check='cargo clippy'
alias rust-build='cargo build --release'
alias py-serve='python3 -m http.server 8000'
alias npm-dev='npm run dev'

# Docker/Podman Security Lab
alias sec-tools='podman run -it --rm --network sec-tools kalilinux/kali-rolling'

# Git Workflow & Security
alias gstash='git stash'
alias gpush-force='git push --force-with-lease'
alias gcommit-amend='git commit --amend --no-edit'
alias check-diffs='git diff && git diff --cached'
alias scan-leaks='trufflehog git file:///'

# Penetration Testing Context (Rapid Response)
alias burp-headless='burpsuite --headless'
alias msfdb-init='msfdb init'
alias msfconsole-q='msfconsole -q -x'
