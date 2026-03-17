# 🌌 Livey Sib Gr0up — Eco-Workflow Master Guide

> **Philosophy:** A living ecosystem where the terminal, editor, and OS react intelligently to your intent. One entry point, total context awareness, and automated memory.

---

## 🏗️ The 6-Layer Architecture

### 1️⃣ Orchestration Layer (Entrypoints)
*The brain. Never launch tools directly; launch workflows.*

Location: `~/dotfiles/bin/`

| Command | Workflow | Engine | Purpose |
| :--- | :--- | :--- | :--- |
| **`ws-local`** | Development | Zellij | Local coding, generic tasks. |
| **`ws-write`** | Deep Work | Emacs (Daemon) | Writing, documentation, planning. |
| **`ws-redteam`**| Security | Tmux + Docker | Pentesting, CTF, Ops. |
| **`ws-remote`** | Infrastructure | Tmux (SSH) | Server management. |
| **`ws-menu`** | **Launcher** | Rofi | Visual GUI to launch all above. |
| **`ws-kill`** | **Panic** | Bash | **Emergency shutdown.** |

### 2️⃣ State Layer (Context Awareness)
*The common language. Variables injected into every session.*

*   `LIVEY_WORKFLOW`: The mode (`local`, `write`, `redteam`, `remote`).
*   `LIVEY_CONTEXT`: The target (project name, file, host).
*   `LIVEY_WORKFLOW_SESSION`: Unique session ID.

### 3️⃣ Execution Layer (Session Engines)

#### 🟦 Zellij (Local / Ephemeral)
*   **Layouts:** `dev` (default), `write`, `monitor`, `fullscreen`.
*   **Behavior:** Sessions die when closed. Fast iteration.
*   **Theme:** Kanagawa Wave with zjstatus plugin for git branch + time display.

##### Zellij Layout Details

| Layout | Purpose | Panes | Best For |
| :--- | :--- | :--- | :--- |
| **`dev`** | Development | Editor (70%) \| Files (30%) / Shell (25%) | Coding with file navigation |
| **`monitor`** | System Monitoring | Monitor (top) \| Logs \| Shell | Process monitoring & debugging |
| **`write`** | Deep Work | Editor (75%) \| Reference (25%) | Documentation, long-form writing |
| **`fullscreen`** | Focus Mode | Single Editor Pane | Distraction-free editing |

##### Pane Components

- **EDITOR:** Neovim with full config
- **FILES:** Yazi file browser (tree view + preview)
- **SHELL:** Zsh with all aliases and functions
- **MONITOR:** Gleam process monitor
- **STATUS:** Git branch + datetime + session info

##### Usage Examples

```bash
# Start dev layout (default)
ws-local

# Start specific layout
ws-local monitor
ws-local write
ws-local fullscreen

# Custom session name
ws-local dev --session my-project

# All layouts use epic session names (bahamut, leviathan, vortex, etc.)
# Format: {EPIC_NAME}-{LAYOUT}-{PROJECT_NAME}
```

##### Navigation & Controls

| Keybinding | Action |
| :--- | :--- |
| `Ctrl+G` | Enter "locked" mode (Emacs-like normal mode) |
| `Alt+Arrow` | Move between panes/tabs |
| `Alt+F` | Toggle floating panes |
| `Ctrl+G + T` | Tab mode (manage tabs) |
| `Ctrl+G + P` | Pane mode (manage panes) |
| `Ctrl+G + R` | Resize mode |
| `Ctrl+G + Q` | Quit zellij |

##### Epic Session Names

Zellij generates memorable session names randomly from this list:
```
bahamut, tiamat, leviathan, behemoth, fenrir, jormungandr,
odin, zeus, ares, athena, vortex, nebula, nova, void, phantom
```

#### 🟩 Tmux (Persistent / Remote / Ops)
*   **Behavior:** Sessions persist detach/attach.
*   **Red Cell Containment (Docker):**
    *   `ws-redteam --container kali`: Spawns Tmux *inside* a Kali container.
    *   `ws-redteam --container malware`: Spawns isolated container (no network).

### 4️⃣ Active Intelligence Layer ("God Mode" Features)

#### 🎨 Materia Shift (Visual Resonance)
The terminal theme adapts to the danger level.
*   **Bahamut:** Local Dev (Balanced/Power).
*   **Ice:** Writing (Focus/Cold).
*   **Fire:** Red Team (Alert/Danger).
*   **Wind:** Remote (Cloud/Connection).

#### 🧠 Obsidian Neural Link (Automated Memory)
*   **What it does:** Upon session exit (`trap EXIT`), it reads your shell history.
*   **The Output:** Appends a bullet-point summary to your **Obsidian Daily Note**.

#### 👻 Protocolo Fantasma (Operational Hygiene)
*   **Trigger:** Exiting `ws-redteam`.
*   **Action:** Auto-destroys temporary Docker containers, wipes session history, clears clipboard.

