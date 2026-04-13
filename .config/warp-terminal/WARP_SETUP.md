# Warp Terminal - Red Team & Full Stack Setup

## Overview
Complete Warp terminal configuration optimized for red team operations, full stack development, and offensive security workflows.

**Profile**: ind4skylivey - OSCP | Red Team Operator | Full Stack Dev
- **Specialization**: Exploit Development, Malware Analysis, PHP/Laravel Security, Rust
- **Tools**: Burp Suite, Ghidra, Radare2, Metasploit, Kali Linux

---

## Installation

### 1. Install Warp Terminal
```bash
# macOS
brew install warp

# Linux (Universal)
curl https://app.warp.dev/install.sh -sSL | sh

# Or download from https://www.warp.dev
```

### 2. Link Configurations
```bash
cd ~/dotfiles-s1b
./install.sh  # Automatically links Warp configs or manually:

# Manual linking
ln -sf ~/.config/warp-terminal/keybindings.yaml ~/.config/warp-terminal/keybindings.yaml
ln -sf ~/.config/warp-terminal/QUICK-REFERENCE.md ~/.config/warp-terminal/
ln -sf ~/.config/warp-terminal/WORKFLOW-OPTIMIZATION.md ~/.config/warp-terminal/
ln -sf ~/.local/share/warp-terminal/themes ~/.local/share/warp-terminal/themes
```

### 3. Add Aliases to Shell
The aliases are in your `.zshrc` file already. If starting fresh:

```bash
cat << 'EOF' >> ~/.zshrc

# ============================================
# Red Team + Full Stack Aliases (Warp)
# ============================================

# Networking & Reconnaissance
alias recon='nmap -sV -sC -T4'
alias stealth-scan='nmap -sS -T2 -f'
alias full-enum='nmap -p- -sV -sC -O'
alias net-listen='ss -tulpn | grep LISTEN'
alias ps-watch='watch -n 1 ps aux'

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

# Exploit Development
alias pattern-gen='python3 -c "from pwn import *; print(cyclic(256))"'
alias shellcode-gen='msfvenom -p linux/x64/shell_reverse_tcp'
alias gdb-debug='gdb-peda'

# Full Stack Development
alias php-server='php -S localhost:8000'
alias rust-check='cargo clippy'
alias rust-build='cargo build --release'
alias py-serve='python3 -m http.server 8000'
alias npm-dev='npm run dev'

# Container Labs
alias sec-tools='podman run -it --rm --network sec-tools kalilinux/kali-rolling'

# Git Workflow & Security
alias gstash='git stash'
alias gpush-force='git push --force-with-lease'
alias gcommit-amend='git commit --amend --no-edit'
alias check-diffs='git diff && git diff --cached'
alias scan-leaks='trufflehog git file:///'

# Penetration Testing
alias burp-headless='burpsuite --headless'
alias msfdb-init='msfdb init'
alias msfconsole-q='msfconsole -q -x'

EOF

source ~/.zshrc
```

---

## Themes Available

All themes are in `.local/share/warp-terminal/themes/`:

### 1. **Red Team Operator** (Default - Active)
- **Colors**: Aggressive red/gold on pure black
- **Best for**: Red team operations, penetration testing
- **Accent**: `#ff1744` (Red)
- **Cursor**: `#ffab40` (Gold warning)
- **Folder**: `red-team-operator.yaml`

### 2. **Breach Protocol**
- **Colors**: Neon green (Matrix style)
- **Best for**: Hacker aesthetics, malware analysis
- **Accent**: `#00ff00` (Neon green)
- **Cursor**: `#ff0055` (Red alert)
- **Folder**: `breach-protocol.yaml`

### 3. **Penetration Test**
- **Colors**: Deep purple/red tactical
- **Best for**: Long sessions, reduces eye strain
- **Accent**: `#d946ef` (Magenta)
- **Cursor**: `#f97316` (Orange danger)
- **Folder**: `penetration-test.yaml`

### 4. **Cyberpunk Pastel**
- **Colors**: Pastel neon for reduced fatigue
- **Best for**: Development, long coding sessions
- **Accent**: `#ff6ec7` (Pastel pink)
- **Cursor**: `#00ffcc` (Pastel cyan)
- **Folder**: `cyberpunk-pastel.yaml`

### Switch Theme in Warp
```
Settings → Appearance → Theme → Select from list
```

---

## Keybindings

All keybindings are configured in `keybindings.yaml`:

### Pane Management (Workflow Split)
| Action | Shortcut |
|--------|----------|
| Split Right | `Ctrl+Shift+D` |
| Split Down | `Ctrl+Shift+E` |
| Navigate Left | `Ctrl+Shift+←` |
| Navigate Right | `Ctrl+Shift+→` |
| Navigate Up | `Ctrl+Shift+↑` |
| Navigate Down | `Ctrl+Shift+↓` |

### Tab Management
| Action | Shortcut |
|--------|----------|
| New Tab | `Ctrl+Shift+T` |
| Close Tab | `Ctrl+Shift+W` |
| Next Tab | `Ctrl+Tab` |
| Previous Tab | `Ctrl+Shift+Tab` |

### Command & Search
| Action | Shortcut |
|--------|----------|
| Command Palette | `Ctrl+P` |
| Search History | `Ctrl+R` |
| Search Full Output | `Ctrl+Shift+F` |

---

## Essential Aliases Quick Reference

### Red Team Operations
```bash
recon 192.168.1.0/24              # Network reconnaissance
stealth-scan target.com            # SYN stealth scan
full-enum target                   # Complete enumeration
check-vulns WordPress              # Vulnerability search
burp                               # Launch Burp Suite
```

