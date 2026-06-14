# Kitty God Mode Configuration - Cheat Sheet

> **Power User Terminal - Security Research Edition**  
> Optimized for bash workflows with DWM compatibility

---

## Table of Contents

- [Quick Start](#quick-start)
- [Hints System (Text Detection)](#hints-system-text-detection)
- [Tab Management](#tab-management)
- [Window Navigation](#window-navigation)
- [Scrolling](#scrolling)
- [Kittens (Power Tools)](#kittens-power-tools)
- [Development Shortcuts](#development-shortcuts)
- [System Monitoring](#system-monitoring)
- [Git Workflows](#git-workflows)
- [Docker/Containers](#dockercontainers)
- [File Management](#file-management)
- [Configuration](#configuration)

---

## Quick Start

### Most Used Shortcuts

| Action | Keybinding | Description |
|--------|------------|-------------|
| **Open URL** | `Ctrl+Shift+U` | Detect and open URLs in browser |
| **Copy IP** | `Ctrl+Shift+I` | Detect and copy IP addresses |
| **Open File** | `Ctrl+Shift+P` | Detect and open file paths in nvim |
| **Git Show** | `Ctrl+Shift+G` | Detect git hashes and show commits |
| **New Tab** | `Ctrl+Shift+T` | Create new tab with current directory |
| **Close Tab** | `Ctrl+Shift+W` | Close current tab |
| **Next Tab** | `Ctrl+Shift+L` | Go to next tab |
| **Prev Tab** | `Ctrl+Shift+H` | Go to previous tab |
| **Tab 1-9** | `Alt+1` to `Alt+9` | Jump directly to tab (DWM-safe) |

---

## Hints System (Text Detection)

The hints system allows you to quickly detect and interact with text patterns in the terminal.

### How to Use Hints

1. Press the hint keybinding (e.g., `Ctrl+Shift+U` for URLs)
2. Kitty highlights all matching patterns with letters (a, b, c...)
3. Press the highlighted letter to perform the action

### Available Hints

| Keybinding | Pattern | Action | Example |
|------------|---------|--------|---------|
| `Ctrl+Shift+U` | **URLs** | Open in browser | `https://example.com` |
| `Ctrl+Shift+I` | **IP Addresses** | Copy to clipboard | `192.168.1.1` |
| `Ctrl+Shift+P` | **File Paths** | Open in nvim | `/home/user/file.txt` |
| `Ctrl+Shift+G` | **Git Hashes** | Show commit | `a1b2c3d` |
| `Ctrl+Shift+E` | **Emails** | Copy to clipboard | `user@example.com` |
| `Ctrl+Shift+X` | **UUIDs** | Copy to clipboard | `550e8400-e29b-41d4-a716-446655440000` |
| `Ctrl+Shift+M` | **MAC Addresses** | Copy to clipboard | `00:1B:44:11:3A:B7` |
| `Ctrl+Shift+D` | **Container IDs** | Show docker logs | `a1b2c3d4e5f6` |
| `Ctrl+Shift+L` | **Lines** | Copy line content | Any line |
| `Ctrl+Shift+W` | **Words** | Copy word | Any word |
| `Ctrl+Shift+H` | **Hashes** | Copy hash | MD5/SHA checksums |

### Pro Tips

- **URLs**: Works with http, https, ftp, file, ssh, sftp, git, and more
- **Paths**: Absolute (`/home/...`) and relative (`./file`) paths
- **Git Hashes**: Both short (7 chars) and full (40 chars) SHA hashes
- **Container IDs**: Automatically runs `docker logs -f` on selected container

---

## Tab Management

### Basic Tab Operations

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+T` | New Tab | Create tab with current working directory |
| `Ctrl+Shift+W` | Close Tab | Close current tab |
| `Ctrl+Shift+L` | Next Tab | Switch to next tab |
| `Ctrl+Shift+H` | Previous Tab | Switch to previous tab |
| `Ctrl+Shift+R` | Rename Tab | Set custom tab title |

### Quick Tab Navigation (DWM-Safe)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Alt+1` | Tab 1 | Jump to first tab |
| `Alt+2` | Tab 2 | Jump to second tab |
| `Alt+3` | Tab 3 | Jump to third tab |
| `Alt+4` | Tab 4 | Jump to fourth tab |
| `Alt+5` | Tab 5 | Jump to fifth tab |
| `Alt+6` | Tab 6 | Jump to sixth tab |
| `Alt+7` | Tab 7 | Jump to seventh tab |
| `Alt+8` | Tab 8 | Jump to eighth tab |
| `Alt+9` | Tab 9 | Jump to ninth tab |

**Note**: Uses `Alt` instead of `Super` to avoid conflicts with DWM workspaces.

---

## Window Navigation

### Window Movement

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Left` | Left Window | Move to window on the left |
| `Ctrl+Right` | Right Window | Move to window on the right |
| `Ctrl+Up` | Up Window | Move to window above |
| `Ctrl+Down` | Down Window | Move to window below |

### Layout Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+Z` | Toggle Stack | Switch to stack layout |
| `Ctrl+Shift+Space` | Toggle Horizontal | Switch to horizontal layout |
| `Ctrl+Shift+O` | Toggle Vertical | Switch to vertical layout |

### Window Splitting

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+H` | Split Horizontal | Split window horizontally |
| `Ctrl+Alt+V` | Split Vertical | Split window vertically |

---

## Scrolling

### Scroll Navigation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+Up` | Page Up | Scroll up one page |
| `Ctrl+Shift+Down` | Page Down | Scroll down one page |
| `Ctrl+Shift+Home` | Scroll Home | Jump to top of buffer |
| `Ctrl+Shift+End` | Scroll End | Jump to bottom of buffer |
| `Ctrl+Shift+G` | Show Scrollback | Enter scrollback mode |

### Vim-Style Scrolling

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+K` | Line Up | Scroll up one line |
| `Ctrl+Shift+J` | Line Down | Scroll down one line |
| `Ctrl+Shift+[` | Page Up | Alternative page up |
| `Ctrl+Shift+]` | Page Down | Alternative page down |

### Scrollback Mode

When in scrollback (`Ctrl+Shift+G`):
- `/` - Search forward
- `?` - Search backward
- `n` - Next match
- `N` - Previous match
- `Esc` or `q` - Exit scrollback

---

## Kittens (Power Tools)

Kittens are powerful extensions for Kitty.

### Quick Access Kittens

| Keybinding | Kitten | Description |
|------------|--------|-------------|
| `Ctrl+Alt+1` | **icat** | Display images in terminal |
| `Ctrl+Alt+2` | **diff** | GPU-accelerated diff viewer |
| `Ctrl+Alt+3` | **themes** | Interactive theme switcher |
| `Ctrl+Alt+4` | **broadcast** | Type in all windows simultaneously |
| `Ctrl+Alt+5` | **ssh** | SSH with auto-terminfo copy |
| `Ctrl+Alt+6` | **transfer** | Transfer files over TTY |
| `Ctrl+Alt+7` | **choose-files** | Fast file picker |
| `Ctrl+Alt+8` | **hyperlinked-grep** | Clickable grep results |
| `Ctrl+Alt+9` | **clipboard** | Advanced clipboard manager |
| `Ctrl+Alt+0` | **panel** | Create desktop panels |
| `Ctrl+Alt+-` | **query_terminal** | Query terminal capabilities |
| `Ctrl+Alt+=` | **notify** | Desktop notifications |

### Using Kittens from Command Line

```bash
# Display image
kitty +kitten icat image.png

# Show diff
kitty +kitten diff file1 file2

# Switch theme
kitty +kitten themes

# SSH with kitty features
kitty +kitten ssh user@host

# Transfer file
kitty +kitten transfer localfile remote:/path/

# Choose files interactively
kitty +kitten choose-files
```

---

## Development Shortcuts

### Code Editing

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+N` | Open Neovim | Launch nvim in overlay |
| `Ctrl+Alt+E` | Edit Fish Config | Open fish config in nvim |
| `Ctrl+Alt+K` | Edit Kitty Config | Open kitty config in nvim |

### Search & Find

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+F` | Ripgrep Types | Show ripgrep file types |
| `Ctrl+Shift+A` | Search Pattern | Search with pattern in overlay |

### Development Tools

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+Shift+G` | GitHub Create | Create private GitHub repo |
| `Ctrl+Alt+Shift+P` | List Packages | Show npm/pip packages |
| `Ctrl+Alt+Shift+S` | Find TODOs | Search for TODO/FIXME/BUG |

---

## System Monitoring

### System Info

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+M` | Btop | System monitor (CPU, RAM, processes) |
| `Ctrl+Alt+P` | Process List | Show processes with fzf |
| `Ctrl+Alt+I` | System Info | Full system information (inxi) |

### Quick Utilities

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+'` | System Info | Show uname, whoami, pwd |
| `Ctrl+Shift+;` | PATH | Display PATH directories |
| `Ctrl+Shift+.` | Hardware | Show CPU count and memory |

---

## Git Workflows

### Git Commands

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+G` | Git Log | Show last 20 commits |
| `Ctrl+Alt+B` | Git Branches | List all branches with fzf |
| `Ctrl+Alt+F` | Git Graph | Show commit graph |
| `Ctrl+Alt+X` | Git Status | Show current status |

### Git Tips

- Use **hints** (`Ctrl+Shift+G`) to quickly view commit details from git log
- Copy commit hashes easily with the hint system
- Use overlay windows for non-destructive git operations

---

## Docker/Containers

### Docker Commands

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+D` | Docker PS | List all containers |
| `Ctrl+Alt+Shift+D` | Docker Stats | Real-time container stats |
| `Ctrl+Alt+Shift+C` | Podman PS | List Podman containers |
| `Ctrl+Alt+Shift+L` | Docker Logs | Follow logs of first container |

### Container Tips

- Use **hints** (`Ctrl+Shift+D`) to quickly view logs of any container ID
- Container IDs are automatically detected in terminal output
- Click any 12-char hex string to view docker logs

---

## File Management

### File Browsers

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+Shift+F` | LF | Launch lf file manager |
| `Ctrl+Alt+Shift+N` | NNN | Launch nnn file manager |
| `Ctrl+Alt+Shift+T` | Tree | Show directory tree |

### File Path Tips

- Use **hints** (`Ctrl+Shift+P`) to open any file path in nvim
- Works with absolute paths (`/home/user/...`)
- Works with relative paths (`./file`, `../dir`)
- Works with home directory (`~/...`)

---

## Buffer Management

### Copy Buffers (A, B, C)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `F1` | Copy to A | Copy selection to buffer A |
| `F2` | Paste from A | Paste from buffer A |
| `F3` | Copy to B | Copy selection to buffer B |
| `F4` | Paste from B | Paste from buffer B |
| `F5` | Copy to C | Copy selection to buffer C |
| `F6` | Paste from C | Paste from buffer C |

### Use Cases

- **Buffer A**: Temporary clipboard
- **Buffer B**: Code snippets
- **Buffer C**: Command history or references

---

## Marks

### Mark Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+1` | Create Mark | Mark current position |
| `Ctrl+Shift+2` | Remove Mark | Remove mark at position |
| `Ctrl+Shift+3` | Toggle Mark | Show/hide marks |

### Using Marks

Marks allow you to save positions in scrollback and jump back to them later.

1. Navigate to important output
2. Press `Ctrl+Shift+1` to create a mark
3. Continue working
4. Jump back to mark later

---

## Font Size Control

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl++` | Increase | Make font larger |
| `Ctrl+-` | Decrease | Make font smaller |
| `Ctrl+0` | Reset | Return to default size |

---

## Display & Debug

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Shift+F11` | Fullscreen | Toggle fullscreen mode |
| `Ctrl+Shift+D` | Debug Config | Show current configuration |
| `Ctrl+Shift+Esc` | Kitty Shell | Open kitty shell in window |

---

## Network & Security

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+Alt+S` | SSH Selector | SSH to host via fzf |
| `Ctrl+Alt+C` | GitHub API | Query GitHub API |
| `Ctrl+Alt+W` | Network Manager | Open nmtui |
| `Ctrl+Alt+T` | Network Monitor | Run nethogs (sudo) |
| `Ctrl+Alt+Shift+A` | Audit Rules | Show auditctl rules |
| `Ctrl+Alt+Shift+X` | Journal | Show recent journal entries |

---

## Configuration

### File Locations

```
~/.config/kitty/
├── kitty.conf              # Main configuration
├── cyberpunk-synthwave.conf # Color theme
├── keybinds.conf           # Keybindings (if separate)
└── CHEATSHEET.md          # This file
```

### Important Settings

| Setting | Value | Description |
|---------|-------|-------------|
| **Scrollback** | 100,000 lines | Large history buffer |
| **Shell** | fish | Default shell |
| **Editor** | nvim | Default editor |
| **Font** | MesloLGS Nerd Font Mono | Nerd font with icons |
| **Opacity** | 0.9 | Slight transparency |
| **Remote Control** | Enabled | For scripting |

### Performance Tuning

```conf
repaint_delay 8          # Faster rendering
input_delay 2            # Lower input latency
sync_to_monitor yes      # Sync with monitor refresh
```

---

## Tips & Tricks

### 1. Quick URL Opening
See a URL in terminal output? Just press `Ctrl+Shift+U` and the letter of the URL.

### 2. Copy Without Mouse
Use hints to copy any text pattern without touching the mouse.

### 3. Multi-Window Input
Use `Ctrl+Alt+4` (broadcast) to type the same command in all kitty windows simultaneously.

### 4. Image Preview
Use `Ctrl+Alt+1` or `kitty +kitten icat image.png` to view images without leaving terminal.

### 5. SSH Made Easy
Use `Ctrl+Alt+5` or `kitty +kitten ssh host` for SSH that preserves all kitty features.

### 6. Theme Switching
Press `Ctrl+Alt+3` to interactively switch between 100+ color themes.

### 7. File Transfer
Use `kitty +kitten transfer` to send files over SSH without scp.

### 8. Diff Viewer
Use `Ctrl+Alt+2` or `kitty +kitten diff` for beautiful, GPU-accelerated diffs.

---

## Troubleshooting

### Hints Not Working

1. Ensure text is visible on screen
2. Check that the pattern matches (e.g., URLs need http/https)
3. Try scrolling to make text visible

### Keybindings Not Working

1. Check for conflicts with DWM or other WM
2. Verify kitty is focused
3. Some keybindings only work in specific modes

### DWM Conflicts

All Kitty keybindings use:
- `Ctrl` combinations
- `Ctrl+Shift` combinations  
- `Alt` combinations (for tabs)
- `Ctrl+Alt` combinations (for kittens)

None use `Super` (Windows key) to avoid DWM workspace conflicts.

### Scrollback Issues

If scrollback seems limited:
```bash
# Check current setting
kitty +kitten query_terminal | grep scrollback
```

### Remote Control

To control kitty from scripts:
```bash
# List windows
kitty @ ls

# Send text to window
kitty @ send-text --match title:mywindow "hello"

# Resize window
kitty @ resize-window --increment 10
```

---

## Comparison: Before vs After

| Feature | Before | After (God Mode) |
|---------|--------|------------------|
| **Hints System** | ❌ Basic URLs | ✅ 11 pattern types |
| **Scrollback** | 10,000 lines | ✅ 100,000 lines |
| **Tab Navigation** | Next/Prev only | ✅ Direct access (Alt+1-9) |
| **Kittens** | ❌ None mapped | ✅ 12 kittens |
| **Image Viewing** | ❌ Not available | ✅ icat integrated |
| **Theme Switching** | ❌ Manual edit | ✅ Interactive |
| **SSH Integration** | ❌ Basic | ✅ With terminfo |
| **File Transfer** | ❌ scp only | ✅ kitty transfer |
| **Multi-Window Input** | ❌ Not available | ✅ Broadcast mode |
| **Marks** | ✅ Available | ✅ Enhanced |
| **Buffers** | ✅ A/B/C | ✅ Same |

---

## Credits

- **Terminal**: Kitty by Kovid Goyal
- **Theme**: Cyberpunk Synthwave
- **Font**: MesloLGS Nerd Font Mono
- **Shell**: Fish
- **Editor**: Neovim
- **WM**: DWM (compatible keybindings)

---

**Version**: God Mode 1.0  
**Last Updated**: 2026-02-09  
**Configuration**: `~/.config/kitty/kitty.conf`

---

*Happy hacking with your supercharged terminal!* 🚀