### 5️⃣ Control Layer (User Interface)

#### 🕹️ `ws-menu` (The Launcher)
*   **Trigger:** `Super + Alt + Z` (DWM).
*   **Interface:** Rofi Menu.
*   **Features:** Interactive selection of workflows, targets, and containers.

#### 💀 `ws-kill` (The Killswitch)
*   **Trigger:** `ws-kill` command.
*   **Action:**
    1.  Kills ALL Zellij/Tmux sessions.
    2.  Stops ALL RedTeam containers.
    3.  Kills Emacs Daemon.
    4.  Wipes `/tmp` and Clipboard.
    5.  Locks Screen.

### 6️⃣ Observability & Verification Layer

#### 🩺 `ws-doctor` (Diagnostic)
*   Runs E2E health checks on the ecosystem.
*   Verifies paths, tools, layouts, and env propagation.
*   Usage: `ws-doctor`

#### 📜 Logs
*   Session Audits: `~/.local/share/livey/logs/sessions.log`

---

## 🛠️ Technical Components

### Neovim (Editor)
*   **Config Location:** `~/.config/nvim/`
*   **Features:** Full IDE setup with LSP, Git integration, Treesitter
*   **Environment Awareness:** Reads `LIVEY_WORKFLOW` to adjust UI

### Yazi (File Browser)
*   **Integration:** Right pane in `dev` layout
*   **Features:** Tree view, file preview, git status
*   **Why Yazi:** Modern alternative to lf, written in Rust

### Zsh Shell
*   **Location:** `~/.config/zsh/`
*   **Aliases:** `ws-*` commands for all workflows
*   **History:** Automatically logged to Obsidian via `livey-log`

### Gleam (Process Monitor)
*   **Integration:** Monitor pane in `monitor` layout
*   **Purpose:** Real-time process/resource monitoring
*   **Close:** Press `q` to exit

### zjstatus Plugin
*   **Location:** `~/.config/zellij/plugins/zjstatus.wasm`
*   **Displays:** Git branch (if available), datetime, session name
*   **Theme:** Kanagawa Wave colors

---

## 🚀 Quick Start Guide

### 1. Daily Development
1.  Run `ws-local`
2.  Code in Neovim
3.  `exit` -> Theme resets, log written to Obsidian

### 2. Security Operation
1.  Run `ws-redteam --container kali`
2.  Hack
3.  `exit` -> Container destroyed, evidence logged

### 3. Deep Writing
1.  Run `ws-write`
2.  Focus (Theme turns to Ice)

### 4. Emergency
1.  Run `ws-kill`
2.  System goes dark and locks

---

## ⚙️ Troubleshooting & Tips

### Common Issues

#### "Session not found" Error
**Solution:** Use `-n` flag for new session with layout. Already configured in ws-local.

#### "Another GleamObserver session is already running"
**Solution:** Close the first one by pressing `q` in the monitor pane, then exit.

#### Zellij Layout Not Loading
**Cause:** Layout path doesn't exist.
**Solution:** Ensure layout files are in `workflow/zellij/layouts/`

### Advanced Tips

#### Clean Up Old Sessions
```bash
zellij delete-all-sessions
zellij delete-session session-name
zellij list-sessions
```

#### View Session Logs
```bash
cat ~/.local/share/livey/logs/sessions.log
tail -f ~/.local/share/livey/logs/sessions.log
```

#### Environment Variable Check
```bash
echo $LIVEY_WORKFLOW
echo $LIVEY_CONTEXT
echo $LIVEY_WORKFLOW_SESSION
```

---

## 📚 File Structure

```
dotfiles/
├── bin/
│   ├── ws-local           # Main entry point for dev workspace
│   ├── ws-write          # Writing workspace (Emacs)
│   ├── ws-redteam        # Security workspace (Tmux + Docker)
│   ├── ws-remote         # Remote workspace (SSH)
│   ├── ws-menu           # Launcher (Rofi)
│   ├── ws-kill           # Emergency shutdown
│   ├── livey-log         # Auto-logging to Obsidian
│   ├── livey-theme       # Theme switcher
│   └── ws-doctor         # Diagnostic tool
│
├── workflow/
│   └── zellij/
│       ├── layouts/
│       │   ├── dev.kdl          # 3-pane: Editor|Files / Shell
│       │   ├── monitor.kdl      # 3-pane: Monitor|Logs / Shell
│       │   ├── write.kdl        # 2-pane: Editor / Reference
│       │   └── fullscreen.kdl   # 1-pane: Full editor
│       └── plugins/
│           └── zjstatus.wasm    # Status bar plugin
│
└── .config/
    ├── zsh/                     # Shell config + aliases
    └── nvim/                    # Neovim config
```

---

**Status:** 🟢 **SYSTEM FULLY OPERATIONAL**

**Last Updated:** 2025-12-18 (Zellij Integration Complete)
