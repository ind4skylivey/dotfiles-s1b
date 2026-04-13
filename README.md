# Arch Linux Dotfiles - S1B

![Banner](assets/dotfiles.png)

### Live System Showcase

![Desktop showcase](.github/screenshots/desktop-showcase.gif)

---

[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white)](https://archlinux.org)
[![DWM](https://img.shields.io/badge/DWM-Patched-FF6B6B?style=flat-square)](https://dwm.suckless.org)
[![Neovim](https://img.shields.io/badge/Neovim-NvChad-57A143?style=flat-square&logo=neovim&logoColor=white)](https://nvchad.com)
[![Zellij](https://img.shields.io/badge/Zellij-Session%20Manager-FF9100?style=flat-square)](https://zellij.dev)
[![Doom Emacs](https://img.shields.io/badge/Doom%20Emacs-7E5CFF?style=flat-square&logo=gnu%20emacs&logoColor=white)](https://doomemacs.org)
[![Fish Shell](https://img.shields.io/badge/Fish%20Shell-021ECA?style=flat-square&logo=fishshell&logoColor=white)](https://fishshell.com)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-F5C2E7?style=flat-square)](https://catppuccin.com)
[![MIT License](https://img.shields.io/badge/License-MIT-22C55E?style=flat-square)](LICENSE)

---

## What is this?

These are my dotfiles - the configuration files that turn a bare Arch Linux install into my personal development environment. It's built for people who live in the terminal: developers, security researchers, writers who want something fast, distraction-free, and keyboard-driven.

I'm running **Arch Linux (CachyOS)** with a custom-patched **DWM** for window management and the **Eco-Workflow** system to manage different work contexts.

> **The idea:** Minimal intrusion, maximum reproducibility. Tools should adapt to what you're trying to do, not the other way around.

---

## The Eco-Workflow System

Instead of launching terminal, editor, file browser separately every time, I launch **contexts** - full workflow presets that spin up the right tools with the right layouts for whatever I'm doing.

```
User -> ws-menu (Rofi) -> Selects a context
                           |
                           +- Dev      -> Zellij with dev layout
                           +- Ops      -> Tmux for SSH sessions
                           +- Write    -> Doom Emacs daemon
                           +- Red Team -> Tmux + isolated Docker container
```

### The Six Layers

**1. Orchestration Layer** - Entry points for launching everything:

| Command | Context | Engine | When I use it |
|:---:|:---:|:---:|:---|
| `ws-local` | Development | Zellij | Coding, testing, generic tasks |
| `ws-remote` | Infrastructure | Tmux | SSH to servers, persistent sessions |
| `ws-write` | Deep Work | Emacs | Writing, planning, org-mode |
| `ws-redteam` | Red Team | Docker + Tmux | CTFs, pentesting, isolated research |
| `ws-menu` | Launcher | Rofi | Visual menu to pick your context |
| `ws-kill` | Panic button | Bash | Emergency shutdown - kills everything |

**2. State Layer** - Context awareness via environment variables:
- `LIVEY_WORKFLOW` - the mode (local, write, redteam, remote)
- `LIVEY_CONTEXT` - the target (project name, file, host)
- `LIVEY_WORKFLOW_SESSION` - unique session ID for logging

**3. Execution Layer** - Session engines (Zellij for ephemeral, Tmux for persistent)

**4. Active Intelligence Layer**:
- **Materia Shift** - terminal theme changes based on context (Bahamut, Ice, Fire, Wind)
- **Obsidian Neural Link** - session summaries logged to Obsidian daily notes
- **Protocolo Fantasma** - auto-cleanup when exiting red team sessions

**5. Control Layer** - `ws-menu` for visual selection, `ws-kill` for emergency

**6. Observability Layer** - `ws-doctor` for diagnostics and health checks

Full details in [ECO_WORKFLOW_GUIDE.md](ECO_WORKFLOW_GUIDE.md).

---

## Screenshots

### Doom Emacs

![Doom Emacs](.github/screenshots/emacs.png)

Seamless editor + file browser integration with Catppuccin theme.

### Tmux + Zellij

| ![Tmux workflow](.github/screenshots/tmux_v2.png) | ![Zellij](.github/screenshots/zellij_v2.png) |
|:---:|:---:|
| Classic, rock-solid multiplexing | Modern layout-driven approach |

### Waybar Multi-Monitor

![Waybar multi-monitor](.github/screenshots/waybar.png)

Three monitors with independent wallpaper management and a cyberpunk status bar. Tracks CPU, memory, temp, network, VPN and more.

---

## What's Included

### Shell & Terminal
- **Fish** - my interactive shell, configured for comfort
- **Zsh** - POSIX-compliant, used for scripts and automation
- **Kitty** - GPU-accelerated terminal, my daily driver
- **Alacritty** - alternative terminal for when I need something lean
- **Starship** - fast, customizable prompt with git integration

### Window Management
- **DWM** - patched and heavily customized
- **Picom** - compositing for smooth transparency effects
- **Rofi** - launcher for everything
- **Dunst** - notifications that don't get in the way

### Editors
- **Neovim** - Lua-configured with NvChad, LSP-powered, my main editor
- **Doom Emacs** - org-mode for writing and planning, Magit for git workflows
- **Helix** - modal editor with a cyberpunk theme I put together
- **Micro** - for quick edits when Neovim feels like overkill

### File Browsers
- **Yazi** - fast, Rust-based file browser that lives in my editor pane
- **PCManFM-Qt** - lightweight GTK file manager for graphical tasks

### Status Bars
- **Waybar** - KDE Plasma 6 Wayland integration, multi-monitor ready
- **slstatus** - DWM status bar component

### Session Managers
- **Zellij** - layout-driven, disposable sessions for local development
- **Tmux** - persistent sessions for SSH and long-running work

### System Tools
- **btop** - modern system monitor
- **fastfetch** - neofetch alternative
- **cava** - audio visualizer
- **dunst** - notification daemon

### Development Tools
- **LSP** - Language Server Protocol integration via Neovim
- **Treesitter** - syntax highlighting and code analysis
- **Git integration** - Magit (Emacs), lazygit, fugitive (Neovim)
- **Docker** - with security-focused aliases

### Security Tools
- **Docker** - for isolated pentesting environments
- **Warp Terminal** - security-optimized config with 40+ aliases
- **Audit rules** - quick system audit commands
- **CTF aliases** - `recon`, `stealth-scan`, `burp`, `ghidra`, and more

---

## Personal Projects

These tools I built and use daily:

- **[iridex-prism-terminal](https://github.com/ind4skylivey/iridex-prism-terminal)** - custom terminal prompt with Fish personas
- **[Gleam-Observer](https://github.com/ind4skylivey/Gleam-Observer)** - process monitor for the monitor layout
- **[matteria-track](https://github.com/ind4skylivey/matteria-track)** - time tracking system
- **[archynotch](https://github.com/ind4skylivey/archynotch)** - KDE Plasma notifications layer

---

## Themes

### Cyberpunk Synthwave

A unified cyberpunk aesthetic across my dev environment - neon magenta, cyan, and deep purple. Covers Kitty Terminal, Zen Browser, Tmux, and Zellij.

**Color palette:**
```
Background:    #0d1b2a  (Deep purple-blue)
Primary:       #FF10F0  (Magenta neon)
Secondary:     #00d9ff  (Cyan neon)
Accents:       #8B5CF6  (Bright purple)
```

Quick install:
```bash
# Kitty
cp .config/kitty/kitty.conf ~/.config/kitty/
cp .config/kitty/cyberpunk-synthwave.conf ~/.config/kitty/

# Zen Browser
cp .zen-browser-config/* ~/.zen/YOUR_PROFILE_NAME/
```

Full setup guide in [CYBERPUNK_SETUP.md](CYBERPUNK_SETUP.md).

### Catppuccin Mocha

The base theme across most tools. Soft, easy on the eyes, works great for long sessions. Catppuccin Mocha with mauve accents.

### Nord

Classic cool-toned theme, available as an alternative. I switch between themes depending on the mood.

### Kanagawa

Japanese-inspired with wave patterns. Used in the Zellij status bar (zjstatus plugin).

---

## Special Features

### Eco-Workflow System

The 6-layer orchestration system described above. Makes context-switching effortless - one command gets you a fully configured environment for whatever you're doing.

### Materia Shift

The terminal theme changes based on your workflow context:
- **Bahamut** - Local dev (balanced, powerful)
- **Ice** - Writing (cold, focused)
- **Fire** - Red team (alert, danger)
- **Wind** - Remote (cloud, connection)

### Obsidian Neural Link

When you exit a session, it reads your shell history and appends a summary to your Obsidian daily note. Look back at any day and see what you were working on.

### Protocolo Fantasma

Triggered when exiting `ws-redteam`. Auto-destroys temporary Docker containers, wipes session history, clears clipboard. Clean state, no artifacts left behind.

### Multi-Monitor Support

Waybar configured for 3 monitors with:
- Independent wallpaper cycling per display
- 12 system modules (CPU, RAM, temp, network, VPN, etc.)
- Quick-launch app buttons
- Virtual desktop indicators

---

## Documentation Guides

| Guide | What it covers |
|:---|:---|
| [ECO_WORKFLOW_GUIDE.md](ECO_WORKFLOW_GUIDE.md) | The complete Eco-Workflow system |
| [KEYBINDINGS.md](KEYBINDINGS.md) | DWM, Tmux, and shell keybindings |
| [KITTY_GUIDE.md](KITTY_GUIDE.md) | Kitty terminal - 50+ keybindings and tips |
| [ZELLIJ_SETUP.md](ZELLIJ_SETUP.md) | Zellij session manager setup |
| [ZEN_BROWSER_GUIDE.md](ZEN_BROWSER_GUIDE.md) | Zen Browser cyberpunk theme |
| [CYBERPUNK_SETUP.md](CYBERPUNK_SETUP.md) | Complete cyberpunk aesthetic guide |
| [README_CYBERPUNK_UPDATE.md](README_CYBERPUNK_UPDATE.md) | Changelog for the cyberpunk update |

### Component-Specific Documentation

## Component-Specific Documentation

Everything you need to understand and customize each part of the setup.

### Editors

| Document | Description |
|:---------|:------------|
| [nvim/README.md](.config/nvim/README.md) | Neovim setup with NvChad |
| [nvim/KEYBINDINGS.md](.config/nvim/KEYBINDINGS.md) | Complete keybindings reference |

### Window Management

| Document | Description |
|:---------|:------------|
| [dwm/README.md](.config/dwm/README.md) | DWM window manager setup |
| [dwm/docs/DWM-GUIDE.md](.config/dwm/docs/DWM-GUIDE.md) | DWM configuration guide |

### Status Bars

| Document | Description |
|:---------|:------------|
| [waybar/README.md](.config/waybar/README.md) | Waybar multi-monitor setup |
| [waybar/MULTI-MONITOR.md](.config/waybar/MULTI-MONITOR.md) | Multi-monitor details |

### Terminals

| Document | Description |
|:---------|:------------|
| [kitty/CHEATSHEET.md](.config/kitty/CHEATSHEET.md) | Kitty cheatsheet (50+ keybindings) |
| [alacritty/CHEATSHEET.md](.config/alacritty/CHEATSHEET.md) | Alacritty cheatsheet |
| [warp-terminal/WARP_SETUP.md](.config/warp-terminal/WARP_SETUP.md) | Warp security config |
| [warp-terminal/WORKFLOW-OPTIMIZATION.md](.config/warp-terminal/WORKFLOW-OPTIMIZATION.md) | Warp workflow tips |

### File Browsers

| Document | Description |
|:---------|:------------|
| [yazi/](.config/yazi/) | Yazi file browser config |

### Eco-Workflow System

| Document | Description |
|:---------|:------------|
| [workflow/README.md](workflow/README.md) | Eco-Workflow philosophy |
| [workflow/profiles/local.md](workflow/profiles/local.md) | Local development profile |
| [workflow/profiles/remote.md](workflow/profiles/remote.md) | Remote SSH profile |
| [workflow/profiles/write.md](workflow/profiles/write.md) | Writing/deep work profile |
| [workflow/profiles/redteam.md](workflow/profiles/redteam.md) | Security research profile |

---

## Quick Install

Want to try it out? Here's the easy way:

```bash
# One-liner install (Arch Linux)
bash <(curl -fsSL https://raw.githubusercontent.com/ind4skylivey/dotfiles-s1b/main/bootstrap.sh)
```

Or clone and run manually:
```bash
git clone https://github.com/ind4skylivey/dotfiles-s1b.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

**After install:**
- Run `./lockscreen-setup.sh` to set up wallpapers
- Log out and back in to DWM
- Run `ws-doctor` to check everything's healthy

**Manual install (without stow):**
```bash
# Create symlinks for each config
ln -sf ~/.config/fish ~/.config/fish
ln -sf ~/.config/kitty ~/.config/kitty
# ... and so on for each tool
```

---

## Customization

Make it your own:

1. **Themes** - edit `~/.config/alacritty/alacritty.toml` or `~/.config/kitty/kitty.conf` to swap colors (Nord, Catppuccin, etc. are included)
2. **Shell** - `chsh -s /bin/fish` for interactive use, or `/bin/zsh` for POSIX compliance
3. **Window Manager** - modify `~/.config/dwm/config.h` and run `sudo make install` inside the dwm directory
4. **Workflows** - tweak layouts in `~/dotfiles/workflow/zellij/layouts/` to match your screen and habits

---

## Troubleshooting

**Shell plugins missing:**
- Fish: `fisher update`
- Zsh: delete `~/.cache/zsh` and restart

**DWM won't compile:**
- Make sure `base-devel`, `libx11`, `libxft`, `libxinerama` are installed
- `make clean install` inside the dwm directory

**Tmux plugins not loading:**
- Press `Prefix + I` (capital I) inside Tmux to fetch plugins

**Doom Emacs sync issues:**
- Run `~/.config/emacs/bin/doom sync`

**Zellij layout not loading:**
- Check that `workflow/zellij/layouts/` is in your Zellij layouts directory

---

## License

MIT - do whatever you want with it. If you build something cool from it, let me know.

---

Built with care (and too many hours of configuration). Questions, issues, or just want to chat? [Open an issue](https://github.com/ind4skylivey/dotfiles-s1b/issues).
