# 🎯 Profile: Red-Team & Security Work

For focused, minimalist security research, penetration testing, and threat analysis.

---

## Intent

Create a focused, distraction-free environment for:
- Security research and red-teaming
- Penetration testing engagements
- CTF (Capture The Flag) competitions
- Exploit development and testing
- Network reconnaissance
- Threat analysis and documentation

---

## What This Profile Does

**Entrypoint:** `ws-redteam`

**Tool:** `tmux` (minimalist focus layout)

**Session Structure:**
```
┌─────────────────────────────────────────┐
│                                         │
│       Main: Work Area (nvim/shell)      │
│       100% focus on current task        │
│                                         │
├─────────────────────────────────────────┤
│  Status Line: Time | IP | Port Listeners│
│  No distractions, minimal chrome        │
└─────────────────────────────────────────┘
```

**Workflow:**
1. Run `ws-redteam`
2. Tmux spawns in focus mode:
   - Full-screen main pane for active work
   - Minimal status bar showing only essentials (time, network info)
   - No unnecessary panes or visual clutter
3. Switch to full-screen when in deep focus
4. Quick access to specialized tools (metasploit, burp, wireshark, etc.)

**Session Lifespan:**
- Medium to long (1-8 hours per engagement)
- Can be suspended and resumed
- Optimized for uninterrupted concentration

---

## When to Use

✅ **Use redteam profile when:**
- Active security engagement (authorized penetration testing)
- CTF competition or challenge solving
- Exploit development and testing (in lab environment)
- Network reconnaissance and analysis
- Writing security tools and payloads
- Deep security research requiring focus

❌ **Don't use when:**
- General development (use `ws-local`)
- Remote infrastructure management (use `ws-remote`)
- Documentation writing (use `ws-write`)
- Unauthorized or illegal testing

---

## Keybindings

### Navigation & Focus
- `Ctrl+A` then `Space` — Maximize/minimize focus mode
- `Ctrl+A` then `z` — Zoom current pane (fullscreen)
- `Ctrl+A` then `!` — Break pane into separate window

### Session Control
- `Ctrl+A` then `d` — Detach session (leave running)
- `Ctrl+A` then `s` — List all sessions
- `Ctrl+A` then `:attach-session -t <name>` — Reattach to named session

### Command Execution
- `Ctrl+A` then `:` — Enter command mode
- `Ctrl+A` then `[` — Enter copy-mode (scroll history)

### Window Management
- `Ctrl+A` then `c` — New window (new task)
- `Ctrl+A` then `n` — Next window
- `Ctrl+A` then `p` — Previous window
- `Ctrl+A` then `w` — List windows

---

## Configuration

Your existing configs apply:
- **Tmux**: `~/.config/tmux/tmux.conf` (unchanged)
- **Neovim**: `~/.config/nvim/init.lua` (unchanged)
- **Shell**: `.zshrc` or `.bashrc` (unchanged)

The `ws-redteam` script **only**:
1. Creates a minimalist tmux session
2. Removes visual distractions (tabs, decorations)
3. Enables focus mode
4. Respects existing tool configs

---

## Common Tools & Workflows

### Network Reconnaissance
```bash
# Create new window for reconnaissance:
Ctrl+A then c

# Run reconnaissance tools:
nmap -sV <target>
nmap --traceroute <target>
nikto -h <target>
dirbuster -u <target> -w /usr/share/wordlists/dirbuster/

# Monitor in separate pane:
Ctrl+A then " (split horizontal)
watch -n 1 'netstat -an | grep ESTABLISHED'
```

### Exploit Development
```bash
# Window 1: Editor
Ctrl+A then c
nvim exploit.py

# Window 2: Testing
Ctrl+A then c
python exploit.py --target <target>
python exploit.py --check

# Window 3: Listener
Ctrl+A then c
nc -lvnp 4444
```

### CTF Challenges
```bash
# Window 1: Main work
nvim challenge.txt
# Write-up or solution

# Window 2: Testing
python3 solver.py
nc challenge.server.com 1337

# Window 3: Tools
./flag_finder.sh
strings binary | grep flag
```

### Burp Suite Coordination
```bash
# Window 1: Burp (GUI, may need GUI tmux or separate)
Ctrl+A then c

# Window 2: Manual requests
curl -x http://localhost:8080 <target>
sqlmap -u "<target>" --dbs

# Window 3: Monitoring
tail -f /var/log/proxy.log
```

---

## Tips & Tricks

### Quick Session Naming
```bash
# Name the session after the engagement:
ws-redteam "acme-corp-pentest"
# Later: tmux attach-session -t acme-corp-pentest
```

### Named Windows for Different Tasks
```bash
# Create windows with descriptive names:
Ctrl+A then c
Ctrl+A then , (rename current window)
# Name it: "recon", "exploit", "listener", etc.
```

