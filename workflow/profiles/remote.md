# 🌐 Profile: Remote Work

For SSH sessions, infrastructure management, and long-running processes on remote machines.

---

## Intent

Create a persistent, reliable environment for:
- Managing remote servers and infrastructure
- Running long-lived processes (servers, monitors, builds)
- Collaborative debugging and deployments
- Working over unreliable network connections

---

## What This Profile Does

**Entrypoint:** `ws-remote user@host [port]`

**Tool:** `tmux` (persistent backbone)

**Session Structure:**
```
┌─────────────────────────────────────────┐
│              Main Editor (nvim)         │  (left 70%)
│                                         │
├─────────────────────────────────────────┤
│  Logs / Monitoring (top-right)          │  (right 30%, top)
├─────────────────────────────────────────┤
│  Interactive Shell (bottom-right)       │  (right 30%, bottom)
└─────────────────────────────────────────┘
```

**Workflow:**
1. SSH to remote machine
2. Tmux spawns with 3 panes:
   - **Main pane (left)**: Code editor, quick edits, navigation
   - **Monitor pane (top-right)**: Tail logs, watch processes
   - **Shell pane (bottom-right)**: Commands, deploys, restarts

**Persistence:**
- Session survives SSH disconnection
- Reconnect with: `tmux attach-session -t <session-name>`
- Left running indefinitely while working on other tasks

---

## When to Use

✅ **Use remote profile when:**
- SSH'ing into production servers
- Working on infrastructure (k8s, docker, VMs)
- Running a long-term CI/CD monitor
- Collaborating on remote debugging
- Need to leave work running and come back

❌ **Don't use when:**
- Quick local file edit (use `ws-local`)
- Deep writing (use `ws-write`)
- Only need a plain shell (just use `ssh` directly)

---

## Keybindings

### Navigation
- `Ctrl+A` then `h/j/k/l` — Move between panes (tmux + vim-tmux-navigator)
- `Ctrl+A` then `Space` — Cycle through layouts
- `Ctrl+A` then `[` — Enter copy-mode (scroll history)

### Operations
- `Ctrl+A` then `c` — Create new window
- `Ctrl+A` then `d` — Detach session (leave running)
- `Ctrl+A` then `&` — Kill current window
- `Ctrl+A` then `:split-window -h` — Horizontal split

### Neovim (in main pane)
- `<leader>` (space) + file operations
- `:terminal` — Open shell within nvim if needed
- `Ctrl+\` then `Ctrl+N` — Exit terminal mode

---

## Configuration

Your existing configs apply:
- **Tmux**: `~/.config/tmux/tmux.conf` (unchanged)
- **Neovim**: `~/.config/nvim/init.lua` (unchanged)
- **Shell**: `.zshrc` or `.bashrc` (unchanged)

The `ws-remote` script **only**:
1. Creates the tmux session layout
2. Connects you to the remote
3. Respects existing tool configs

---

## Example Workflows

### Workflow 1: Deploying a service

```bash
$ ws-remote deploy@prod.internal
tmux session "prod" created with:
  • main (left): nvim for editing deployment configs
  • monitor (top-right): tail -f /var/log/app.log
  • shell (bottom-right): prompt for commands

# In shell pane:
$ docker ps
$ docker logs -f app-container
$ # ... edit configs in main pane with nvim ...
# In main pane (nvim):
:set paste
# paste new config
# save and exit
# In shell pane:
$ docker restart app-container
```

### Workflow 2: Monitoring overnight build

```bash
$ ws-remote ci@buildserver
tmux session "buildserver" created

# In main pane:
$ nvim .jenkins/config.yaml

# In monitor pane:
$ watch -n 1 'ls -lt logs/ | head -5'

# In shell pane:
$ tail -f build.log

# Detach: Ctrl+A then d
# Go do something else
# Later: tmux attach-session -t buildserver
```

### Workflow 3: Pair debugging over SSH

```bash
$ ws-remote pair@shared-dev
# Both developers connect to the same tmux session:
tmux new-session -s debug -x 220 -y 50
# Now you can see the same screen
# Perfect for collaborative debugging
```

---

## Tips & Tricks

### Session naming
The script creates a session named after your host:
```bash
ws-remote user@myhost.com
# Creates session: "myhost"
# Later: tmux attach-session -t myhost
```

### Multiple windows in same session
```bash
# Inside tmux:
Ctrl+A then c           # New window (window 1)
Ctrl+A then c           # New window (window 2)
Ctrl+A then p           # Previous window
Ctrl+A then n           # Next window
Ctrl+A then 0/1/2       # Jump to window by number
```

### Scroll history
```bash
Ctrl+A then [
# Now use arrow keys or vim keys to scroll
q # to exit copy mode
```

### Logging entire session
```bash
# Inside tmux:
Ctrl+A then : (colon)
capture-pane -p -S -200 > session_log.txt
```

---

## Integration with Your Tools

### MatteriaTrack time tracking
All sessions have `mtrack` alias available:
```bash
# In shell pane:
mtrack track -p "Deployment" -t "Update configs"
mtrack finish
```

### Prism Terminal personas
If using Fish shell, personas work:
```bash
# In shell pane:
prism apply cyber-noir --shell fish
# Your prompt now has the cyber-noir theme
```

### Doom Emacs integration (if needed)
If you want to use Emacs instead of Neovim:
```bash
# In main pane:
emacs -nw config.yaml
# (terminal version of Emacs)
```

---

## Troubleshooting

### Session won't attach
```bash
# List all sessions:
tmux list-sessions

# Kill a stuck session:
tmux kill-session -t myhost

# Recreate:
ws-remote user@host
```

### Copy-paste not working
```bash
# Inside tmux, check xclip/xsel:
which xclip
pacman -S xclip

# Then in copy-mode:
Ctrl+A then [
# select with mouse or shift+arrows
# y to copy (if configured)
```

### Disconnection issues
```bash
# Tmux handles disconnection gracefully
# When you reconnect:
tmux attach-session -t <session-name>

# Your panes are exactly as you left them
```

### Performance degradation
```bash
# Check if too many panes open:
Ctrl+A then :
list-panes

# Kill unused panes:
Ctrl+A then x
```

---

## Next Steps

1. **Try it:** `ws-remote user@your-dev-server.com`
2. **Customize:** Edit `bin/ws-remote` to add your favorite hosts
3. **Save workflows:** Document your frequent patterns

See [README.md](../README.md) for the full orchestration system.

