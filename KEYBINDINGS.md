# Keybindings Reference

All the custom shortcuts, keybindings, and aliases I've configured. Organized by tool so you can find what you need fast.

---

## DWM (Window Manager)

**Modifier key:** `Super` (Windows/Command key)

### Launching Apps

| Key | What it does |
|:---|:---|
| `Super + Z` | Open Rofi (app launcher) |
| `Super + X` | Open Kitty terminal |
| `Super + B` | Open default browser |
| `Super + E` | Open file manager |
| `Super + W` | Launch Looking Glass (for VM passthrough) |

### Moving Around Windows

| Key | What it does |
|:---|:---|
| `Super + J` | Focus next window |
| `Super + K` | Focus previous window |
| `Super + Shift + J` | Move window down in stack |
| `Super + Shift + K` | Move window up in stack |
| `Super + H` | Shrink master area |
| `Super + L` | Expand master area |
| `Super + Shift + H` | Make focused window taller |
| `Super + Shift + L` | Make focused window shorter |
| `Super + Shift + O` | Reset window size to default |
| `Super + Return` | Swap focused window into master |
| `Super + Q` | Close focused window |

### Layouts

| Key | What it does |
|:---|:---|
| `Super + T` | Tile layout |
| `Super + F` | Float layout |
| `Super + M` | Fullscreen (toggle) |
| `Super + Shift + M` | Float current window |
| `Super + Shift + Y` | Fake fullscreen |
| `Super + Space` | Cycle through layouts |
| `Super + I` | Add window to master area |
| `Super + D` | Remove window from master area |

### Workspaces (Tags)

| Key | What it does |
|:---|:---|
| `Super + 1-5` | Switch to workspace 1-5 |
| `Super + Shift + 1-5` | Move window to workspace |
| `Super + Ctrl + 1-5` | Add/remove tag from current view |
| `Super + Ctrl + Shift + 1-5` | Tag current window with additional tag |
| `Super + 0` | Show all tags |
| `Super + Tab` | Switch to previously viewed tag |

### Multiple Monitors

| Key | What it does |
|:---|:---|
| `Super + ,` | Focus previous monitor |
| `Super + .` | Focus next monitor |
| `Super + Shift + ,` | Send window to previous monitor |
| `Super + Shift + .` | Send window to next monitor |

### Screenshots

| Key | What it does |
|:---|:---|
| `Super + P` | Full screen screenshot (saved to `/media/drive/Screenshots/`) |
| `Super + Shift + P` | Interactive screenshot (select area) |
| `Super + Ctrl + P` | Screenshot to clipboard |

### System Controls

| Key | What it does |
|:---|:---|
| `Super + Shift + L` | Lock screen |
| `Super + Shift + B` | Toggle waybar |
| `Super + Shift + W` | Cycle wallpaper |
| `Super + Shift + Q` | Quit DWM (logout) |
| `Super + Ctrl + Q` | Power menu (shutdown, reboot, etc.) |
| `Super + Ctrl + Shift + R` | Reboot |
| `Super + Ctrl + Shift + S` | Suspend |
| `Super + Ctrl + R` | Restart Proton (Steam/Proton stuff) |

### Media Keys

| Key | What it does |
|:---|:---|
| `Brightness Up` | +10% brightness |
| `Brightness Down` | -10% brightness |
| `Volume Up` | +5% volume |
| `Volume Down` | -5% volume |
| `Mute` | Toggle mute |

### Mouse in DWM

| Action | What it does |
|:---|:---|
| `Super + Left Click + Drag` | Move window |
| `Super + Right Click + Drag` | Resize window |
| `Click on Tag` | Switch workspace |
| `Right Click on Tag` | Toggle tag in view |

---

## Tmux (Terminal Multiplexer)

**Prefix key:** `Ctrl + Space`

### Basic

| Key | What it does |
|:---|:---|
| `Ctrl + Space` | Send prefix (wait for it before command) |
| `Prefix + Ctrl + Space` | Send literal Ctrl+Space to terminal |

### Moving Between Panes

| Key | What it does |
|:---|:---|
| `Prefix + H` | Go to pane on the left |
| `Prefix + J` | Go to pane below |
| `Prefix + K` | Go to pane above |
| `Prefix + L` | Go to pane on the right |
| `Alt + Left` | Go left (no prefix needed) |
| `Alt + Right` | Go right |
| `Alt + Up` | Go up |
| `Alt + Down` | Go down |

### Windows (Tabs)

| Key | What it does |
|:---|:---|
| `Shift + Left` | Previous window |
| `Shift + Right` | Next window |
| `Alt + Shift + H` | Previous window (vim-style) |
| `Alt + Shift + L` | Next window (vim-style) |

### Splitting Panes

| Key | What it does |
|:---|:---|
| `Prefix + "` | Split horizontally |
| `Prefix + %` | Split vertically |

### Copy Mode (Vi-style)

| Key | What it does |
|:---|:---|
| `Prefix + [` | Enter copy mode |
| `v` | Start selecting text |
| `Ctrl + V` | Toggle rectangle selection |
| `y` | Copy selection and exit |
| `q` | Exit without copying |

---

## Shell Aliases

Available in both Fish and Zsh.

| Alias | Expands to | Why |
|:---|:---|:---|
| `ls` | `lsd` | Colored output, icons, sorting |
| `cat` | `bat` | Syntax highlighting |
| `vim` | `nvim` | Use Neovim everywhere |
| `c` | `clear` | Quick terminal clear (Zsh only) |

### Shell Paths

**Fish adds these:**
```
~/.cargo/bin           # Rust/Cargo binaries
~/.emacs.d/bin         # Doom Emacs binaries
~/depot_tools          # Chromium depot tools
```

**Zsh integrations:**
- `fzf` — fuzzy finder (try `Ctrl+R` for history)
- `zoxide` — smart `cd` replacement, learns your habits

---

## Tips

**DWM stuff:**
- Tags 1-5 are labeled, 4 shows a different icon
- Autostart handles picom, dunst, flameshot, etc.
- Three monitors configured via xrandr

**Tmux stuff:**
- Mouse mode is on — scroll, click panes
- Catppuccin Mocha theme applied
- Full vi keybindings in copy mode
- True color support enabled

**Shell stuff:**
- Starship prompt — fast, shows git status
- Zsh history: 5000 lines, deduplicated
- Zsh completion ignores case

---

## Config Files

If you want to customize things:

- **DWM:** `.config/dwm/config.h` (recompile after editing)
- **Tmux:** `.config/tmux/tmux.conf`
- **Fish:** `.config/fish/config.fish`
- **Zsh:** `.config/zsh/.zshrc`
- **Starship:** `starship.toml`
