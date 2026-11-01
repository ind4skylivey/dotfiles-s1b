# Warp Terminal - Quick Reference Guide

## Current Setup Status ✅
- **Theme**: Red Team Operator (aggressive red/gold)
- **Aliases**: 40+ configured for red team, dev, security
- **Keybindings**: Optimized for split-pane workflow
- **Shell**: Zsh with Powerlevel10k + Droid CLI

---

## MOST USED COMMANDS

### Red Team Operations
```bash
recon 192.168.1.0/24                # Quick network scan
stealth-scan 10.0.0.1               # SYN stealth scan
full-enum target.com                # Full enumeration
check-vulns WordPress               # Find exploits
burp                                # Launch Burp Suite
```

### Exploit Development
```bash
pattern-gen                         # Generate cyclic patterns
shellcode-gen                       # MSFVenom templates
rop-search ./binary                 # Find ROP gadgets
gdb-debug                          # PEDA debugging
```

### Malware Analysis
```bash
strings-hunt ./malware              # Extract strings
bin-analyze ./binary                # File + objdump
strace-monitor ./binary             # Trace syscalls
ltrace-monitor ./binary             # Trace library calls
ghidra                             # Launch Ghidra
```

### Full Stack Development
```bash
php-server                          # PHP dev server on :8000
rust-build                          # Release build
rust-check                          # Clippy lint
py-serve                           # Python HTTP server
npm-dev                            # Dev mode
```

### Git Security
```bash
scan-commit                         # Check staged for secrets
safe-commit                         # Scan then commit
scan-leaks                         # Find all leaks in repo
check-diffs                        # View all changes
```

### Container Labs
```bash
malware-box ubuntu:latest          # Isolated malware analysis
sec-lab                            # Security tools container
kali                               # Full Kali environment
metasploit                         # Metasploit framework
```

---

## KEYBOARD SHORTCUTS

### Pane Management
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

## WORKFLOW EXAMPLES

### Red Team Penetration Testing
```
1. Launch Warp (Red Team Operator theme auto-loads)
2. Ctrl+Shift+D → Split pane for reconnaissance
3. Pane 1: recon 192.168.0.0/24
4. Ctrl+Shift+Right → Navigate to Pane 2
5. Ctrl+Shift+D → Split another pane for exploitation
6. Pane 2: Set up exploit dev environment
7. Pane 3: Monitor with strace/ltrace
```

### Full Stack Development
```
1. Ctrl+Shift+D → Split for development
2. Pane 1: Your IDE commands
3. Ctrl+Shift+Right → Pane 2
4. Ctrl+Shift+E → Split below for build
5. Pane 2a: cargo watch -x check
6. Pane 2b: npm run dev
7. Ctrl+Shift+Right → Pane 3 for logs
```

### Malware Analysis Workflow
```
1. malware-box ubuntu:latest (isolated container)
2. Ctrl+Shift+D → Split panes
3. Pane 1: ghidra /path/to/binary
4. Pane 2: strace-monitor /path/to/binary
5. Pane 3: ltrace monitoring
6. Analyze with all info visible
```

---

## THEME SWITCHING

Available themes in Warp Settings → Appearance → Theme:

1. **Red Team Operator** (Current)
   - Aggressive red/gold
   - Best for: Security operations
   
2. **Breach Protocol**
   - Neon green (Matrix style)
   - Best for: Hacker aesthetic
   
3. **Penetration Test**
   - Deep purple/red
   - Best for: Tactical operations
   
4. **Cyberpunk Pastel**
   - Pastel colors
   - Best for: Long development sessions

### Change Theme Fast
```bash
# Edit theme in settings:
# Warp → Settings → Appearance → Theme
# Select your preferred theme
```

---

## AGENT MODE (Warp AI)

Quick operations with AI assistance:

```bash
# In Warp Command Palette (Ctrl+P):
"Analyze binary for vulnerabilities"
"Generate exploit template for CVE-2024-XXXX"
"Setup Laravel security testing"
"Find ROP gadgets in libc"
```

---

## FILE LOCATIONS

| Item | Path |
|------|------|
| Themes | `~/.local/share/warp-terminal/themes/` |
| Settings | `~/.config/warp-terminal/user_preferences.json` |
| Keybindings | `~/.config/warp-terminal/keybindings.yaml` |
| Shell Config | `~/.zshrc` |
| Aliases | `~/.zshrc` (lines 88-145) |

---

## TIPS & TRICKS

### 1. Quick Repository Scanning
```bash
scan-commit  # Before every commit
safe-commit  # Safer: scan + commit in one
```

### 2. Split Pane Monitoring
Use 3 panes:
- **Left**: Your work
- **Middle**: Build/tests
- **Right**: Logs/monitoring

### 3. Theme Per Task
- Red Team ops → Red Team Operator
- Development → Cyberpunk Pastel
- Analysis → Penetration Test

### 4. Rapid Exploitation
```bash
# Generate pattern
pattern-gen | xclip
# Run binary with pattern
./vulnerable_binary $(xclip -o)
# Find offset in GDB
gdb-debug
```

### 5. Container Security Lab
```bash
malware-box ubuntu:latest
# Inside container:
apt update && apt install -y radare2 ghidra
# Full reverse engineering environment
```

---

## PROBLEM SOLVING

**Q: Theme not applying?**
A: Restart Warp or run `source ~/.zshrc && warp`

**Q: Aliases not working?**
A: Check they're in `~/.zshrc` and run `source ~/.zshrc`

**Q: Keybindings not responding?**
A: Verify in `~/.config/warp-terminal/keybindings.yaml`

**Q: Need new theme?**
A: Create in `~/.local/share/warp-terminal/themes/yourtheme.yaml`

---

## COMMON WORKFLOWS

### Security Audit of Web App
```bash
# Tab 1: Reconnaissance
recon app.target.com
web-scan -u http://app.target.com -w /usr/share/wordlists/dirb/common.txt

# Tab 2: Burp (split)
burp

# Tab 3: Exploitation prep
cd ~/security/exploits
ls -la
```

### Exploit Development
```bash
# Pane 1: Vulnerability research
searchsploit CVE-YYYY-XXXX

# Pane 2: Development
pattern-gen > pattern.txt
./vulnerable_binary < pattern.txt

# Pane 3: Debugging
gdb-debug ./vulnerable_binary
```

### Binary Analysis
```bash
# Container
malware-box alpine

# Inside:
strings /loot/malware > strings.txt
radare2 /loot/malware
ghidra /loot/malware
```

---

## NEXT STEPS

1. **Test all aliases**:
   ```bash
   recon localhost  # Should work
   php-server       # Should start server
   scan-commit      # Should scan for secrets
   ```

2. **Try split panes**:
   ```bash
   Ctrl+Shift+D     # Split right
   Ctrl+Shift+E     # Split down
   Ctrl+Shift+→     # Navigate
   ```

3. **Explore themes**:
   - Open Settings
   - Go to Appearance → Theme
   - Try each one (takes 5 seconds to switch)

4. **Read full guide**:
   - See `~/.config/warp-terminal/WORKFLOW-OPTIMIZATION.md`

---

**You're all set!** 🔴

Your Warp terminal is now optimized for Red Team operations, Full Stack development, and security research. Enjoy the terminal! 

Questions? Check the full guides or modify `.zshrc` and `keybindings.yaml` as needed.
