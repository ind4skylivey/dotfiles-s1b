# Warp Terminal Optimization for Red Team Dev & Full Stack

## Your Profile (ind4skylivey)
- **Role**: Red Team Operator + Full Stack Developer
- **Stack**: Python, PHP, Rust, C, Bash
- **Specialties**: Exploit development, malware analysis, reverse engineering
- **Frameworks**: Laravel (PHP), Vue.js, Rust async
- **Tools**: Burp, Ghidra, Radare2, Metasploit

---

## 1. OPTIMIZED ALIASES FOR YOUR WORKFLOW

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
# ========== RED TEAM OPERATIONS ==========
alias recon='nmap -sV -sC -T4'
alias stealth-scan='nmap -sS -T2 -f'
alias full-enum='nmap -p- -sV -sC -O'
alias web-scan='gobuster dir -u'
alias check-vulns='searchsploit'

# ========== EXPLOIT DEVELOPMENT ==========
alias rop-search='ropper -f'
alias pattern-gen='python3 -c "from pwn import *; print(cyclic(256))"'
alias shellcode-gen='msfvenom -p linux/x64/shell_reverse_tcp'
alias gdb-debug='gdb-peda'

# ========== MALWARE ANALYSIS ==========
alias strings-hunt='strings'
alias bin-analyze='file && objdump -d'
alias strace-monitor='strace -f -e trace=network,file'
alias ltrace-monitor='ltrace -C'

# ========== FULL STACK DEV ==========
alias php-server='php -S localhost:8000'
alias rust-check='cargo clippy'
alias rust-build='cargo build --release'
alias py-serve='python3 -m http.server 8000'

# ========== DOCKER/SECURITY LAB ==========
alias malware-box='podman run -it --rm --network malware-isolated'
alias sec-lab='podman run -it --rm --network sec-tools'
alias kali='docker run -it --rm kalilinux/kali-rolling'

# ========== GIT & PROJECT MANAGEMENT ==========
alias gstash='git stash'
alias gpush-force='git push --force-with-lease'
alias gcommit-amend='git commit --amend --no-edit'
alias check-diffs='git diff && git diff --cached'

# ========== QUICK PENETRATION TESTING ==========
alias burp='burpsuite > /dev/null 2>&1 & disown'
alias ghidra='ghidra > /dev/null 2>&1 & disown'
alias sqlmap-quick='sqlmap -u'
alias xss-check='grep -ri "innerHTML\|eval\|document.write"'

# ========== SECURITY SCANNING ==========
alias scan-secrets='git diff | grep -iE "password|api_key|secret|token|private_key|aws_|bearer"'
alias scan-commit='git diff --cached | grep -iE "password|api_key|secret|token"'
alias scan-leaks='trufflehog git file:///'

# ========== CUSTOM UTILS ==========
alias whoami-info='whoami && hostname && pwd && id'
alias net-listen='ss -tulpn | grep LISTEN'
alias ps-watch='watch -n 1 ps aux'
```

---

## 2. RECOMMENDED THEMES BY CONTEXT

### For Offensive Operations (Red Team):
```
→ Red Team Operator (aggressive red/gold)
→ Breach Protocol (Matrix-style neon green)
```

### For Malware Analysis:
```
→ Penetration Test (purple/dark theme)
→ Cyberpunk Pastel (atmospheric, reduces eye strain)
```

### For Full Stack Dev:
```
→ Rosé Pastel (calming, code-friendly)
→ Cyberpunk Pastel (hacker vibe but readable)
```

---

## 3. RECOMMENDED WARP CONFIGURATION

### Settings → Appearance
- **Font Size**: 13-14 (your current 13 is good)
- **Zoom**: 125% (keep it)
- **Spacing**: Compact (current, perfect)
- **Theme**: Alternate by context

### Settings → Keybindings (ADDITIONAL)
```yaml
# Split panes quickly
"pane:split_pane_right": ctrl-shift-d
"pane:split_pane_down": ctrl-shift-e

# History search for exploit development
"search:search_history": ctrl-r

