# Keybindings Reference

Quick reference guide for all custom keybindings, shortcuts, and aliases in this dotfiles configuration.

---

## DWM (Window Manager)

**Modifier Key:** `Super` (Windows/Command key)

### Applications & Launchers

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + Z` | Launch Rofi | Application launcher (drun mode) |
| `Super + X` | Open Terminal | Launch Kitty terminal |
| `Super + B` | Open Browser | Open default browser with blank page |
| `Super + E` | Open File Manager | Open current directory in default file manager |
| `Super + W` | Looking Glass | Launch Looking Glass client (VM passthrough) |

### Window Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + J` | Focus Next | Move focus to next window in stack |
| `Super + K` | Focus Previous | Move focus to previous window in stack |
| `Super + Shift + J` | Move Down | Move current window down in stack |
| `Super + Shift + K` | Move Up | Move current window up in stack |
| `Super + H` | Shrink Master | Decrease master area size |
| `Super + L` | Expand Master | Increase master area size |
| `Super + Shift + H` | Increase Client Height | Increase focused window height factor |
| `Super + Shift + L` | Decrease Client Height | Decrease focused window height factor |
| `Super + Shift + O` | Reset Client Factor | Reset window size factor to default |
| `Super + Return` | Zoom | Swap focused window with master |
| `Super + Q` | Kill Window | Close focused window |

### Layouts

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + T` | Tile Layout | Switch to tiling layout |
| `Super + F` | Float Layout | Switch to floating layout |
| `Super + M` | Fullscreen | Toggle fullscreen for focused window |
| `Super + Shift + M` | Toggle Float | Toggle floating for focused window |
| `Super + Shift + Y` | Fake Fullscreen | Toggle fake fullscreen |
| `Super + Space` | Toggle Layout | Cycle through layouts |
| `Super + I` | Increase Master | Increase number of windows in master area |
| `Super + D` | Decrease Master | Decrease number of windows in master area |

### Workspaces (Tags)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + 1-5` | Switch to Tag | View workspace/tag 1-5 |
| `Super + Shift + 1-5` | Move to Tag | Move focused window to tag 1-5 |
| `Super + Ctrl + 1-5` | Toggle Tag View | Add/remove tag from current view |
| `Super + Ctrl + Shift + 1-5` | Toggle Tag | Tag window with additional tag |
| `Super + 0` | View All | Show all tags |
| `Super + Tab` | Last Tag | Switch to previously viewed tag |

### Multi-Monitor

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + ,` | Focus Previous Monitor | Move focus to previous monitor |
| `Super + .` | Focus Next Monitor | Move focus to next monitor |
| `Super + Shift + ,` | Send to Previous Monitor | Move window to previous monitor |
| `Super + Shift + .` | Send to Next Monitor | Move window to next monitor |

### Screenshots (Flameshot)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + P` | Full Screenshot | Capture entire screen, save to `/media/drive/Screenshots/` |
| `Super + Shift + P` | GUI Screenshot | Interactive screenshot mode with GUI |
| `Super + Ctrl + P` | Clipboard Screenshot | Capture to clipboard (no file saved) |

### System Controls

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Super + Shift + L` | Lock Screen | Lock screen with lockscreen.sh |
| `Super + Shift + B` | Toggle Bar | Show/hide status bar |
| `Super + Shift + W` | Change Wallpaper | Randomize wallpaper from ~/Pictures/backgrounds/ |
| `Super + Shift + Q` | Quit DWM | Exit DWM (logout) |
| `Super + Ctrl + Q` | Power Menu | Open Rofi power menu |
| `Super + Ctrl + Shift + R` | Reboot | Reboot system |
| `Super + Ctrl + Shift + S` | Suspend | Suspend system |
| `Super + Ctrl + R` | Restart Proton | Restart Proton services |

### Media Keys

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Brightness Up` | Increase Brightness | +10% screen brightness |
| `Brightness Down` | Decrease Brightness | -10% screen brightness |
| `Volume Up` | Increase Volume | +5% system volume |
| `Volume Down` | Decrease Volume | -5% system volume |
| `Mute` | Toggle Mute | Mute/unmute audio |

### Mouse Bindings

| Mouse Action | Effect | Description |
|--------------|--------|-------------|
| `Super + Left Click` | Move Window | Drag to move window |
| `Super + Right Click` | Resize Window | Drag to resize window |
| `Click on Tag` | View Tag | Switch to clicked workspace |
| `Right Click on Tag` | Toggle Tag View | Add/remove tag from view |

