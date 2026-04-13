# 💻 Profile: Local Development

For rapid iteration, multiple projects, and visual workspace organization on your local machine.

---

## Intent

Create an ephemeral, visually organized environment for:
- Writing code with fast feedback
- Managing multiple projects in one session
- Switching contexts without terminal chaos
- Running tests, builds, and quick scripts
- Visual pane organization (editor + shell + logs)

---

## What This Profile Does

**Entrypoint:** `ws-local`

**Tool:** `zellij` (layout-driven workspace)

**Session Structure:**
```
┌──────────────────────────┬─────────────────┐
│                          │                 │
│  Main Editor (nvim)      │  File Browser   │
│  (70% width)             │  (30% width)    │
│                          │                 │
├──────────────────────────┴─────────────────┤
│  Shell / Build Output                     │
│  (Full width, 20% height)                 │
└───────────────────────────────────────────┘
```

**Workflow:**
1. Run `ws-local` (no arguments)
2. Zellij spawns with optimized dev layout:
   - **Main pane (left)**: Neovim for editing
   - **File browser (right)**: Quick file navigation (via `yazi` or `lf`)
   - **Shell pane (bottom)**: Test output, build logs, git commands

**Session Lifespan:**
- Ephemeral (closed when done)
- Fast to spawn (no persistence overhead)
- Can create multiple local sessions for different projects

---

## When to Use

✅ **Use local profile when:**
- Working on local projects (code, scripts, configs)
- Want visual pane organization
- Testing and iterating quickly
- Need to see editor, file list, and shell output simultaneously
- Working on a single machine (no SSH)

❌ **Don't use when:**
- Need session persistence (use `ws-remote`)
- Doing deep writing (use `ws-write`)
- Only need a plain shell
- Want minimal visual overhead

---

## Keybindings

### Pane Navigation
- `Alt+h` / `Alt+j` / `Alt+k` / `Alt+l` — Move between panes (Vim-style)
- `Alt+→` / `Alt+←` / `Alt+↑` / `Alt+↓` — Arrow-based navigation
- `Alt+[` — Previous pane
- `Alt+]` — Next pane

### Pane Resizing
- `Ctrl+Alt+h` / `Ctrl+Alt+j` / `Ctrl+Alt+k` / `Ctrl+Alt+l` — Resize panes

### Operations
- `Ctrl+p` then `d` — Detach session
- `Ctrl+p` then `c` — New window
- `Ctrl+p` then `:` — Command mode (`:help` for all commands)
- `Ctrl+p` then `t` — Toggle floating pane

### Tab/Window Management
- `Ctrl+Tab` — Next window
- `Ctrl+Shift+Tab` — Previous window
- `Ctrl+p` then `n` — New tab

### Neovim (in main pane)
- `<leader>` (space) + file commands (unchanged)
- `:terminal` — Open terminal within nvim if needed
- `Ctrl+w` + `c` — Close split window

---

## Configuration

Your existing configs apply:
- **Neovim**: `~/.config/nvim/init.lua` (unchanged)
- **Zellij**: `~/.config/zellij/zellij.kdl` (unchanged, but layouts customized)
- **Shell**: `~/.config/fish/config.fish` or `.zshrc` (unchanged)

The `ws-local` script **only**:
1. Spawns zellij with the dev layout
2. Opens Neovim in the main pane
3. Respects existing tool configs

---

## Available Layouts

The `ws-local` script includes multiple layout options. Use flags:

```bash
ws-local                    # Default: dev layout (nvim + file browser + shell)
ws-local --write           # Writing layout: larger editor, minimal distractions
ws-local --monitor         # Monitoring: top + logs + metrics
ws-local --fullscreen      # Fullscreen: only editor, no split panes
```

---

## Example Workflows

### Workflow 1: Feature development

```bash
$ ws-local
# Zellij starts with dev layout
# Left pane: nvim with src/main.rs open
# Right pane: file browser showing project structure
# Bottom pane: shell ready for commands

# In bottom pane:
$ cargo build
$ cargo test

# In right pane (file browser):
Navigate with hjkl or arrow keys
Press Enter to open file in main pane (nvim)

# In main pane (nvim):
Edit code, save with :w
Tests re-run in bottom pane
Instant feedback loop
```

### Workflow 2: Juggling multiple files

```bash
$ ws-local
# In right pane (file browser):
Navigate to src/
See all .rs files

# Tab navigation to different files:
Press j to select utils.rs
Press Enter
# nvim now shows utils.rs in main pane

# Split within nvim (if needed):
:vsplit main.rs
# Now seeing multiple files within nvim
```

