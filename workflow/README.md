# 🧠 Eco-Workflow: Livey Sib Gr0up

A reproducible personal operating system for intentional work. This is an **orchestration layer** on top of your existing dotfiles—not a rewrite, but a formalization of tool roles and workflows.

---

## 💜 Philosophy

Your environment already works. This layer:

- **Formalizes roles** — each tool has a purpose
- **Reduces cognitive load** — clear entry points for different work modes
- **Makes workflows reproducible** — new machine? Same setup, same feel
- **Avoids tool overlap** — no keybinding wars or redundant configs
- **Respects your aesthetic** — Catppuccin purple, terminal-first

Think in terms of:
- **Profiles** — contexts for different work
- **Entrypoints** — scripts that bootstrap the right tools
- **Documentation** — clarity beats cleverness
- **Minimal, reversible changes** — additive only

---

## 🛠️ Tool Roles (The Contract)

### **tmux** — Persistent Backbone
```
Role: Infrastructure layer for remote and long-running work
Intent: Persistent sessions that survive disconnections
When to use:
  • SSH into remote machines
  • Long-running processes (servers, monitors, builds)
  • Collaborative work across sessions
  • Leaving work on pause and returning later
Best with: Plain terminal, minimalist configs
Keybindings: Standard tmux prefix + commands
```

### **zellij** — Local Visual Workspaces
```
Role: Layout-driven, disposable session manager
Intent: Visual organization of local tasks
When to use:
  • Multiple local projects in one session
  • Layout-driven organization (main editor, bottom tailing, right sidebar)
  • Quick task switching with visual feedback
  • Ephemeral sessions you'll close today
NOT for: Long-running remote work (use tmux)
Best with: Neovim, Helix, quick interactive work
Keybindings: Alt+direction to move between panes
```

### **neovim** — Fast Terminal Editor
```
Role: Daily coding workhorse
Intent: Quick, keyboard-driven editing with full LSP support
When to use:
  • Writing code and scripts
  • Quick config edits
  • Fast file navigation and refactoring
  • Within tmux/zellij sessions
Best with: LSP, treesitter, minimal plugin setup
Language: Lua configuration (modern and extensible)
```

### **doom emacs** — Deep Work & Writing
```
Role: The Swiss Army knife for complex projects
Intent: Long-form writing, org-mode mastery, Magit workflows
When to use:
  • Writing documentation (org-mode)
  • Project-level git workflows (Magit)
  • Large codebase navigation and refactoring
  • Literate programming and Emacs Lisp
Best with: org-mode, vterm, evil mode
Note: Takes 2-3s to start; worth it for deep sessions
```

### **helix** — Minimal & Instant
```
Role: Lightweight optional editor
Intent: Fast, zero-config alternative for quick edits
When to use:
  • Instant editing without waiting for LSP
  • Systems with low resources
  • When you want instant feedback over rich plugins
NOT for: Daily work (use neovim or emacs)
Best with: Minimal config (mostly themes and line numbers)
Note: No competition with nvim/emacs; complementary only
```

---

## 📋 Profiles

Each profile is a curated mode for specific work contexts. See `workflow/profiles/` for details:

- **[remote.md](profiles/remote.md)** — SSH work, servers, infrastructure
- **[local.md](profiles/local.md)** — Local development, quick iteration
- **[write.md](profiles/write.md)** — Documentation, org-mode, deep writing
- **[redteam.md](profiles/redteam.md)** — Security-focused work (if applicable)

---

## 🚀 Quick Start

### Start a local workspace
```bash
ws-local
# Launches zellij with a development layout
# Exports: LIVEY_WORKFLOW=local, LIVEY_CONTEXT=<project>
```

### Start a remote session
```bash
ws-remote user@host
# Sets up tmux with your preferred layout
# Exports: LIVEY_WORKFLOW=remote, LIVEY_CONTEXT=<host>
```

### Start a writing session
```bash
ws-write
# Launches emacs with org-mode
# Exports: LIVEY_WORKFLOW=write, LIVEY_CONTEXT=<file>
```

### Start security/red-team work
```bash
ws-redteam
# Specialized tmux layout for focused hacking
# Exports: LIVEY_WORKFLOW=redteam, LIVEY_CONTEXT=<target>
```

All scripts are in `~/dotfiles/bin/` and respect your existing configs.

---

## 🧠 Context Awareness (Phase 2)

Each workflow exports environment variables that enable **reactive behavior** across tools:

### Environment Variables

```bash
LIVEY_WORKFLOW   # "local" | "remote" | "write" | "redteam"
LIVEY_CONTEXT    # Project name, host, file, or target
```

These are available in:
- Parent shell
- Nested shells / panes
- Background processes
- Logging systems

### Tools React Automatically

**Neovim** (read at startup):
- `write` profile: enables line-wrapping, spellcheck, hides column guide

**Doom Emacs** (read at startup):
- `write` profile: enables visual-line-mode, spellcheck, line spacing

**Fish Shell** (optional):
- Function `__livey_prompt_badge` shows `[workflow:context]` badge
- Use: `__livey_prompt_badge` in your prompt

**Tmux** (on remote):
- Session environment includes `LIVEY_WORKFLOW` and `LIVEY_CONTEXT`
- Available in all panes and windows

**Session Logging**:
- All session starts logged to: `~/.local/share/livey/logs/sessions.log`
- Format: `[timestamp] START <profile> | context=<value> | session=<name>`

---

## 📝 Example: Write Profile Awareness