# Command palette for custom commands
"command_palette:open": ctrl-p
```

### Settings → Workflows
Create custom workflows for:
1. **Penetration Testing Flow**
   - Opens 3 panes: reconnaissance | exploitation | post-exploitation
   
2. **Development Flow**
   - Pane 1: Editor + git
   - Pane 2: Build/tests
   - Pane 3: Server/logs

3. **Malware Analysis Flow**
   - Pane 1: Ghidra/Radare2
   - Pane 2: Strace/ltrace
   - Pane 3: Radare2 console

---

## 4. COMMAND PALETTE CUSTOM (for Warp)

In `~/.config/warp-terminal/commands.json`:

```json
{
  "commands": [
    {
      "name": "Scan Network",
      "command": "nmap -sV -sC -T4"
    },
    {
      "name": "Start PHP Dev Server",
      "command": "cd ~/projects && php -S localhost:8000"
    },
    {
      "name": "Rust Release Build",
      "command": "cargo build --release && echo 'Build complete'"
    },
    {
      "name": "Check for Leaks",
      "command": "git diff --cached | grep -iE 'password|api_key|secret|token'"
    },
    {
      "name": "Malware Analysis Box",
      "command": "podman run -it --rm --network malware-isolated ubuntu:latest"
    },
    {
      "name": "Start Security Lab",
      "command": "docker run -it --rm kalilinux/kali-rolling"
    }
  ]
}
```

---

## 5. AGENT MODE OPTIMIZATION

Use **Warp Agent Mode** for:

### Red Team Operations
```
"Automate nmap scanning workflow"
→ Agent executes reconnaissance → analyzes results → suggests exploits
```

### Full Stack Development
```
"Setup Laravel + Rust project"
→ Agent creates structure, installs deps, configures testing
```

### Exploit Development
```
"Generate PoC for CVE-XXXX"
→ Agent searches for details, creates template, generates payloads
```

---

## 6. INTEGRATED WORKFLOW EXAMPLE

### Typical Red Team Session:

```bash
# 1. Open Warp with Red Team Operator theme
warp

# 2. Split panes (ctrl-shift-d)
# Pane 1: Reconnaissance
recon 192.168.1.0/24

# 3. In Pane 2 (ctrl-shift-right → ctrl-shift-d)
# Start Burp
burp

# 4. In Pane 3
# Prepare exploits
cd ~/security/exploits
ls -la
```

### Typical Full Stack Session:

```bash
# 1. Cyberpunk Pastel theme (less tiring)
warp

# 2. Split panes (dev | tests | logs)
# Pane 1: IDE + git
cd ~/projects/int3rceptor
code .

# Pane 2: Build
cargo watch -x "check --color always"

# Pane 3: Server
npm run dev
```

---

## 7. INTEGRATION WITH MCP & HOOKS

### Pre-commit Hook (Security Check)
```bash
#!/bin/bash
# ~/.git/hooks/pre-commit
echo "Scanning for secrets..."
git diff --cached | grep -iE "password|api_key|secret|token|bearer" && {
  echo "⚠️  Secrets detected! Aborting commit."
  exit 1
}
echo "✓ No secrets found. Safe to commit."
```

### Custom Droid for Red Team
```bash
droid "analyze-binary" /path/to/binary
# Automatically executes: file → strings → objdump → radare2
```

---

## 8. PERFORMANCE TIPS

1. **Use Agent Mode for quick research**
   - "Find exploit for OpenSSL 1.1.1k"
   - Agent searches, filters results

2. **Setup Command Aliases at startup**
   - The aliases are already in .zshrc
   - Source automatically in each session

3. **Use split panes for contextualization**
   - Keep history visible
   - Monitor multiple processes

4. **Combine themes by context**
   - Red Team Operator for offensive work
   - Rosé Pastel for calm coding

---

## 9. FINAL RECOMMENDATIONS

✅ **Do**
- Use aliases to reduce typing
- Split panes for multiple contexts
- Predefined workflows for common sessions
- Agent Mode for quick research

❌ **Avoid**
- Writing full commands every time
- Losing context when switching panes
- Using aggressive theme during long coding sessions
- Leaving secrets in visible commands

---

**Your setup is optimized for:**
- OSCP-like penetration testing workflows
- Fast exploit development
- Full stack development (PHP + Vue + Rust)
- Malware analysis and reverse engineering
- Automated red team operations

Ready to operate! 🔴