### Exploit Development
```bash
pattern-gen                        # Generate cyclic patterns
shellcode-gen                      # MSFVenom payload templates
rop-search ./binary                # Find ROP gadgets
gdb-debug                          # PEDA debugging
```

### Malware Analysis
```bash
strings-hunt ./sample              # Extract strings
bin-analyze ./binary               # File type + disassembly
strace-monitor ./malware           # Trace system calls
ltrace-monitor ./malware           # Trace library calls
ghidra                             # Launch Ghidra
```

### Full Stack Development
```bash
php-server                         # Start PHP server on :8000
rust-check                         # Run clippy linter
rust-build                         # Release build
py-serve                           # Python HTTP server
npm-dev                            # Development mode
```

### Security & Git
```bash
scan-commit                        # Check staged changes for secrets
safe-commit                        # Scan then commit atomically
scan-leaks                         # Full repo leak scan
check-diffs                        # Review all changes
```

---

## Workflow Examples

### Red Team Penetration Test Setup
```bash
# Terminal split layout (3 panes):
# ├─ Pane 1 (Left): Reconnaissance
# ├─ Pane 2 (Top Right): Burp Suite
# └─ Pane 3 (Bottom Right): Exploitation prep

# Pane 1
recon 192.168.1.0/24
web-scan -u http://target.com

# Pane 2 (Ctrl+Shift+Right then Ctrl+Shift+D)
burp

# Pane 3
cd ~/security/exploits
check-vulns apache
```

### Full Stack Development
```bash
# Split layout:
# ├─ Pane 1 (Left): Editor/Git
# ├─ Pane 2a (Top Right): Build
# └─ Pane 2b (Bottom Right): Server logs

# Pane 1
code .
git status

# Pane 2a
cargo watch -x "check --color always"

# Pane 2b
npm run dev
```

### Malware Analysis Lab
```bash
# Inside isolated container:
malware-box ubuntu:latest

# Then splits:
# ├─ Pane 1: Ghidra disassembly
# ├─ Pane 2: strace monitoring
# └─ Pane 3: ltrace library calls

ghidra /loot/malware.bin
strace -f ./malware
ltrace -C ./malware
```

---

## Integration with Droid CLI

Use Warp's Agent Mode (Warp AI) for rapid setup:

```bash
# Open Command Palette (Ctrl+P) and ask:
"Generate exploit template for buffer overflow"
"Find all ROP gadgets in this binary"
"Setup Laravel security testing environment"
"Analyze CVE-2024-XXXXX attack vector"
```

---

## Container Security Labs

### Isolated Malware Analysis
```bash
malware-box ubuntu:latest
# Inside: strace, ltrace, gdb, radare2 available
```

### Security Tools Environment
```bash
sec-lab
# Inside: Full Kali Linux environment with nmap, burp, metasploit, etc.
```

### Metasploit Framework
```bash
metasploit
# Inside: MSFConsole with persistent database
```

---

## Customization

### Create Custom Theme
```bash
cat > ~/.local/share/warp-terminal/themes/custom-theme.yaml << 'EOF'
name: Custom Theme
accent: '#your-accent-color'
cursor: '#your-cursor-color'
background: '#your-bg-color'
foreground: '#your-fg-color'
details: darker
terminal_colors:
  bright:
    black: '#...'
    blue: '#...'
    # ... rest of colors
  normal:
    # ...
EOF
```

### Add Custom Aliases
```bash
# Edit ~/.zshrc and add:
alias your-command='your-actual-command'
source ~/.zshrc
```

### Modify Keybindings
```bash
# Edit ~/.config/warp-terminal/keybindings.yaml
"action_name": your-shortcut
```

---

## Troubleshooting

**Q: Theme not applying?**
A: Restart Warp or run `source ~/.zshrc`

**Q: Aliases not working?**
A: Verify they're in `~/.zshrc` and run `source ~/.zshrc`

**Q: Keybindings not responding?**
A: Check `~/.config/warp-terminal/keybindings.yaml` exists

**Q: Split panes not working?**
A: Verify Ctrl+Shift+D binding in keybindings.yaml

---

## File Structure

```
dotfiles-s1b/
├── .config/warp-terminal/
│   ├── keybindings.yaml                    # All keyboard shortcuts
│   ├── WARP_SETUP.md                       # This file
│   ├── QUICK-REFERENCE.md                  # Fast command reference
│   └── WORKFLOW-OPTIMIZATION.md            # Detailed optimization guide
├── .local/share/warp-terminal/themes/
│   ├── red-team-operator.yaml              # Default active theme
│   ├── breach-protocol.yaml                # Matrix-style neon green
│   ├── penetration-test.yaml               # Tactical purple/red
│   └── cyberpunk-pastel.yaml               # Pastel neon theme
└── .zshrc                                  # Aliases appended (lines 88-145+)
```

---

## References

- **Warp Docs**: https://docs.warp.dev/
- **OSCP Methodology**: https://www.offensive-security.com/
- **Exploit Development**: Pwntools, ROPgadget, msfvenom
- **Malware Analysis**: Ghidra, Radare2, IDA Pro
- **Web Security**: Burp Suite, OWASP Top 10

---

## Version History

**v1.0** (2026-01-07)
- Initial Red Team + Full Stack setup
- 4 custom themes
- 40+ security-focused aliases
- Optimized keybindings for split-pane workflow
- Complete documentation (Quick Ref + Workflow Guide)

---

**Setup Status**: ✅ READY FOR OPERATIONS

Your Warp terminal is fully configured for:
- Red team operations & penetration testing
- Exploit development & binary analysis
- Malware analysis & reverse engineering
- Full stack development (PHP, Rust, Python, JavaScript)
- Container-based security labs
- Git workflow with secret detection

Happy hacking! 🔴
