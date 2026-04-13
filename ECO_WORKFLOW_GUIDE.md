# Livey Sib Gr0up — Eco-Workflow System

The idea behind Eco-Workflow is simple: instead of manually launching your editor, file browser, and terminal every time you sit down to work, you launch *contexts*. Each context is a preset that spins up the right tools, with the right layout, for whatever you're about to do.

It's a living ecosystem where the terminal, editor, and OS react to your intent. One entry point, total context awareness, and automated memory so you don't lose track of what you were doing.

---

## The Six Layers

### 1. Orchestration Layer — The Entry Points

The scripts that launch everything live in `~/dotfiles/bin/`. You don't run `zellij`, you run `ws-local`. You don't open Emacs manually, you run `ws-write`.

| Command | Context | Engine | What it does |
|:---|:---|:---|:---|
| `ws-local` | Development | Zellij | Local coding, generic tasks |
| `ws-write` | Deep Work | Emacs daemon | Writing, documentation, planning |
| `ws-redteam` | Security | Tmux + Docker | Pentesting, CTF, isolated research |
| `ws-remote` | Infrastructure | Tmux | SSH sessions, server management |
| `ws-menu` | Launcher | Rofi | Visual menu to pick your context |
| `ws-kill` | Panic button | Bash | Emergency shutdown — kills everything |

### 2. State Layer — Context Awareness

Every session gets environment variables injected so everything knows what's happening:

- `LIVEY_WORKFLOW` — the mode (local, write, redteam, remote)
- `LIVEY_CONTEXT` — the target (project name, file, host)
- `LIVEY_WORKFLOW_SESSION` — unique session ID for logging

### 3. Execution Layer — The Session Engines

#### Zellij (Local / Ephemeral Sessions)

For development work, I use Zellij. Sessions die when you close them — fast iteration, no leftover processes.

**Available layouts:**
| Layout | Split | Good for |
|:---|:---|:---|
| `dev` | Editor (70%) \| Files (30%) / Shell (25%) | Coding with file navigation |
| `monitor` | Monitor (top) \| Logs \| Shell | Process watching & debugging |
| `write` | Editor (75%) \| Reference (25%) | Documentation, long-form |
| `fullscreen` | Single editor pane | Distraction-free mode |

**Pane components:**
- **EDITOR** — Neovim with full config
- **FILES** — Yazi file browser (tree view + preview)
- **SHELL** — Zsh with all my aliases and functions
- **MONITOR** — Gleam process monitor
- **STATUS** — Git branch, datetime, session name

**Starting a session:**
```bash
# Default (dev layout)
ws-local

# Specific layout
ws-local monitor
ws-local write
ws-local fullscreen

# Custom session name
ws-local dev --session my-project
```

Sessions get epic randomly-generated names like `bahamut-dev-myproject`, `leviathan-write-blog`, etc.