### Workflow 3: Git workflow + coding

```bash
$ ws-local
# In bottom pane:
$ git status
$ git diff src/feature.rs

# In main pane (nvim):
Make changes to src/feature.rs

# Back to bottom pane:
$ git add src/feature.rs
$ git commit -m "Add feature"
$ git log --oneline -5
```

### Workflow 4: TDD workflow

```bash
$ ws-local
# Terminal window watching tests:
$ cargo watch -x test

# Main editor (nvim):
Write code
Save (:w)
Tests automatically rerun in bottom pane
See red/green feedback instantly
```

---

## Tips & Tricks

### Floating panes for quick tasks
```bash
# Create a floating pane on top:
Ctrl+p then t
# Perfect for quick git commands without losing context
```

### Switch between multiple local sessions
```bash
# Create a second session for another project:
zellij action new-session --layout dev --session-name project2

# List sessions:
zellij action list-sessions

# Switch sessions:
zellij action switch-session --session-name project1
```

### Maximize a pane temporarily
```bash
# In zellij:
Ctrl+p then z
# Maximizes focused pane
# Run again to restore
```

### File browser shortcuts
```bash
# In the file browser (right pane):
hjkl or arrows — navigate
Enter — open file
- — go up directory
~ — home directory
. — toggle hidden files
```

---

## Integration with Your Tools

### MatteriaTrack time tracking
Alias `mtrack` available in all sessions:
```bash
# In bottom pane:
mtrack track -p "Feature" -t "Implement auth"
# ... do work ...
mtrack finish
mtrack stats --today
```

### Prism Terminal personas
If using Fish shell:
```bash
# In bottom pane:
prism apply cyber-noir --shell fish
# Your prompt now displays the persona
```

### Starship prompt
Your custom Starship config applies:
```bash
# In bottom pane:
# Starship shows project info, git status, etc.
# Exact same appearance as your shell rc configured
```

### Git integration
All git aliases from your shell work:
```bash
# In bottom pane (assuming aliases defined in fish/zsh):
gs                # git status
ga                # git add
gc -m "message"   # git commit
```

---

## Troubleshooting

### Pane navigation not working
```bash
# Ensure Alt key is properly sent to terminal:
# In Kitty: check `allow_remote_control yes` in kitty.conf
# In Alacritty: check Ctrl+Alt works in alacritty.toml

# Try arrow-style instead:
Alt+→ to move right
```

### Zellij layout errors
```bash
# Validate the layout file:
zellij setup --layout dev

# Or check config:
cat ~/.config/zellij/zellij.kdl
```

### File browser not showing files
```bash
# Check if yazi or lf is installed:
which yazi
which lf

# Install if missing:
pacman -S yazi      # Recommended (Rust-based, fast)
pacman -S lf        # Alternative (Go-based)
```

### Neovim not starting in main pane
```bash
# Check if nvim is in PATH:
which nvim

# Verify Neovim config:
nvim --version
```

### Session crashes
```bash
# Kill all zellij sessions:
zellij kill-all

# Restart:
ws-local
```

---

## Customizing the Layout

Edit `~/.config/zellij/layouts/dev.kdl`:

```kdl
layout {
    pane size=1 borderless=true {
        plugin location="zellij:tab-bar"
    }
    pane split="vertical" {
        pane split="horizontal" size="80%"{
            pane {
                # Main editor pane
            }
            pane {
                # File browser pane
            }
        }
        pane size="20%" {
            # Shell pane at bottom
        }
    }
    pane size=2 borderless=true {
        plugin location="zellij:strider"
    }
}
```

See `workflow/zellij/layouts/` for example layouts.

---

## Comparison: Local vs Remote

| Aspect | `ws-local` (Zellij) | `ws-remote` (Tmux) |
|--------|---------------------|-------------------|
| **Tool** | Zellij | Tmux |
| **Persistence** | Ephemeral | Persistent |
| **Visual layout** | Rich, built-in | Tiling (manual) |
| **Remote SSH** | ❌ No | ✅ Yes |
| **Best for** | Local dev | Remote/Infrastructure |
| **Session lifespan** | Minutes to hours | Days to weeks |
| **Startup speed** | Instant | Instant |
| **Network resilience** | Not needed | Essential |

---

## Next Steps

1. **Try it:** `ws-local`
2. **Experiment with layouts:** `ws-local --write`, `ws-local --monitor`
3. **Customize keybindings:** Edit `~/.config/zellij/zellij.kdl`
4. **Save your workflow:** Document your personal patterns

See [README.md](../README.md) for the full orchestration system.