```bash
$ ws-write ~/org/tasks.org
# Emacs starts with:
# - LIVEY_WORKFLOW=write
# - LIVEY_CONTEXT=tasks.org
# - Auto-enables: visual-line-mode, spellcheck, increased line spacing
# - Fish prompt can show: [write:tasks.org]
```

---

## 📁 Structure

```
workflow/
├── README.md                 ← You are here
├── profiles/
│   ├── remote.md            ← SSH, infrastructure, servers
│   ├── local.md             ← Local development
│   ├── write.md             ← Deep writing, org-mode
│   └── redteam.md           ← Security-focused work
├── zellij/
│   └── layouts/
│       ├── dev.kdl          ← Development layout (editor + shell)
│       ├── write.kdl        ← Writing layout
│       └── monitor.kdl      ← Monitoring layout (top + logs + metrics)
└── examples/
    └── (template configs referenced in profiles)
```

---

## ✅ Installation & Setup

### 1. These scripts are already in your dotfiles
No installation needed. The workflow layer is purely additive:
```bash
~/dotfiles/bin/ws-local
~/dotfiles/bin/ws-remote
~/dotfiles/bin/ws-write
~/dotfiles/bin/ws-redteam
```

### 2. Ensure tools are installed
```bash
pacman -S tmux zellij neovim                    # Core tools
yay -S zellij                                   # If not in core repos
# emacs and helix come via their own installers
```

### 3. (Optional) Add to PATH
If `~/dotfiles/bin` is not in your `$PATH`:
```bash
# Add to ~/.config/fish/config.fish or ~/.zshrc
set -gx PATH $PATH ~/dotfiles/bin
# or (zsh):
export PATH="$PATH:$HOME/dotfiles/bin"
```

---

## 🎨 Design Decisions

### Why this structure?
- **Minimal intrusion** — new folder, new scripts. Existing configs untouched.
- **Role clarity** — each tool has one job; no redundancy.
- **Reproducibility** — same workflow on day-1 or day-N on a new machine.
- **Reversibility** — remove `workflow/` and scripts if it doesn't fit your brain.

### Theme consistency
- All tools respect Catppuccin (mocha + mauve)
- Terminal-first: no GUI wrappers
- Keyboard-driven: muscle memory matters
- Minimal plugin bloat: fast startup, clear configs

### Tool separation (why not use one?)
- **tmux vs zellij**: Different use cases. Tmux for persistence/remote. Zellij for local visual layouts.
- **nvim vs emacs**: Neovim for speed, emacs for depth. Both coexist.
- **helix**: Optional, doesn't interfere.

---

## 🔄 Workflow in Action

### Morning: Start local work
```bash
ws-local
# You're now in zellij with:
# - main pane: Neovim
# - right pane: file browser
# - bottom pane: shell for tests/builds
```

### Midday: SSH to server
```bash
ws-remote deploy@prod.example.com
# tmux session with:
# - main pane: logs monitoring
# - right pane: shell for commands
# - bottom pane: metrics display
```

### Afternoon: Write docs
```bash
ws-write
# Emacs opens with org-mode
# Full Magit for git workflows
```

### Late night: Security research (if needed)
```bash
ws-redteam
# tmux with minimalist layout, focus mode
```

Each session is independent. Switch contexts by closing one script and launching another.

---

## 📝 Notes on Customization

These profiles and layouts are **starting points**. Customize them:

1. **Layouts** — Edit `workflow/zellij/layouts/*.kdl` for your preferred pane arrangement
2. **Profiles** — Each profile references specific tools; feel free to swap (e.g., use Helix instead of Neovim)
3. **Keybindings** — Your existing tmux/zellij/nvim configs are unchanged; add to them as needed
4. **Scripts** — Entrypoint scripts are simple bash; fork and adapt

Key rule: **Preserve what works.** This is a thin orchestration layer, not a rewrite.

---

## 🤝 Integration with Existing Tools

This layer respects your existing setup:

- **MatteriaTrack** — Time tracker alias `mtrack` available in all sessions
- **Prism Terminal** — Your Fish personas work as-is in all shells
- **Starship** — Your custom prompt applies everywhere
- **Doom Emacs** — Existing `~/.doom.d` configs untouched
- **Neovim** — Your Lua configs in `~/.config/nvim` unchanged

**No rewrites. Only additions.**

---

## 🚨 Troubleshooting

### Script fails: "command not found"
- Ensure `~/dotfiles/bin` is in your `$PATH`
- Or run with full path: `~/dotfiles/bin/ws-local`

### Zellij layouts not loading
- Check `~/.config/zellij/layouts/` for syntax errors
- Validate KDL with: `zellij setup --layout dev`

### Tmux session not persisting
- Verify tmux server: `tmux list-sessions`
- Attach to existing: `tmux attach-session -t <name>`

### Emacs takes too long to start
- This is normal (2-3s). Start a daemon: `emacs --daemon`
- Then: `emacsclient -c` for fast subsequent launches

---

## 📚 Further Reading

- **Tmux**: `.config/tmux/README.md` (your existing config)
- **Zellij**: `.config/zellij/README.md` (your existing config)
- **Neovim**: `.config/nvim/README.md` + `KEYBINDINGS.md`
- **Doom Emacs**: `~/.doom.d/config.el` (your existing config)

---

## 💡 Final Thoughts

This eco-system is:
- **Calm** — no noise, no redundancy
- **Intentional** — tool choices are deliberate
- **Reproducible** — same setup everywhere
- **Respectful** — of your existing configs and muscle memory

Enjoy your reproducible personal operating system. 🧠✨