---

## Tmux (Terminal Multiplexer)

**Prefix Key:** `Ctrl + Space`

### Basic Commands

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + Space` | Prefix | Tmux command prefix |
| `Prefix + Ctrl + Space` | Send Prefix | Send literal Ctrl+Space to terminal |

### Pane Navigation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Prefix + H` | Select Left Pane | Vim-style left navigation |
| `Prefix + J` | Select Down Pane | Vim-style down navigation |
| `Prefix + K` | Select Up Pane | Vim-style up navigation |
| `Prefix + L` | Select Right Pane | Vim-style right navigation |
| `Alt + Left` | Select Left Pane | Arrow key navigation (no prefix) |
| `Alt + Right` | Select Right Pane | Arrow key navigation (no prefix) |
| `Alt + Up` | Select Up Pane | Arrow key navigation (no prefix) |
| `Alt + Down` | Select Down Pane | Arrow key navigation (no prefix) |

### Window Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Shift + Left` | Previous Window | Switch to previous window (no prefix) |
| `Shift + Right` | Next Window | Switch to next window (no prefix) |
| `Alt + Shift + H` | Previous Window | Vim-style previous window (no prefix) |
| `Alt + Shift + L` | Next Window | Vim-style next window (no prefix) |

### Pane Splitting

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Prefix + "` | Split Horizontal | Split pane horizontally (opens in current path) |
| `Prefix + %` | Split Vertical | Split pane vertically (opens in current path) |

### Copy Mode (Vi-style)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Prefix + [` | Enter Copy Mode | Start copy mode (vi-style navigation) |
| `v` | Begin Selection | Start visual selection (in copy mode) |
| `Ctrl + V` | Rectangle Toggle | Toggle rectangle selection (in copy mode) |
| `y` | Copy & Exit | Yank selection and exit copy mode |
| `q` | Exit Copy Mode | Exit without copying |

---

## Shell Aliases

These aliases are available in **both Fish and Zsh**.

### Common Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `lsd` | Modern ls with icons and colors |
| `cat` | `bat` | Syntax-highlighted cat alternative |
| `vim` | `nvim` | Use Neovim instead of Vim |
| `c` | `clear` | Clear terminal (Zsh only) |

### Environment Setup

**Fish-specific paths:**
```fish
$HOME/.cargo/bin           # Rust/Cargo binaries
~/.emacs.d/bin             # Doom Emacs binaries
$HOME/depot_tools          # Chromium depot tools
```

**Zsh-specific integrations:**
- `fzf` - Fuzzy finder (Ctrl+R for history search)
- `zoxide` - Smart cd replacement (aliased to `cd`)

---

## Zsh-Specific Keybindings

Additional keybindings only available in Zsh.

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl + P` | History Backward | Search command history backward |
| `Ctrl + N` | History Forward | Search command history forward |
| `Alt + W` | Kill Region | Delete selected text region |
| `Ctrl + R` | FZF History | Fuzzy search through command history (fzf) |

---

## Shell Plugins & Integrations

### Zsh Plugins (via Zinit)
- **zsh-syntax-highlighting** - Real-time syntax highlighting
- **zsh-autosuggestions** - Fish-like autosuggestions
- **zsh-completions** - Additional completion definitions
- **fzf-tab** - Replace completion with fzf
- **Powerlevel10k** - Fast and customizable prompt

### Fish Plugins (via Fisher)
Managed through Fisher plugin manager

---

## Tips & Tricks

### DWM
- **Tag labels:** 1:  2:  3: 󰊖 4:  5: 
- **Autostart:** Many services start automatically (picom, dunst, flameshot, etc.)
- **Multi-monitor:** Configured for 3 monitors via xrandr

### Tmux
- **Mouse support:** Enabled for scrolling and pane selection
- **Catppuccin theme:** Mocha variant applied
- **Vi mode:** Full vi-style keybindings in copy mode
- **True color:** 24-bit color support enabled

### Shell
- **Starship prompt:** Fast, minimal prompt with Git integration
- **History:** Zsh configured with 5000 lines, deduplication enabled
- **Case-insensitive completion:** Zsh matches regardless of case

---

## Configuration Files

For more details or customization:

- **DWM:** `.config/dwm/config.h` (requires recompilation after changes)
- **Tmux:** `.config/tmux/tmux.conf`
- **Fish:** `.config/fish/config.fish`
- **Zsh:** `.config/zsh/.zshrc`
- **Starship:** `starship.toml`

---

**Last Updated:** 2024
