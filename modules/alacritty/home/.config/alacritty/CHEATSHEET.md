# Alacritty God Mode Configuration

> **Power User Workflow - Security Research Edition**  
> Optimized for bash and advanced terminal operations

---

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Keybindings](#keybindings)
  - [Clipboard Operations](#clipboard-operations)
  - [Tabs Management](#tabs-management)
  - [Window Management](#window-management)
  - [Scrolling](#scrolling)
  - [Font Size](#font-size)
  - [Search](#search)
  - [Vi Mode](#vi-mode)
  - [Clear & History](#clear--history)
  - [Window States](#window-states)
- [Hints (Text Detection)](#hints-text-detection)
- [Mouse Bindings](#mouse-bindings)
- [Configuration Details](#configuration-details)
- [Troubleshooting](#troubleshooting)

---

## Overview

This configuration transforms Alacritty into a **power user terminal** with:

- **7 Smart Hints** for instant text detection (URLs, IPs, hashes, etc.)
- **Complete Vi Mode** with full navigation and selection
- **Tab Management** for multiple terminal sessions
- **Bidirectional Search** with regex support
- **Advanced Scrolling** with Vim-style keybindings
- **SSH Clipboard Integration** (OSC 52)

---

## Installation

```bash
# Clone or copy configuration files to:
~/.config/alacritty/

# Required files:
# - alacritty.toml (main configuration)
# - keybinds.toml (keybindings)
# - nordic.toml (color theme)

# Test configuration
alacritty --config-file ~/.config/alacritty/alacritty.toml
```

---

## Keybindings

### Clipboard Operations

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + V` | Paste | Paste from clipboard |
| `Super + C` | Copy | Copy selection to clipboard |
| `Ctrl + Shift + S` | Paste | Alternative paste |
| `Ctrl + Shift + C` | Copy | Alternative copy |
| `Shift + Insert` | Paste Selection | Paste from primary selection |
| `Ctrl + Shift + V` | Paste Selection | Alternative paste selection |

### Tabs Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + T` | Create New Tab | Open a new tab |
| `Super + Tab` | Next Tab | Switch to next tab |
| `Super + Shift + Tab` | Previous Tab | Switch to previous tab |
| `Super + 1` | Select Tab 1 | Jump to tab 1 |
| `Super + 2` | Select Tab 2 | Jump to tab 2 |
| `Super + 3` | Select Tab 3 | Jump to tab 3 |
| `Super + 4` | Select Tab 4 | Jump to tab 4 |
| `Super + 5` | Select Tab 5 | Jump to tab 5 |
| `Super + 6` | Select Tab 6 | Jump to tab 6 |
| `Super + 7` | Select Tab 7 | Jump to tab 7 |
| `Super + 8` | Select Tab 8 | Jump to tab 8 |
| `Super + 9` | Select Last Tab | Jump to last tab |

### Window Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + Alt + H` | Create New Window | Open new terminal window |
| `Super + Shift + N` | Spawn New Instance | Launch new Alacritty instance |
| `Ctrl + Shift + Return` | Spawn New Instance | Alternative new instance |
| `Super + W` | Quit | Close current window |
| `Ctrl + Shift + Q` | Quit | Alternative quit |

### Scrolling

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + Shift + Up` | Scroll Line Up | Scroll up one line |
| `Ctrl + Shift + Down` | Scroll Line Down | Scroll down one line |
| `Ctrl + Shift + K` | Scroll Line Up | Vim-style up |
| `Ctrl + Shift + J` | Scroll Line Down | Vim-style down |
| `Ctrl + Shift + PageUp` | Scroll Page Up | Scroll up one page |
| `Ctrl + Shift + PageDown` | Scroll Page Down | Scroll down one page |
| `Ctrl + Shift + Home` | Scroll to Top | Jump to beginning |
| `Ctrl + Shift + End` | Scroll to Bottom | Jump to end |
| `Ctrl + Shift + U` | Scroll Half Page Up | Scroll up half page |
| `Ctrl + Shift + D` | Scroll Half Page Down | Scroll down half page |
| `Ctrl + Shift + G` | Scroll to Top | Vim-style top |
| `Ctrl + Shift + Alt + G` | Scroll to Bottom | Vim-style bottom |

### Font Size

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + Shift + Alt + Up` | Increase Font Size | Make text larger |
| `Ctrl + Shift + Alt + Down` | Decrease Font Size | Make text smaller |
| `Ctrl + Shift + Alt + K` | Increase Font Size | Alternative increase |
| `Ctrl + Shift + Alt + J` | Decrease Font Size | Alternative decrease |
| `Ctrl + 0` | Reset Font Size | Return to default size |
| `Ctrl + =` | Increase Font Size | Quick increase |
| `Ctrl + -` | Decrease Font Size | Quick decrease |
| `Ctrl + Shift + R` | Reset Font Size | Alternative reset |

### Search

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + F` | Search Forward | Search forward in buffer |
| `Ctrl + B` | Search Backward | Search backward in buffer |
| `Ctrl + 1` | Search Forward | Alternative forward search |
| `Ctrl + 2` | Search Backward | Alternative backward search |
| `Ctrl + N` (in search) | Search Next | Next occurrence |
| `Ctrl + Shift + N` (in search) | Search Previous | Previous occurrence |
| `Escape` (in search) | Search Cancel | Exit search mode |
| `Return` (in search) | Search Confirm | Confirm search |

### Vi Mode

#### Enter/Exit Vi Mode

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + Shift + Space` | Toggle Vi Mode | Enter or exit Vi mode |
| `Ctrl + 3` | Toggle Vi Mode | Alternative toggle |
| `Escape` | Toggle Vi Mode | Alternative toggle |

#### Basic Movement (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `H` | Left | Move cursor left |
| `J` | Down | Move cursor down |
| `K` | Up | Move cursor up |
| `L` | Right | Move cursor right |

#### Word Movement (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `W` | Word Right | Next word start |
| `E` | Word Right End | Next word end |
| `B` | Word Left | Previous word start |
| `Shift + W` | Semantic Right | Next semantic block |
| `Shift + B` | Semantic Left | Previous semantic block |

#### Line Movement (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `0` | First | Start of line |
| `Shift + 4` | Last | End of line |
| `Shift + H` | High | Top of screen |
| `Shift + M` | Middle | Middle of screen |
| `Shift + L` | Low | Bottom of screen |

#### Scrolling (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `U` | Scroll Half Page Up | Half page up |
| `D` | Scroll Half Page Down | Half page down |
| `G` | Scroll to Top | Go to top |
| `Shift + G` | Scroll to Bottom | Go to bottom |

#### Search (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `/` | Search Forward | Search forward |
| `?` | Search Backward | Search backward |
| `N` | Search Next | Next match |
| `Shift + N` | Search Previous | Previous match |

#### Inline Search (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `F` | Inline Search Forward | Find character forward |
| `Shift + F` | Inline Search Backward | Find character backward |
| `T` | Inline Search Forward Short | Find before character forward |
| `Shift + T` | Inline Search Backward Short | Find before character backward |
| `;` | Inline Search Next | Repeat last inline search |
| `,` | Inline Search Previous | Repeat last inline search reverse |

#### Selection (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `V` | Toggle Normal Selection | Start character selection |
| `Shift + V` | Toggle Line Selection | Start line selection |
| `Ctrl + V` | Toggle Block Selection | Start block selection |
| `Shift + A` | Toggle Semantic Selection | Select semantic block |

#### Copy/Actions (Vi Mode)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Y` | Copy | Copy selection |
| `Shift + Y` | Scroll to Top | Alternative top |
| `C` | Copy | Alternative copy |
| `Return` | Open | Open URL/file under cursor |
| `O` | Open | Alternative open |
| `Z` | Center Around Vi Cursor | Center screen on cursor |
| `Q` | ReceiveChar | Pass through |
| `I` | Scroll to Bottom | Exit Vi mode (like Vim) |
| `Shift + I` | Scroll to Bottom | Alternative exit |

### Clear & History

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + K` | Clear History | Clear scrollback history |
| `Ctrl + L` | Clear Log Notice | Clear warning messages |
| `Ctrl + Shift + C` | Clear Selection | Deselect current selection |

### Window States

| Keybinding | Action | Description |
|------------|--------|-------------|
| `F11` | Toggle Fullscreen | Fullscreen mode |
| `Super + Shift + F` | Toggle Fullscreen | Alternative fullscreen |
| `Super + M` | Toggle Maximized | Maximize window |
| `Super + H` | Hide | Hide window |

---

## Hints (Text Detection)

Hints allow you to quickly detect and copy specific patterns from the terminal.

### Available Hints

| Keybinding | Pattern | Example |
|------------|---------|---------|
| `Ctrl + Shift + U` | **URLs** | `https://example.com/path` |
| `Ctrl + Shift + I` | **IPv4 Addresses** | `192.168.1.1` |
| `Ctrl + Shift + P` | **File Paths** | `/home/user/file.txt` or `~/project` |
| `Ctrl + Shift + G` | **Git Hashes** | `a1b2c3d` or full SHA |
| `Ctrl + Shift + E` | **Email Addresses** | `user@example.com` |
| `Ctrl + Shift + X` | **UUIDs** | `550e8400-e29b-41d4-a716-446655440000` |
| `Ctrl + Shift + M` | **MAC Addresses** | `00:1B:44:11:3A:B7` |
| `Ctrl + Shift + D` | **Container IDs** | Docker/Podman short IDs |

### How to Use Hints

1. Press the hint keybinding (e.g., `Ctrl + Shift + U` for URLs)
2. Alacritty will highlight all matching patterns with letters
3. Press the highlighted letter(s) to copy that pattern to clipboard

---

## Mouse Bindings

| Action | Binding | Description |
|--------|---------|-------------|
| Hide When Typing | Enabled | Mouse cursor hides while typing |
| Expand Selection | `Ctrl + Right Click` | Expand selection to cursor |
| Expand Selection | `Ctrl + Shift + Right Click` | Alternative expand |
| Paste Selection | `Middle Click` | Paste from primary selection |
| Expand Selection | `Shift + Left Click` | Expand selection |

---

## Configuration Details

### Terminal Settings

```toml
[terminal]
shell = { program = "/bin/bash", args = ["-l", "-i"] }
osc52 = "CopyPaste"  # Enable clipboard integration over SSH
```

### Window Settings

```toml
[window]
title = "Alacritty"
decorations = "none"
blur = false
opacity = 0.97
padding.x = 8
padding.y = 8
dynamic_padding = true

dimensions.columns = 180
dimensions.lines = 50
```

### Scrolling

```toml
[scrolling]
history = 100000  # 100k lines of scrollback
multiplier = 3
```

### Cursor

```toml
[cursor]
style = { shape = "Beam", blinking = "On" }
blink_interval = 500
```

### Font

```toml
[font]
size = 15.0
normal.family = "MesloLGS Nerd Font Mono"
bold.family = "MesloLGS Nerd Font Mono"
italic.family = "MesloLGS Nerd Font Mono"
```

---

## Troubleshooting

### Configuration Not Loading

```bash
# Test configuration
alacritty --config-file ~/.config/alacritty/alacritty.toml

# Check for errors
alacritty -v 2>&1 | head -20
```

### Keybindings Not Working

- Ensure no other application is capturing the keybinding
- Check if your window manager has conflicting shortcuts
- Try alternative keybindings listed in this cheat sheet

### Hints Not Detecting Patterns

- Hints only work on visible text in the terminal
- Some patterns may need adjustment for your specific use case
- Edit the regex patterns in `alacritty.toml` if needed

### Vi Mode Navigation Issues

- Vi mode must be toggled on first (`Ctrl + Shift + Space`)
- Some keybindings only work in Vi mode (marked in tables above)
- Press `Escape` or `I` to exit Vi mode

### OSC 52 Not Working Over SSH

- Ensure the remote server supports OSC 52
- Check if your SSH client forwards the clipboard
- Some terminal multiplexers (tmux, screen) may interfere

---

## Customization

### Adding Custom Hints

Edit `~/.config/alacritty/alacritty.toml`:

```toml
[[hints.enabled]]
regex = "your-pattern-here"
action = "Copy"
binding = { key = "YourKey", mods = "Control|Shift" }
```

### Modifying Keybindings

Edit `~/.config/alacritty/keybinds.toml`:

```toml
[keyboard]
bindings = [
  { key = "YourKey", mods = "YourMods", action = "YourAction" },
]
```

### Changing Colors

Edit `~/.config/alacritty/nordic.toml` or create your own theme file.

---

## Credits

- **Configuration**: Power User Workflow for Security Research
- **Theme**: Nordic Color Scheme (enhanced)
- **Font**: MesloLGS Nerd Font Mono
- **Terminal**: Alacritty 0.16+

---

## License

This configuration is provided as-is for personal use. Feel free to modify and distribute.

---

**Last Updated**: 2026-02-09  
**Version**: God Mode 1.0