**Navigation:**
| Key | Action |
|:---|:---|
| `Ctrl+G` | Enter Zellij mode (like vi's normal mode) |
| `Alt+Arrow` | Move between panes/tabs |
| `Alt+F` | Toggle floating panes |
| `Ctrl+G + T` | Tab management |
| `Ctrl+G + P` | Pane management |
| `Ctrl+G + R` | Resize mode |
| `Ctrl+G + Q` | Quit |

#### Tmux (Persistent / Remote Sessions)

For SSH work and anything that needs to survive disconnects, I use Tmux. Sessions persist until you explicitly kill them.

**Red Team special:** `ws-redteam` can spawn inside a Docker container:
```bash
ws-redteam --container kali    # Kali Linux environment
ws-redteam --container malware # Isolated, no network
```

### 4. Active Intelligence Layer — The "God Mode" Stuff

#### Materia Shift — Visual Feedback

The terminal theme changes based on context:
- **Bahamut** — Local dev (balanced, powerful)
- **Ice** — Writing (cold, focused)
- **Fire** — Red team (alert, danger)
- **Wind** — Remote (cloud, connection)

#### Obsidian Neural Link — Automated Memory

When you exit a session, it reads your shell history and appends a summary to your Obsidian daily note. I can look back at any day and see what I was working on.

#### Protocolo Fantasma — Operational Hygiene

Triggered when exiting `ws-redteam`. It auto-destroys temporary Docker containers, wipes session history, and clears the clipboard. Clean state, no artifacts left behind.

### 5. Control Layer — How You Interact

#### `ws-menu` — The Launcher

Press `Super + Alt + Z` (DWM) and you get a Rofi menu to pick your context, target, and container. No memorizing commands.

#### `ws-kill` — The Killswitch

When things go sideways or you need to leave quickly:
1. Kills ALL Zellij and Tmux sessions
2. Stops ALL Red Team containers
3. Kills the Emacs daemon
4. Wipes `/tmp` and the clipboard
5. Locks the screen

One command, system goes dark.

### 6. Observability Layer — Diagnostics

#### `ws-doctor`

Runs health checks on the whole ecosystem — verifies paths, tools, layouts, and environment propagation.

```bash
ws-doctor
```

**Logs:** `~/.local/share/livey/logs/sessions.log`

---

## The Technical Bits

### Neovim
- Config in `~/.config/nvim/`
- Full IDE setup: LSP, Git integration, Treesitter
- Reads `LIVEY_WORKFLOW` to adjust its UI based on context

### Yazi
- Lives in the right pane of the dev layout
- Tree view with file preview and git status
- Written in Rust, so it's fast

### Zsh
- Config in `~/.config/zsh/`
- All `ws-*` commands available as aliases
- History automatically logged to Obsidian via `livey-log`

### Gleam (Process Monitor)
- Monitor pane in the `monitor` layout
- Real-time process and resource watching
- Press `q` to exit

### zjstatus Plugin
- WASM plugin for Zellij status bar
- Shows git branch, datetime, session name
- Themed with Kanagawa Wave colors

---

## Day-to-Day Usage

### Normal Development Day
1. `ws-local` — opens my dev layout
2. Code in Neovim, browse files with Yazi
3. `exit` — theme resets, session logged to Obsidian

### Security Operation
1. `ws-redteam --container kali`
2. Do the thing
3. `exit` — container destroyed, evidence wiped

### Deep Writing
1. `ws-write`
2. Theme turns to Ice (focus mode)
3. Write in Emacs org-mode
4. `exit` — session summary goes to Obsidian

### When Everything Goes Wrong
1. `ws-kill`
2. System locks and goes dark

---

## Troubleshooting

**"Session not found" error**
Use the `-n` flag for a new session. `ws-local` already includes this, so you shouldn't hit this unless you're running Zellij directly.

**"Another GleamObserver session is running"**
Close the first one by pressing `q` in the monitor pane, then exit.

**Zellij layout not loading**
The layout file isn't where Zellij expects it. Make sure the files are in `workflow/zellij/layouts/`.

---

## Tips

**Clean up old sessions:**
```bash
zellij delete-all-sessions        # Nuke everything
zellij delete-session session-name  # Delete specific one
zellij list-sessions              # See what exists
```

**Check the logs:**
```bash
cat ~/.local/share/livey/logs/sessions.log
tail -f ~/.local/share/livey/logs/sessions.log  # Watch live
```

**Debug environment:**
```bash
echo $LIVEY_WORKFLOW
echo $LIVEY_CONTEXT
echo $LIVEY_WORKFLOW_SESSION
```

---

## File Structure

```
dotfiles/
├── bin/
│   ├── ws-local           # Dev workspace entry point
│   ├── ws-write          # Writing workspace (Emacs)
│   ├── ws-redteam        # Security workspace
│   ├── ws-remote         # Remote SSH workspace
│   ├── ws-menu           # Rofi launcher
│   ├── ws-kill           # Emergency shutdown
│   ├── livey-log         # Obsidian logging
│   ├── livey-theme       # Theme switcher
│   └── ws-doctor         # Diagnostics
│
├── workflow/
│   └── zellij/
│       ├── layouts/
│       │   ├── dev.kdl          # 3-pane layout
│       │   ├── monitor.kdl      # 3-pane with monitoring
│       │   ├── write.kdl        # 2-pane writing layout
│       │   └── fullscreen.kdl   # Single pane
│       └── plugins/
│           └── zjstatus.wasm    # Status bar plugin
│
└── .config/
    ├── zsh/                     # Shell config
    └── nvim/                    # Neovim config
```

---

Last updated: 2025-12-18 — Zellij integration complete, everything's running smooth.
