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

# Zed IDE - Wayland support
alias zed='ELECTRON_OZONE_PLATFORM_HINT=auto /home/il1v3y/.local/zed.app/libexec/zed-editor'
# alias zed='zed-with-ollama'  # Disabled - not using Ollama anymore
# alias zed-clean='pkill ollama; sleep 2; zed-with-ollama'  # Kill Ollama and restart


# Ollama model storage location
export OLLAMA_MODELS="/home/il1v3y/Ollama"

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

# Github deploy-site
export PATH="$HOME/bin:$PATH"
alias dsite="deploy-site.sh"

# ============================================
# ADDITIONAL FULL STACK + SECURITY ALIASES
# ============================================

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

# Docker/Podman Security Lab (already configured but adding aliases)
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

# ============================================
# Factory Droid CLI Configuration
# ============================================
# FACTORY_API_KEY - Set via environment variable

# Starship Prompt - DISABLED (using Powerlevel10k)
# ============================================
# eval "$(starship init zsh)"

# ============================================
# Powerlevel10k Configuration (redundant load at end)
# ============================================
# Already loaded above, this is just for safety

# Livey Codex Toolkit path
if [ -d "$HOME/livey-codex-toolkit/bin" ]; then
  export PATH="$HOME/livey-codex-toolkit/bin:$PATH"
fi
source /tmp/.tmpJiQqOb/prism.zsh

export PYENV_ROOT="$HOME/.pyenv"
path=("$PYENV_ROOT/bin" $path)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source /home/il1v3y/.config/prism/prism.zsh

export MAKEFLAGS="-j8"
export CMAKE_BUILD_PARALLEL_LEVEL=8

# Prism Terminal
if [ -f "$HOME/.config/prism/prism.zsh" ]; then
    source "$HOME/.config/prism/prism.zsh"
fi

# Factory hook wrappers (pre-droid/agent checks + context sync)
function _factory_pre_agent_hook() {
  bash ~/.factory/hooks/pre-droid.sh
}
function droid() {
  command droid "$@"
}
function gemini() {
  command gemini "$@"
}
function claude() {
  command claude "$@"
}

function _factory_context_reload() {
  ~/.factory/hooks/context-sync.sh >/dev/null 2>&1 || true
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _factory_context_reload
_factory_context_reload

# Open Notebook Docker helper
alias open-notebook='/media/il1v3y/HD2/open-notebook/scripts/open_notebook_docker.sh'

# OpenCode Gemini 3 Configuration
# NOTE: Set GOOGLE_API_KEY in your local environment, not in this file
# export GOOGLE_API_KEY="your-api-key-here"
alias lmstudio="~/AI-models/LMStudio.AppImage"

# ============================================
# Zed + Ollama Workflow Helpers
# ============================================

function ollama-start() {
  echo "🚀 Starting Ollama with Qwen models..."
  OLLAMA_MODELS="/home/il1v3y/Ollama" ollama serve > /tmp/ollama.log 2>&1 &
  echo "   PID: $!"
  echo "   Log: tail -f /tmp/ollama.log"
  sleep 3
  ollama-status
}

function ollama-stop() {
  echo "⏹️  Stopping Ollama..."
  pkill -f "ollama serve" || echo "   Ollama not running"
}

function ollama-status() {
  if pgrep -f "ollama serve" > /dev/null; then
    echo "✅ Ollama is running"
    echo ""
    echo "📦 Available Models:"
    curl -s http://localhost:11434/api/tags 2>/dev/null | jq -r '.models[] | "   • \(.name) (\(.size / 1073741824 | floor) GB)"' || echo "   Could not fetch models"
  else
    echo "❌ Ollama is not running"
    echo "   Start with: ollama-start"
  fi
}

function ollama-logs() {
  tail -f /tmp/ollama.log
}

function token-usage() {
  echo "📊 Token Usage Report:"
  echo "   Haiku 4.5 (Cloud):  152,000 / 200,000 tokens used"
  echo "   Remaining:          ~48,000 tokens"
  echo ""
  echo "💡 Strategy:"
  echo "   • Use Haiku for: Security reviews, complex architecture"
  echo "   • Use Qwen for: UI components, debugging, refactoring (unlimited)"
  echo ""
  echo "🎯 Keybindings:"
  echo "   Ctrl+K Ctrl+[U/D/S/R/E] → Haiku 4.5 presets"
  echo "   Alt+K Alt+[U/D/R]        → Qwen local presets"
}

# Auto-source this file when reopened
alias reload-zsh='source ~/.zshrc && echo "✅ Zed + Ollama config reloaded"'

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/il1v3y/.lmstudio/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ═══════════════════════════════════════════════════════════════
# Claude Code Security Configuration
# ═══════════════════════════════════════════════════════════════

# Load security aliases
if [ -f ~/.config/claude-code/aliases.sh ]; then
    source ~/.config/claude-code/aliases.sh
fi

# Git global hooks template (auto-install on new repos)
git config --global init.templatedir '~/.config/claude-code/hooks_template' 2>/dev/null || true

# Claude Code skills shortcuts
alias cc-skills='ls -la ~/.config/claude-code/skills/'
alias cc-hooks='ls -la ~/.config/claude-code/hooks/'
alias cc-config='less ~/.config/claude-code/config.json'
alias cc-readme='less ~/.config/claude-code/README.md'

# Quick OPSEC check before pushing
git-push-safe() {
    opsec-check
    echo ""
    read -p "Continue with push? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        git push
    else
        echo "Push aborted."
    fi
}
alias gps='git-push-safe'

echo "🔒 Claude Code Security Config loaded"

# ═══════════════════════════════════════════════════════════════
# MCP Servers Aliases
# ═══════════════════════════════════════════════════════════════

alias mcp-install='bash ~/.config/claude-code/mcp-servers/install-mcp.sh'
alias mcp-readme='less ~/.config/claude-code/mcp-servers/MCP_README.md'
alias mcp-list='ls -la ~/.config/claude-code/mcp-servers/*.json'
alias mcp-config='cat ~/.config/claude-code/mcp-servers/claude_desktop_config.json'

# MCP Server testing shortcuts
mcp-test() {
    echo "🧪 Testing MCP Servers..."
    echo ""
    echo "1️⃣  GitHub MCP:"
    echo "   npx -y @modelcontextprotocol/server-github --help"
    echo ""
    echo "2️⃣  Filesystem MCP:"
    echo "   npx -y @modelcontextprotocol/server-filesystem --help"
    echo ""
    echo "3️⃣  PostgreSQL MCP:"
    echo "   npx -y @modelcontextprotocol/server-postgres --help"
    echo ""
    echo "4️⃣  Playwright MCP:"
    echo "   npx -y @microsoft/playwright-mcp --help"
    echo ""
    echo "5️⃣  Docker MCP:"
    echo "   npx -y @modelcontextprotocol/server-docker --help"
    echo ""
    echo "6️⃣  Sentry MCP:"
    echo "   npx -y @sentry/mcp-server --help"
}
# GITHUB_PERSONAL_ACCESS_TOKEN - Set via environment variable

# Picom mode switcher
alias picom-full='~/.config/picom/switch-mode.sh full'
alias picom-minimal='~/.config/picom/switch-mode.sh minimal'
export PATH="$HOME/.local/bin:$PATH"
alias antigravity="~/Applications/Antigravity/antigravity"


# Auto-start ssh-agent for Git operations
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null
   ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

