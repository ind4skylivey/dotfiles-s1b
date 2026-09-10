# Tmux Workflow Guide

> **Version:** 1.1  
> **Last updated:** September 2026  
> **Config location:** `~/.config/tmux/tmux.conf`

---

## Table of Contents

- [Introduction](#introduction)
- [Part I: Tutorial](#part-i-tutorial)
  - [1. What is tmux?](#1-what-is-tmux)
  - [2. Core Concepts](#2-core-concepts)
  - [3. The Prefix System](#3-the-prefix-system)
  - [4. Panes](#4-panes)
  - [5. Windows](#5-windows)
  - [6. Copy Mode](#6-copy-mode)
  - [7. Sessions](#7-sessions)
  - [8. Power Tools](#8-power-tools)
  - [9. Plugins](#9-plugins)
  - [10. Theme & Status Bar](#10-theme--status-bar)
- [Part II: Quick Reference](#part-ii-quick-reference)
  - [Global Shortcuts](#global-shortcuts)
  - [Prefix + Key](#prefix--key)
  - [Pane Management](#pane-management)
  - [Window Management](#window-management)
  - [Copy Mode](#copy-mode)
  - [Resize](#resize)
  - [Session & project navigation](#session--project-navigation)
- [Part IIb: Common Workflows](#part-iib-common-workflows)
  - [Workflow 1: Diff & Code Review](#workflow-1-diff--code-review)
  - [Workflow 2: Multi-Pane Code Review](#workflow-2-multi-pane-code-review)
  - [Workflow 3: Code Creation Workspace](#workflow-3-code-creation-workspace)
  - [Workflow 4: Parallel Execution & Session Persistence](#workflow-4-parallel-execution--session-persistence)
- [Part III: Configuration Reference](#part-iii-configuration-reference)
- [Part IV: Tips & Tricks](#part-iv-tips--tricks)

---

## Introduction

This document is a complete guide to the personal tmux setup. It serves two purposes:

1. **Tutorial** — a progressive walkthrough from basic concepts to advanced usage, designed to be read top to bottom.
2. **Quick Reference** — a cheat sheet organized by feature, designed to be scanned when you need a specific shortcut fast.

> **Philosophy:** This is a sober, professional configuration. The default prefix (`Ctrl b`) is replaced with `Ctrl Space` — a key that is easier to reach and rarely conflicts with applications. Navigation between panes is **prefix-free** (`Ctrl h/j/k/l`) and integrates seamlessly with Neovim and Helix via smart detection. The status bar is minimal (Tokyo Night palette), showing only what matters: session name, prefix indicator, CPU load, and the clock. No distractions.

---

## Part I: Tutorial

### 1. What is tmux?

tmux is a terminal multiplexer — a tool that lets you:

- Split your terminal into multiple **panes** within a single window.
- Organize panes into **windows** (like browser tabs).
- Keep **sessions** alive in the background, even after disconnecting.
- Customize everything via a `tmux.conf` file.
- Extend functionality with **plugins** (managed by tpm).

Compared to Zellij, tmux is older, more ubiquitous, and uses a **prefix key** model instead of a modal system. Where Zellij has "modes" you enter and exit, tmux uses a single prefix keystroke (`Ctrl Space` here) followed by a command key. Both approaches are valid; tmux's prefix model is faster for one-shot commands, while Zellij's modal model is nicer for repeated operations.

---

### 2. Core Concepts

```
Session
 └── Window
      ├── Pane
      ├── Pane
      └── Pane (zoomed / fullscreen)
```

| Concept    | Description                                                        |
| ---------- | ------------------------------------------------------------------ |
| **Session** | A persistent tmux instance. Survives terminal disconnects. Multiple sessions can run simultaneously. |
| **Window**  | A container for panes (equivalent to a Zellij "tab"). Each window has its own layout. Switch between windows instantly. |
| **Pane**    | A single terminal surface. Panes can be split, resized, zoomed, swapped, and closed. |
| **Prefix**  | The keystroke that precedes tmux commands (`Ctrl Space` here). Equivalent to Zellij's mode-entry key. |
| **Copy Mode** | A navigation context for scrolling and copying scrollback output. Equivalent to Zellij's scroll mode. |
| **Plugin**  | A script module that adds functionality (clipboard, CPU stats, session save/restore). |

> **Terminology note:** tmux calls them **windows**; Zellij calls them **tabs**. They are the same concept. This guide uses tmux's terminology throughout.

---

### 3. The Prefix System

tmux uses a **prefix key** system. This is the most important concept to understand, and it is the direct counterpart to Zellij's mode system.

#### How it works

1. You press the **prefix** (`Ctrl Space`) and release it.
2. tmux now listens for the next keystroke, which is the command.
3. The command executes immediately — there is no "mode" to exit.
4. If you want to send the prefix itself to a nested tmux session, press `Ctrl Space` **twice**.

#### The prefix

| Setting       | Value           | Notes                                  |
| ------------- | --------------- | -------------------------------------- |
| Prefix key    | `Ctrl Space`    | Replaces the default `Ctrl b`.         |
| Send prefix   | `Prefix` `Prefix` | Sends `Ctrl Space` to a nested session. |

> **Key insight:** `Ctrl Space` is your "escape hatch" into tmux's control layer. Think of it as the modifier that says "this next command is for tmux, not for my app." Unlike Zellij's modes, the prefix is **one-shot** — you press it, then one command key, and you're done.

#### Prefix vs. Zellij modes

| Aspect            | tmux (this config)            | Zellij                          |
| ----------------- | ----------------------------- | ------------------------------- |
| Entry             | `Ctrl Space` (one-shot)       | `Ctrl g` then a mode key        |
| Repeated commands | Press prefix each time        | Stay in a mode, press many keys |
| Exit              | Automatic (no mode to exit)   | `Esc` / `Enter` to return       |
| Global keys       | `Ctrl h/j/k/l`, `Alt+H/J/K/L` | `Alt h/j/k/l`, `Alt +/-`        |

#### Visual flow

```
                    Ctrl Space  (prefix, press & release)
                         |
                         v
              +---------------------+
              |  waiting for command|
              +---------------------+
                         |
    +--------+--------+--+--+--------+--------+--------+
    |        |        |     |        |        |        |
   v        v        v     v        v        v        v
  [|]      [-]      [c]   [r]      [s]      [p]      [t]     [?]
  split    split    new   reload  session  project  floating list
  horiz    vert     win   config  tree     picker   terminal keys

     ...command executes immediately, back to normal...
```

---

### 4. Panes

Panes are the fundamental unit of work in tmux. Each pane runs its own shell (fish, in this config) or application.

#### Creating panes

| Action                | Shortcut            | Notes                              |
| --------------------- | ------------------- | ---------------------------------- |
| Split horizontally    | `Prefix` `|`        | New pane on the right. Inherits cwd. |
| Split vertically      | `Prefix` `-`        | New pane below. Inherits cwd.      |
| New window            | `Prefix` `c`        | Not a pane, but a fresh window. Inherits cwd. |

> **Path inheritance:** All new panes and windows open in the same directory as the current pane (`-c "#{pane_current_path}"`). No need to `cd` after splitting.

#### Navigating between panes

| Action                  | Shortcut                          |
| ----------------------- | --------------------------------- |
| Move focus (no prefix)  | `Ctrl h` / `j` / `k` / `l`        |
| Cycle to next pane      | `Prefix` `o` (default)            |
| Smart vim/helix passthrough | `Ctrl h/j/k/l` auto-detects Neovim/Helix and sends the key to the editor instead of switching panes. |

> These `Ctrl h/j/k/l` keys work **without the prefix**, directly from your shell. When Neovim or Helix is the active pane, the key is forwarded to the editor so its own window splits navigate seamlessly. This is the same idea as the `vim-tmux-navigator` plugin, implemented inline via a shell detection check.

#### Pane operations

| Action                    | Shortcut               | Source  |
| ------------------------- | ---------------------- | ------- |
| Close focused pane        | `Prefix` `x`           | default |
| Toggle zoom (fullscreen)  | `Prefix` `z`           | default |
| Swap pane with previous   | `Prefix` `{`           | default |
| Swap pane with next       | `Prefix` `}`           | default |
| Cycle to next pane        | `Prefix` `o`           | default |
| Cycle pane layouts        | `Prefix` `Space`       | default |

> **Zoom** (`Prefix` `z`) is tmux's equivalent of Zellij's "toggle fullscreen" — it expands the focused pane to fill the window. Press `Prefix` `z` again to restore the layout. This is the cleanest way to focus on one pane without losing the others.

---

### 5. Windows

Windows let you organize different workspaces within a single session. They are tmux's equivalent of Zellij's tabs.

#### Creating and managing windows

| Action                | Shortcut               | Source  |
| --------------------- | ---------------------- | ------- |
| New window            | `Prefix` `c`           | custom (inherits cwd) |
| Rename window         | `Prefix` `,`           | default |
| Close window          | `Prefix` `&`           | default |
| Next window           | `Prefix` `n`           | default |
| Previous window       | `Prefix` `p`           | default |
| List windows          | `Prefix` `w`           | default |

#### Switching windows

| Action                | Shortcut                        |
| --------------------- | ------------------------------- |
| Go to window 1-9      | `Prefix` `1` through `9`        |
| Toggle last window    | `Prefix` `l` (default)          |
| List & pick window    | `Prefix` `w`                    |

> **Auto-renumbering** is enabled (`renumber-windows on`): when you close a window, the remaining windows are renumbered so there are no gaps. Windows are **1-indexed** (`base-index 1`), so `Prefix 1` is your first window — not `Prefix 0`.

---

### 6. Copy Mode

Copy mode is tmux's scrollback navigation context — the equivalent of Zellij's scroll mode. You enter it to scroll through output, search, and copy text.

#### Entering and exiting

| Action              | Shortcut       |
| ------------------- | -------------- |
| Enter copy mode     | `Prefix` `[`   |
| Exit copy mode      | `q` or `Esc`   |

#### Navigating in copy mode

tmux supports two key styles via `mode-keys` (default is `emacs`; `vi` is recommended for vim/helix users — see the tip below).

| Action              | vi keys            | emacs keys (default) |
| ------------------- | ------------------ | -------------------- |
| Move cursor         | `h` `j` `k` `l`    | `Ctrl n/p/f/b`       |
| Page up / down      | `Ctrl u` / `Ctrl d`| `Ctrl v` / `Alt v`   |
| Top / bottom        | `g` / `G`          | `Alt <` / `Alt >`    |
| Search forward      | `/`                | `Ctrl s`             |
| Search backward     | `?`                | `Ctrl r`             |
| Next / prev match   | `n` / `N`          | `Ctrl s` / `Ctrl r`  |
| Begin selection     | `v`                | `Ctrl Space`         |
| Copy selection      | `y` (via tmux-yank) | `Alt w`             |

> **Tip:** This config does **not** set `mode-keys`. The default is `emacs`, but since this is a vim/helix setup, adding `setw -g mode-keys vi` to `tmux.conf` is strongly recommended — it makes copy mode use familiar `h j k l`, `/`, `?`, `v`, and `y` keys. The `y` yank below depends on the **tmux-yank** plugin and works best in vi mode.

#### Copying to the system clipboard

With **tmux-yank** installed, copying to the system clipboard is one key:

| Action                          | Shortcut (vi mode)     |
| ------------------------------- | ---------------------- |
| Copy selection to clipboard     | `y`                    |
| Copy current line to clipboard  | `Y`                    |
| Paste from tmux buffer          | `Prefix` `]`           |

#### Quick copy workflow

```
Prefix [          → enter copy mode
h j k l           → move to start (vi mode)
v                 → begin selection
(move to end)
y                 → copy to system clipboard
q                 → exit copy mode
```

> **Edit scrollback in Neovim (tmux's Zellij equivalent):** tmux has no built-in "edit scrollback" like Zellij's `e` key, but you can capture a pane's output to a file and open it in Neovim: `tmux capture-pane -p -S - > /tmp/output.txt && nvim /tmp/output.txt`. See [Tips & Tricks](#capture-pane-output-to-a-file) for details.

---

### 7. Sessions

Sessions are persistent tmux instances. They survive terminal disconnects, SSH drops, and (with **tmux-resurrect**) even full reboots.

#### Session management (prefix)

| Action                  | Shortcut               | Source  |
| ----------------------- | ---------------------- | ------- |
| Detach from session     | `Prefix` `d`           | default |
| Rename current session  | `Prefix` `$`           | default |
| Session tree (by time)  | `Prefix` `s`           | custom (`choose-tree`) |
| Toggle last session     | `Prefix` `b`           | custom (`switch-client -l`) |
| Fuzzy switch by name    | `Prefix` `f`           | custom (fzf popup) |
| sesh launcher + preview | `Prefix` `T`           | custom (needs `sesh` in PATH) |
| Project picker          | `Prefix` `p`           | custom (fixed list + browse `Repos/`) |
| Jump Yamaha master      | `Prefix` `M`           | custom (sessionizer) |
| Jump Yamaha L12         | `Prefix` `L`           | custom (sessionizer) |
| Jump `~/.config`        | `Prefix` `C`           | custom (sessionizer) |

#### Working with sessions from the command line

```bash
# Start a new session
tmux

# Start a named session
tmux new -s myproject

# List all sessions
tmux ls

# Attach to an existing session
tmux attach -t myproject

# Attach to the most recent session
tmux attach

# Switch to a session from inside tmux
tmux switch -t myproject

# Kill a specific session
tmux kill-session -t myproject

# Kill all sessions (the whole server)
tmux kill-server
```

#### Session persistence (tmux-resurrect)

The **tmux-resurrect** plugin saves and restores the exact window/pane layout, including working directories:

| Action              | Shortcut          |
| ------------------- | ----------------- |
| Save session layout  | `Prefix` `Ctrl s` |
| Restore session      | `Prefix` `Ctrl r` |

> **Note:** `tmux-resurrect` restores **layout and directories**, but by default does **not** restore running processes (e.g. a running server). This differs from Zellij's serialization, which can capture more state. See [Workflow 4](#workflow-4-parallel-execution--session-persistence) for the full save/restore workflow.

---

### 8. Power Tools

Session navigation, project jumps under `shenanigans`, and popups beyond standard tmux.

#### Atajos (resumen)

| Shortcut | Action | Description |
| -------- | ------ | ----------- |
| `Prefix` `s` | Session tree | `choose-tree` sorted by **last used** (recent sessions on top). |
| `Prefix` `b` | Last session | Toggle between the last two sessions (like `cd -`). |
| `Prefix` `f` | Fuzzy sessions | fzf popup by session **name** (old `Prefix s` behavior). |
| `Prefix` `T` | sesh | Unified launcher: tmux, zoxide, configs, preview, kill. See [docs/sesh.md](sesh.md). |
| `Prefix` `p` | Projects | Fixed paths from `projects.list` or browse `shenanigans/Repos/`. |
| `Prefix` `M` | Yamaha master | Sessionizer → `yamaha-backoffice`. |
| `Prefix` `L` | Yamaha L12 | Sessionizer → `yamaha-backoffice-l12`. |
| `Prefix` `C` | Config | Sessionizer → `~/.config`. |
| `Prefix` `t` | Floating terminal | 80% × 80% fish popup. |
| `Ctrl g` | AI chat | OpenCode via `~/scripts/chat-popup.sh` (no prefix). |

> **Nota:** `Prefix p` reemplaza el atajo por defecto *previous window*. Para ventanas usá `Prefix n` / `Prefix w`.  
> `Prefix y` / `Prefix Y` siguen reservados para **tmux-yank** en copy mode.

#### Session tree (`Prefix` `s`)

- Native tmux UI; sessions ordered by **time**, not alphabetically.
- Navigate with arrows; `Enter` to attach; `d` or `x` to kill (tree mode).

#### Toggle last session (`Prefix` `b`)

- Jump back to the previous tmux session without a menu.
- Handy when alternating Yamaha master ↔ L12.

#### Project picker (`Prefix` `p`)

1. **Lista fija** — entries in `~/.config/tmux/projects.list` (`name|/absolute/path`).
2. **Browse Repos** — `find` under `/media/il1v3y/HD2/HDfiles/shenanigans/Repos` (depth 3).

Both call `scripts/sessionizer.sh`: create detached session named from directory basename if missing, then `switch-client`.

#### Sessionizer quick jumps (`Prefix` `M` / `L` / `C`)

One-key jumps to frequent paths (defined after tpm so they do not clash with plugins).

#### sesh (`Prefix` `T`)

Requires `~/.local/bin/sesh` on PATH. Inside the menu: `Ctrl+a/t/g/x/f/d` for filters; preview pane on the right.

#### Floating Terminal (`Prefix` `t`)

- A quick-access fish shell in an 80% × 80% popup.
- Close it with `q`, `exit`, or by ending the fish session.
- Opens in the current working directory — the equivalent of Zellij's floating panes, but as a transient popup.

#### AI Chat Popup (`Ctrl g`)

- A global hotkey (no prefix) that opens an 80% × 80% popup with `~/scripts/chat-popup.sh`.
- Conversational interface to opencode.

##### AI Chat commands

Inside the AI Chat popup, these commands are available:

| Command            | Action                              |
| ------------------ | ----------------------------------- |
| `/h`               | Show help menu                      |
| `/c`               | Copy last AI response to clipboard  |
| `/n`               | Start new conversation (clears history) |
| `/m`               | List available models               |
| `/m provider/model`| Switch to a specific model          |
| `/e`               | Export conversation to markdown     |
| `/s`               | Show token usage stats              |
| `/history`         | Show conversation history           |
| `/q`               | Quit the chat popup                 |

> **Workflow:** Type a message and press `Enter`. After the first response, subsequent messages continue the same conversation.

---

### 9. Plugins

Plugins are managed by **tpm** (Tmux Plugin Manager). The active plugin directory is `~/.tmux/plugins/` (set via `TMUX_PLUGIN_MANAGER_PATH`).

#### Installed (active) plugins

| Plugin               | Purpose                                      | Keybindings                                  |
| -------------------- | -------------------------------------------- | -------------------------------------------- |
| **tpm**              | Plugin manager.                              | `Prefix` `I` install, `Prefix` `U` update, `Prefix` `alt-u` clean. |
| **tmux-yank**        | Copy to system clipboard from copy mode.     | `y` copy selection, `Y` copy line (vi copy mode). |
| **tmux-cpu**         | CPU percentage interpolation for status bar. | Automatic — provides `#{cpu_percentage}` shown in status-right. |
| **tmux-resurrect**   | Save / restore session layouts.              | `Prefix` `Ctrl s` save, `Prefix` `Ctrl r` restore. |

#### tpm commands

| Shortcut            | Action                              |
| ------------------- | ----------------------------------- |
| `Prefix` `I`        | Install all plugins declared in `tmux.conf` |
| `Prefix` `U`        | Update all installed plugins        |
| `Prefix` `alt-u`    | Uninstall a plugin (remove not listed in config) |

> **Gotcha — two plugin directories:** There is a stale `~/.config/tmux/plugins/` directory containing orphan plugins (`catppuccin-tmux`, `tmux-sensible`, `vim-tmux-navigator`) that are **not** loaded by the config (they are not in any `@plugin` line). The config implements vim/helix navigation inline instead of using `vim-tmux-navigator`. The `~/.config/tmux/plugins/` directory is safe to remove to avoid confusion — the active plugins live in `~/.tmux/plugins/`.

---

### 10. Theme & Status Bar

The configuration uses the **Tokyo Night** color palette — a sober, high-contrast, low-noise theme.

#### Status bar layout

```
┌──────────────────────────────────────────────────────────────────┐
│  #S (session, blue) │ ... 1:edit  2:tests  3:server │ CPU:42% │ 14:30 │
└──────────────────────────────────────────────────────────────────┘
   status-left                window-status                status-right
```

- **Position:** bottom.
- **Background:** transparent (`bg=default`) — blends with your terminal.
- **Left:** session name (blue, bold) when idle; `PREFIX` (red, bold) when the prefix is active. Separated by `│`.
- **Right:** `CPU:<percent>` (blue, bold) from tmux-cpu, then `│`, then the time (`%H:%M`).
- **Windows:** `#I:#W` format (index:name). Inactive = gray, active = gold bold. Two-space separator.

#### Tokyo Night color palette

| Element            | Color | Hex       |
| ------------------ | ----- | --------- |
| Active window      | Gold  | `#e0af68` |
| Inactive windows   | Gray  | `#565f89` |
| Prefix indicator   | Red   | `#f7768e` |
| Session name       | Blue  | `#7aa2f7` |
| Status bar text    | Light | `#a9b1d6` |
| Active pane border | Blue  | `#7aa2f7` |
| Inactive border    | Dark  | `#414868` |

#### Pane borders

| Setting                  | Value (hex)  | Meaning                |
| ------------------------ | ------------ | ---------------------- |
| `pane-border-style`      | `#414868`    | Inactive pane borders. |
| `pane-active-border-style` | `#7aa2f7`  | Focused pane border (blue). |

> **Tip:** The prefix indicator in the status bar turns red and shows `PREFIX` whenever you press `Ctrl Space`, so you always know when tmux is listening for a command.

---

## Part II: Quick Reference

### Global Shortcuts

These work **without the prefix**, directly from any pane.

| Shortcut       | Action                              |
| -------------- | ----------------------------------- |
| `Ctrl h`       | Move focus left (or send to vim/helix) |
| `Ctrl j`       | Move focus down (or send to vim/helix) |
| `Ctrl k`       | Move focus up (or send to vim/helix) |
| `Ctrl l`       | Move focus right (or send to vim/helix) |
| `Alt H`        | Resize pane left by 2 cells         |
| `Alt J`        | Resize pane down by 2 cells         |
| `Alt K`        | Resize pane up by 2 cells           |
| `Alt L`        | Resize pane right by 2 cells        |
| `Ctrl g`       | Open AI Chat popup (opencode)       |
| `Ctrl Space`   | The prefix — precedes all tmux commands |

---

### Prefix + Key

All of these require pressing `Ctrl Space` first, then the key.

| Shortcut            | Action                              | Source  |
| ------------------- | ----------------------------------- | ------- |
| `Prefix` `|`        | Split pane horizontally (right)     | custom  |
| `Prefix` `-`        | Split pane vertically (down)        | custom  |
| `Prefix` `c`        | New window (inherits cwd)           | custom  |
| `Prefix` `r`        | Reload tmux config                  | custom  |
| `Prefix` `s`        | Session tree (by time)              | custom  |
| `Prefix` `b`        | Toggle last session                 | custom  |
| `Prefix` `f`        | Fuzzy session switch (name)         | custom  |
| `Prefix` `p`        | Project picker (shenanigans)        | custom  |
| `Prefix` `M`        | Jump Yamaha master                  | custom  |
| `Prefix` `L`        | Jump Yamaha L12                     | custom  |
| `Prefix` `C`        | Jump `~/.config`                    | custom  |
| `Prefix` `T`        | sesh launcher                       | custom  |
| `Prefix` `t`        | Floating terminal popup             | custom  |
| `Prefix` `Space`    | Send prefix to nested session       | custom  |

---

### Pane Management

| Shortcut            | Action                              | Source  |
| ------------------- | ----------------------------------- | ------- |
| `Prefix` `|`        | Split right                         | custom  |
| `Prefix` `-`        | Split down                          | custom  |
| `Prefix` `x`        | Close focused pane                  | default |
| `Prefix` `z`        | Toggle zoom (fullscreen)            | default |
| `Prefix` `o`        | Cycle to next pane                  | default |
| `Prefix` `{`        | Swap with previous pane             | default |
| `Prefix` `}`        | Swap with next pane                 | default |
| `Prefix` `Space`    | Cycle pane layouts                  | default |
| `Ctrl h/j/k/l`      | Move focus (no prefix, smart vim)   | custom  |

---

### Window Management

| Shortcut            | Action                              | Source  |
| ------------------- | ----------------------------------- | ------- |
| `Prefix` `c`        | New window                          | custom  |
| `Prefix` `,`        | Rename window                       | default |
| `Prefix` `&`        | Close window                        | default |
| `Prefix` `n`        | Next window                         | default |
| `Prefix` `p`        | **Project picker** (not prev window)| custom  |
| `Prefix` `l`        | Toggle last window                  | default |
| `Prefix` `1`-`9`    | Go to window 1-9                    | default |
| `Prefix` `w`        | List / pick window                  | default |

---

### Copy Mode

**Enter:** `Prefix` `[`  
**Exit:** `q` or `Esc`

| Key (vi mode)      | Action                              |
| ------------------ | ----------------------------------- |
| `h` `j` `k` `l`    | Move cursor                         |
| `Ctrl u` / `Ctrl d`| Half page up / down                 |
| `Ctrl b` / `Ctrl f`| Full page up / down                 |
| `g` / `G`          | Top / bottom                        |
| `/`                | Search forward                      |
| `?`                | Search backward                     |
| `n` / `N`          | Next / previous match               |
| `v`                | Begin selection                     |
| `y`                | Copy selection to clipboard (tmux-yank) |
| `Y`                | Copy current line to clipboard      |
| `Prefix` `]`       | Paste from tmux buffer              |

> **Requires `setw -g mode-keys vi`** for the vi keys above. Without it, tmux uses emacs-style bindings by default. See [Tips & Tricks](#enable-vi-copy-mode).

---

### Resize

These work **without the prefix** — hold `Alt` + `Shift` + direction.

| Shortcut       | Action                        |
| -------------- | ----------------------------- |
| `Alt H`        | Shrink left by 2 cells        |
| `Alt J`        | Shrink down by 2 cells        |
| `Alt K`        | Shrink up by 2 cells          |
| `Alt L`        | Shrink right by 2 cells       |

> **Mnemonic:** `H J K L` = left/down/up/right (Vim-style), with `Alt` + `Shift`. Tap repeatedly — each tap moves 2 cells.

---

### Session & project navigation

| Shortcut            | Action                              | Source  |
| ------------------- | ----------------------------------- | ------- |
| `Prefix` `d`        | Detach from session                 | default |
| `Prefix` `$`        | Rename current session              | default |
| `Prefix` `s`        | Session tree (sorted by time)      | custom  |
| `Prefix` `b`        | Toggle last session                 | custom  |
| `Prefix` `f`        | Fuzzy switch by session name        | custom  |
| `Prefix` `T`        | sesh launcher + preview             | custom  |
| `Prefix` `p`        | Project picker                      | custom  |
| `Prefix` `M`        | Yamaha master (sessionizer)         | custom  |
| `Prefix` `L`        | Yamaha L12 (sessionizer)           | custom  |
| `Prefix` `C`        | `~/.config` (sessionizer)           | custom  |
| `Prefix` `Ctrl s`   | Save session layout (tmux-resurrect)| plugin  |
| `Prefix` `Ctrl r`   | Restore session layout (tmux-resurrect) | plugin |

**Command-line:**

```bash
tmux new -s name        # new named session
tmux ls                 # list sessions
tmux attach -t name     # attach to session
tmux kill-session -t n  # kill a session
tmux kill-server        # kill all sessions
```

---

## Part IIb: Common Workflows

> This section organizes shortcuts by **task** rather than by feature. When you're working, you think "I want to review this diff" — not "I want to use copy mode." These workflows bridge that gap.

---

### Workflow 1: Diff & Code Review

**Scenario:** You ran `git diff`, `git log`, or a test suite and need to read through the output carefully.

#### Step 1: Enter copy mode

```
Prefix [
```

Now you can navigate the output freely (vi mode recommended):

| Key            | Action                              |
| -------------- | ----------------------------------- |
| `j` / `k`      | Move down / up (line by line)       |
| `Ctrl d` / `Ctrl u` | Half page down / up           |
| `Ctrl f` / `Ctrl b` | Full page down / up           |
| `g` / `G`      | Jump to top / bottom                |

#### Step 2 (optional): Search within the output

```
/               → search forward
?               → search backward
(type your term)
Enter           → confirm search
n / N           → next / previous match
```

#### Step 3: Copy output to the clipboard

```
v               → begin selection
(move to end of the text)
y               → yank to system clipboard (tmux-yank)
q               → exit copy mode
```

#### Step 4 (powerful): Capture full output to a file

To edit or save the entire scrollback (the tmux equivalent of Zellij's "edit scrollback in nvim"):

```bash
tmux capture-pane -p -S - > /tmp/output.txt
nvim /tmp/output.txt
```

From Neovim you can search with regex, copy multiple lines, or save the output.

#### Quick reference for this workflow

```
Prefix [         → copy mode
j / k            → line scroll
Ctrl d / Ctrl u  → half page
Ctrl f / Ctrl b  → full page
/ or ?           → search
v then y         → select & copy to clipboard
q                → exit copy mode
capture-pane -p -S - > file   → dump scrollback to a file
```

---

### Workflow 2: Multi-Pane Code Review

**Scenario:** You want to see two files side by side, or compare command output with source code.

#### Step 1: Split the pane

```
Prefix |         → new pane on the right
Prefix -         → new pane below
```

Both inherit the current working directory.

#### Step 2: Navigate between panes

```
Ctrl h           → focus left pane
Ctrl l           → focus right pane
Ctrl j           → focus pane below
Ctrl k           → focus pane above
```

> These work **without the prefix** — directly from your shell. If Neovim/Helix is focused, the key is forwarded to the editor so its splits navigate seamlessly.

#### Step 3: Resize panes

From any pane, no prefix needed:

```
Alt H            → shrink left
Alt J            → shrink down
Alt K            → shrink up
Alt L            → shrink right
```

Each tap moves 2 cells. Hold `Alt` + `Shift` and tap repeatedly.

#### Step 4: Fullscreen a pane temporarily

```
Prefix z         → toggle zoom (fullscreen) on focused pane
Prefix z         → toggle again to restore the layout
```

Useful when you need to focus on one pane without losing the others.

#### Quick reference for this workflow

```
Prefix |         → split right
Prefix -         → split down
Ctrl h/j/k/l     → move between panes (smart vim)
Alt H/J/K/L      → resize (no prefix, 2 cells)
Prefix z         → toggle zoom / fullscreen
```

---

### Workflow 3: Code Creation Workspace

**Scenario:** You're writing code and need a main editor window plus scratch/reference windows.

#### Step 1: Set up your workspace with windows

```
Prefix c         → new window
Prefix ,         → rename window (e.g. "editor", "tests", "server")
Prefix 1-9       → jump to window N
```

> Windows are **1-indexed** and auto-renumber on close, so there are never gaps.

#### Step 2: Use the floating terminal as scratch space

```
Prefix t         → open an 80% × 80% fish popup
```

The popup is a transient scratch shell — run a quick command, check a man page, or test a snippet without disturbing your layout. Close it with `exit` or `q`.

#### Step 3: Swap panes around

```
Prefix {         → swap with previous pane
Prefix }         → swap with next pane
Prefix o         → cycle to next pane
Prefix Space     → cycle through built-in layouts
```

`Prefix Space` rotates tmux's layout algorithms (even-horizontal, even-vertical, main-horizontal, etc.) — useful to quickly re-arrange panes.

#### Step 4: Reorganize windows

```
Prefix ,         → rename window
Prefix &         → close window
Prefix n / p     → next / previous window
Prefix w         → list & pick window
```

#### Quick reference for this workflow

```
Prefix c         → new window
Prefix ,         → rename window
Prefix t         → floating terminal (scratch)
Prefix { / }     → swap panes
Prefix Space     → cycle layouts
Prefix 1-9       → jump to window
Prefix w         → list windows
```

---

### Workflow 4: Parallel Execution & Session Persistence

**Scenario:** You need to run the same command across multiple panes, and/or you want your full layout to survive a reboot.

#### Part A — Parallel execution with synchronize-panes

tmux has a built-in **synchronize-panes** window option (not bound to a key in this config, but available on demand):

1. Create your panes:

```
Prefix |     → split right (repeat as needed)
Prefix -     → split down
Ctrl h/j/k/l → navigate between them
```

2. Enable sync via the command prompt:

```
Prefix :                    → open tmux command prompt
setw synchronize-panes on   → every key now goes to ALL panes
```

3. Run your commands — they are sent to **every** pane simultaneously.

4. Disable sync:

```
Prefix :
setw synchronize-panes off
```

> **Use cases:**
> - Running the same command on multiple servers via SSH.
> - Running tests in parallel across multiple services.
> - Updating multiple git repositories simultaneously.
> - Deploying to multiple environments.

> **Tip:** To toggle sync without typing, add a keybind to `tmux.conf`:
> `bind S setw synchronize-panes \; display "Sync: #{?pane_synchronized,ON,OFF}"`
> (This is a **suggestion**, not part of the current config.)

#### Part B — Session persistence with tmux-resurrect

1. Save your current layout:

```
Prefix Ctrl s    → save windows, panes, and working directories
```

2. Kill tmux, close your terminal, or reboot.

3. Restore on next start:

```
tmux new -s myproject
Prefix Ctrl r    → restore the exact layout
```

> **Limitation:** `tmux-resurrect` restores **layout and directories**, not running processes by default. A long-running server will not be restarted automatically (configurable via resurrect strategies, not enabled here).

#### Quick reference for this workflow

```
# Parallel execution
Prefix :                          → command prompt
setw synchronize-panes on/off     → toggle input sync to all panes

# Session persistence
Prefix Ctrl s                     → save layout
Prefix Ctrl r                     → restore layout
```

---

## Part III: Configuration Reference

### File structure

```
~/.config/tmux/
├── tmux.conf                # Main configuration
├── projects.list            # Fixed project paths (name|path)
├── scripts/
│   ├── sessionizer.sh       # Create/switch session for a directory
│   ├── projects-menu.sh     # Prefix p — list + browse Repos/
│   └── sesh-picker.sh       # Prefix T — sesh + fzf-tmux
├── docs/
│   ├── guide.md             # This file
│   └── sesh.md              # sesh install & menu keys
└── plugins/                 # STALE — orphan plugins, not loaded
    ├── catppuccin-tmux/     #   (not in @plugin list)
    ├── tmux-sensible/       #   (not in @plugin list)
    └── vim-tmux-navigator/  #   (navigation implemented inline instead)

~/.tmux/
└── plugins/                 # ACTIVE — loaded by tpm
    ├── tpm/                 # Plugin manager
    ├── tmux-yank/           # Clipboard integration
    ├── tmux-cpu/            # CPU% for status bar
    └── tmux-resurrect/      # Session save/restore

~/scripts/
└── chat-popup.sh            # AI chat popup script (called by Ctrl g)
```

> **Note:** The active plugin directory is `~/.tmux/plugins/` (set by `TMUX_PLUGIN_MANAGER_PATH`). The `~/.config/tmux/plugins/` directory is a leftover and is **not** used by the running config.

### Key configuration values

| Setting                  | Value              | Description                                    |
| ------------------------ | ------------------ | ---------------------------------------------- |
| `prefix`                 | `Ctrl Space`       | Replaces default `Ctrl b`.                    |
| `default-shell`          | `/usr/bin/fish`    | fish as the default shell in all panes.        |
| `default-terminal`       | `tmux-256color`    | Full 256-color + true color (`RGB` override).  |
| `escape-time`            | `0`                | Instant escape — essential for Vim/Helix.      |
| `focus-events`           | `on`               | Pass focus events to applications.             |
| `history-limit`          | `50000`            | 50,000 lines of scrollback per pane.           |
| `detach-on-destroy`      | `off`              | Don't detach when a session is destroyed.      |
| `base-index`             | `1`                | Windows numbered from 1 (not 0).               |
| `pane-base-index`        | `1`                | Panes numbered from 1.                         |
| `renumber-windows`       | `on`               | Auto-renumber windows on close (no gaps).      |
| `mouse`                  | `on`               | Mouse support (click panes, scroll, resize).   |
| `status-position`        | `bottom`           | Status bar at the bottom.                      |

### Plugin declarations

```bash
set -g @plugin 'tmux-plugins/tpm'            # Plugin manager
set -g @plugin 'tmux-plugins/tmux-yank'      # System clipboard copy
set -g @plugin 'tmux-plugins/tmux-cpu'       # CPU% interpolation
set -g @plugin 'tmux-plugins/tmux-resurrect' # Session save/restore

run '~/.tmux/plugins/tpm/tpm'                # Initialize tpm
```

### Status bar configuration

| Option                       | Value                                              |
| ---------------------------- | -------------------------------------------------- |
| `status-position`            | `bottom`                                           |
| `status-style`               | `bg=default fg=#a9b1d6` (transparent background)   |
| `status-left`                | Session name (blue) or `PREFIX` (red) + separator  |
| `status-right`               | `CPU:#{cpu_percentage}` (blue) + separator + `%H:%M` |
| `window-status-format`       | `#I:#W` (gray)                                     |
| `window-status-current-format` | `#I:#W` (gold, bold)                             |
| `window-status-separator`    | `"  "` (two spaces)                                |
| `pane-border-style`          | `fg=#414868` (inactive)                            |
| `pane-active-border-style`   | `fg=#7aa2f7` (active, blue)                        |

### Vim/Helix smart navigation

The config implements seamless pane/editor navigation inline (instead of using the `vim-tmux-navigator` plugin):

```bash
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
  | grep -iqE '^[^TXZ ]+ +(\S+\/)?g?(view|l?n?vim?x?|helix|hx)(diff)?$'"

bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
```

When the focused pane is running Neovim or Helix, `Ctrl h/j/k/l` is forwarded to the editor. Otherwise, it switches tmux panes. No prefix needed.

---

## Part IV: Tips & Tricks

### The only shortcut you need to remember

```
Prefix ?
```

This lists **every keybinding** tmux knows about (built-in + custom + plugin). If you forget a shortcut, press `Ctrl Space` then `?` to see them all. Press `q` to exit the list.

### Enable vi copy mode

This config does not set `mode-keys`, so copy mode defaults to emacs bindings. For a vim/helix workflow, add this line to `tmux.conf`:

```bash
setw -g mode-keys vi
```

Then reload with `Prefix` `r`. After that, copy mode uses `h j k l`, `/`, `?`, `v`, and `y` — matching the [Copy Mode](#copy-mode) table above.

### Copy text to the system clipboard

1. Enter copy mode: `Prefix` `[`.
2. Move to the start (vi: `h j k l`).
3. Begin selection: `v`.
4. Move to the end.
5. Press `y` to yank to the system clipboard (tmux-yank).
6. Paste anywhere with your OS paste, or `Prefix` `]` inside tmux.

### Capture pane output to a file

The tmux equivalent of Zellij's "edit scrollback in nvim":

```bash
# Capture the entire scrollback of the current pane to a file
tmux capture-pane -p -S - > /tmp/output.txt

# Open it in Neovim to search, copy, or save
nvim /tmp/output.txt
```

- `-p` prints to stdout (instead of a tmux buffer).
- `-S -` captures from the start of scrollback (use `-S -100` for the last 100 lines).

### Reload the configuration

```
Prefix r         → reload tmux.conf, shows "Config Reloaded"
```

Use this after editing `~/.config/tmux/tmux.conf`.

### Floating terminal as scratch space

```
Prefix t         → open an 80% × 80% fish popup
```

A transient scratch shell for quick commands, man pages, or calculations — without disturbing your layout. Close it with `exit` or `q`.

### AI chat on demand

```
Ctrl g           → open the AI chat popup (no prefix needed)
```

Inside: type a message + `Enter` to chat with opencode. Use `/h` for help, `/m` to switch models, `/e` to export, `/q` to quit. See [AI Chat commands](#ai-chat-commands).

### Jump to a repo under shenanigans

```
Prefix M         → yamaha-backoffice (master)
Prefix L         → yamaha-backoffice-l12
Prefix C         → ~/.config
Prefix p         → menu: projects.list or browse Repos/
Prefix b         → back to previous tmux session
```

Edit `~/.config/tmux/projects.list` to add lines: `short-name|/absolute/path`.

### Save and restore your session

```
Prefix Ctrl s    → save current layout (windows, panes, directories)
Prefix Ctrl r    → restore the saved layout
```

Useful before a reboot or when closing your terminal. Note: running processes are not restored by default.

### Nested tmux (tmux inside tmux)

- The inner prefix is reached by sending the prefix through: `Prefix` `Prefix` (i.e. `Ctrl Space` twice) sends `Ctrl Space` to the inner session.
- To detach the inner session: `Prefix` `d` (acts on the innermost).
- To leave cleanly: `exit` or `tmux kill-session` in the inner session.

### Smart vim/helix navigation

`Ctrl h/j/k/l` is context-aware:

- If the focused pane runs **Neovim or Helix**, the key is forwarded to the editor (so its internal window splits navigate).
- Otherwise, it switches the **tmux pane** in that direction.

> If your navigation keys seem to do nothing, you may be in an editor's insert mode — exit insert mode first, then `Ctrl h/j/k/l`.

### Parallel execution on demand

tmux can mirror input to all panes in a window via `synchronize-panes` (built-in, not bound to a key here):

```
Prefix :                         → open command prompt
setw synchronize-panes on        → input goes to ALL panes
(run your commands)
setw synchronize-panes off       → disable sync
```

See [Workflow 4](#workflow-4-parallel-execution--session-persistence) for the full workflow.

### Clean up the orphan plugins directory

The directory `~/.config/tmux/plugins/` contains plugins (`catppuccin-tmux`, `tmux-sensible`, `vim-tmux-navigator`) that are **not** loaded by the config. They are leftovers and can be safely removed:

```bash
rm -rf ~/.config/tmux/plugins
```

The active plugins live in `~/.tmux/plugins/` and are unaffected.

---

## Appendix: Prefix Command Map

```
                         Ctrl Space  (prefix — press & release)
                              │
                              ▼
                    ┌─────────────────────┐
                    │  tmux listens for   │
                    │   one command key   │
                    └─────────────────────┘
                              │
   ┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
   │        │        │        │        │        │        │        │        │
   ▼        ▼        ▼        ▼        ▼        ▼        ▼        ▼        ▼
  [|]      [-]      [c]      [r]      [s]      [b]      [p]      [t]      [?]
 split    split    new      reload   session  last     project  float    list
 right    down     window   config   tree     session  picker   term     keys
   │        │        │                 │        │        │
   │        │        │                 │        │        ├── [f] fzf sessions
   │        │        │                 │        │        ├── [T] sesh
   │        │        │                 │        │        ├── [M/L/C] yamaha / config
   │        │        │  ...also default commands (no mode to exit)...
   │        │        │
   │        │        ├── [x] close pane     [z] zoom    [o] cycle pane
   │        │        ├── [,] rename window  [&] close   [n] next window
   │        │        ├── [1-9] go to window [w] list    [l] last window
   │        │        ├── [{]/[}] swap panes  [Space] cycle layouts
   │        │        ├── [d] detach          [$] rename session
   │        │        ├── [ Ctrl s ] save     [ Ctrl r ] restore  (resurrect)
   │        │        ├── [ I ] install       [ U ] update        (tpm)
   │        │        └── [ [ ] copy mode  ──►  (vi keys: h j k l / ? v y)
   │          │
   └──────────┴──────────┘
                              │
                              ▼
                   command runs once, back to normal
                   (no explicit exit needed)


   GLOBAL (no prefix):
     Ctrl h/j/k/l  ─► smart pane move (or forward to vim/helix)
     Alt  H/J/K/L  ─► resize pane (2 cells)
     Ctrl g        ─► AI chat popup (opencode)
```

---

> **End of guide.** For the source configuration, see `~/.config/tmux/tmux.conf`.  
> For the AI chat script, see `~/scripts/chat-popup.sh`.  
> For active plugins, see `~/.tmux/plugins/`.  
>  
> Remember: **`Prefix ?`** lists every keybinding. Everything else you can look up.