### Focus Mode: Hide Everything Else
```bash
# Maximize pane to fullscreen:
Ctrl+A then z
# Press again to restore
```

### Quick Logging
```bash
# Capture entire session to file:
Ctrl+A then : (colon)
capture-pane -p -S -200 > engagement_log.txt
```

### Multiple Concurrent Engagements
```bash
# Create separate sessions:
ws-redteam "client-a"
ws-redteam "client-b"

# Switch between:
tmux attach-session -t client-a
# Detach: Ctrl+A d
tmux attach-session -t client-b
```

---

## Security Best Practices

### Engagement Documentation
```bash
# Create a log directory:
mkdir -p ~/engagements/$(date +%Y-%m-%d)/

# Start session with logging:
Ctrl+A then :
capture-pane -p -S -200 > ~/engagements/$(date +%Y-%m-%d)/session.log
```

### Isolated Testing Environment
```bash
# Ensure you're in the correct target environment:
# Never run tools against production unless authorized
# Use isolated test environments, labs, or authorized targets
```

### Evidence Preservation
```bash
# Save findings and evidence:
# Screenshots: scrot, flameshot
# Terminal output: use `script` command
# Databases: export to CSV/JSON
```

### Network Isolation
```bash
# For sensitive testing:
# Use isolated network interfaces
# Consider air-gapping sensitive analysis
# Disable network access when not needed
```

---

## Integration with Your Tools

### MatteriaTrack for time tracking
Track security engagement time:
```bash
# Start engagement:
mtrack track -p "Penetration Testing" -t "ACME Corp - Reconnaissance"

# ... work ...

# End engagement:
mtrack finish
mtrack stats --today
```

### Neovim for payload editing
```bash
# In tmux window:
nvim payload.py

# Edit exploit code with full LSP support
# Use your familiar keybindings
```

### Quick shell commands
```bash
# Use your shell aliases for common commands:
# Example aliases might include:
alias nmap-fast='nmap -p- -sV'
alias burp-proxy='export http_proxy=http://localhost:8080'
```

---

## Troubleshooting

### Session crashes
```bash
# List all sessions:
tmux list-sessions

# Kill and restart:
tmux kill-session -t <name>
ws-redteam <name>
```

### Tool installation missing
```bash
# Common security tools:
pacman -S nmap nikto sqlmap
yay -S metasploit-git burpsuite wireshark-qt

# Or build from source as needed
```

### Network connectivity issues
```bash
# Check network:
ip addr show
ip route show

# Test connectivity:
ping -c 1 8.8.8.8
```

### Tmux pane unresponsive
```bash
# Kill pane:
Ctrl+A then x (confirm kill)

# Create new pane:
Ctrl+A then c
```

---

## Ethical Considerations

This profile is designed for:
- ✅ Authorized penetration testing engagements
- ✅ CTF competitions and training labs
- ✅ Personal/educational security research
- ✅ Defensive security work
- ✅ Threat analysis on owned systems

This profile should NOT be used for:
- ❌ Unauthorized access or hacking
- ❌ Malware development for attack purposes
- ❌ Denial of Service (DoS) attacks
- ❌ Supply chain compromise
- ❌ Illegal intrusion activities

**Always ensure you have proper authorization before performing security testing.**

---

## Example CTF Workflow

```bash
$ ws-redteam "HTB-Challenge"

# Window 1: Challenge analysis
:help
nvim challenge-notes.md

# Window 2: Running tools
:help
./analyze.sh < challenge.bin

# Window 3: Exploitation
:help
python3 exploit.py --target localhost --port 9000

# Window 4: Monitoring results
:help
nc -lvnp 4444
# Captures reverse shell or flag submission

# When done:
Ctrl+A then d (detach)
# Later: tmux attach-session -t HTB-Challenge
```

---

## Comparison: Redteam vs Other Profiles

| Aspect | `ws-redteam` (Tmux) | `ws-local` (Zellij) | `ws-remote` (Tmux) |
|--------|---------------------|---------------------|-------------------|
| **Focus mode** | ✅ Minimalist | ❌ Visual panes | ❌ Infrastructure |
| **Best for** | Security work | Development | Servers |
| **Tool density** | High (terminal) | Visual | Visual |
| **Persistence** | Yes | Ephemeral | Yes |
| **Distraction level** | Minimal | Moderate | Moderate |

---

## Next Steps

1. **Try it:** `ws-redteam`
2. **Customize** `~/.config/tmux/tmux.conf` for your preferences
3. **Build your toolkit** — install specialized security tools
4. **Document** — keep detailed notes of findings

**Remember:** With great power comes great responsibility. Use these tools ethically and legally.

See [README.md](../README.md) for the full orchestration system.

