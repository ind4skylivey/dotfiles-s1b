# DWM - Dynamic Window Manager

My personal DWM configuration with custom patches and settings.

## Features

- **Systray support** - System tray integration
- **Window swallowing** - Terminals swallow GUI programs
- **Autostart** - Launch programs on startup
- **Fake fullscreen** - Fullscreen without leaving monocle layout
- **Move stack** - Move windows in stack with keybindings
- **Placemouse** - Place and resize windows with mouse
- **Pertag** - Per-tag layouts and settings
- **CFacts** - Variable client height factor
- **No border** - Remove borders for single windows
- **Win icons** - Window icons in the bar
- **Hide vacant tags** - Only show tags with windows
- **Status command** - Click actions on status bar
- **Gaps** - Configurable inner/outer gaps between windows
- **Cyclelayout** - Cycle through layouts
- **Shiftview** - Move between tags without losing focus

## Color Scheme

Custom purple/violet theme with neon accents:
- Inactive border: `#5c0099` (Deep purple)
- Active border: `#ff2200` (Neon red-orange)
- Background: `#110022` (Dark violet)
- Text: `#b388ff` (Light violet)
- Accent: `#bd00ff` (Electric purple)

## Prerequisites

### Arch Linux
```bash
sudo pacman -S base-devel libconfig dbus libev libx11 libxcb libxext \
  libgl libegl libepoxy meson pcre2 pixman uthash xcb-util-image \
  xcb-util-renderutil xorgproto cmake libxft libimlib2 libxinerama \
  libxcb-res xorg-xev xorg-xbacklight alsa-utils
```

### Debian/Ubuntu
```bash
sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev \
  libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev \
  libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev \
  libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev \
  libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev \
  libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build \
  uthash-dev cmake libxft-dev libimlib2-dev libxinerama-dev \
  libxcb-res0-dev alsa-utils
```

### Fedora/RHEL
```bash
sudo yum groupinstall "Development Tools"
sudo yum install dbus-devel gcc git libconfig-devel libdrm-devel \
  libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel \
  libGL-devel libEGL-devel libepoxy-devel meson ninja-build \
  pcre2-devel pixman-devel uthash-devel xcb-util-image-devel \
  xcb-util-renderutil-devel xorg-x11-proto-devel xcb-util-devel \
  cmake libxft-devel libimlib2-devel libxinerama-devel alsa-utils
```

## Installation

### Automated Setup
Run the setup script to install dependencies and configure environment:
```bash
chmod +x setup.sh
./setup.sh
```

This will:
- Install required dependencies for your distribution
- Install MesloLGS Nerd Font
- Clone configuration folders to `~/.config/`
- Build and install picom with animations
- Set up background wallpapers

### Manual Installation
```bash
make
sudo make install
```

A `dwm.desktop` file will be placed in `/usr/share/xsessions/` for login managers.

For xinit/startx, add to your `~/.xinitrc`:
```bash
exec dwm
```

## Key Bindings

**Modifier Key:** `Super` (Windows key)

### General
| Key | Action |
|-----|--------|
| `Super + z` | Rofi app launcher |
| `Super + x` | Terminal (kitty) |
| `Super + Alt + e` | Emacs (fresh frame) |
| `Super + v` | Legcord (Discord client) |
| `Super + g` | BurpSuite |
| `Super + b` | Zen Browser |
| `Super + n` | QuteBrowser |
| `Super + Alt + h` | Helium |
| `Super + e` | File manager (PCManFM-Qt) |
| `Super + q` | Kill focused window |
| `Super + Shift + q` | Quit DWM |
| `Super + Ctrl + q` | Power menu (rofi) |

### Window Management
| Key | Action |
|-----|--------|
| `Super + j/k` | Focus next/previous window |
| `Super + Shift + j/k` | Move window in stack |
| `Super + h/l` | Resize master area |
| `Super + Shift + h/l` | Change window height |
| `Super + Return` | Move window to master |
| `Super + i/d` | Increase/decrease master count |
| `Super + Space` | Toggle layout |
| `Super + Shift + m` | Toggle floating |
| `Super + m` | Toggle fullscreen |

### Layouts
| Key | Layout |
|-----|--------|
| `Super + t` | Tile (default) |
| `Super + f` | Floating |
| `Super + m` | Monocle |

### Tags
| Key | Action |
|-----|--------|
| `Super + 1-9` | Switch to tag |
| `Super + Shift + 1-9` | Move window to tag |
| `Super + Tab` | Last tag |
| `Super + 0` | View all tags |

### Multi-Monitor
| Key | Action |
|-----|--------|
| `Super + ,/.` | Focus left/right monitor |
| `Super + Shift + ,/.` | Move window to monitor |

### System
| Key | Action |
|-----|--------|
| `Super + p` | Screenshot full → ~/Screenshots/ |
| `Super + Shift + p` | Screenshot GUI → ~/Screenshots/ |
| `Super + Ctrl + p` | Screenshot to clipboard |
| `Super + Alt + p` | Screenshot region → clipboard |
| `Print` | Screenshot GUI |
| `Super + Escape` | System monitor (gleam) |
| `Super + Shift + b` | Toggle bar |
| `Super + Shift + w` | Randomize wallpaper |
| `Super + c` | Clipboard history |
| `Super + ;` | Emoji picker |
| `Super + o` | KeePassXC |
| `Super + ` ` ` | Scratchpad terminal |

### Media
| Key | Action |
|-----|--------|
| `Super + Up/Down` | Brightness ±10% |
| `Super + Ctrl + Up/Down` | Volume ± |
| `Super + Ctrl + m` | Mute |
| `Super + Shift + F5-F8` | Play/pause, stop, prev, next |

### Notifications & Mic
| Key | Action |
|-----|--------|
| `Super + Shift + d` | Do Not Disturb (pause dunst) |
| `Super + Shift + u` | Toggle mic mute |

### Custom Scripts
| Key | Action |
|-----|--------|
| `Super + Alt + o` | Toggle picom (transparent/solid) |
| `Super + Alt + n` | Toggle nightlight (gammastep 4500K) |
| `Super + Alt + x` | Toggle display profile (triple/solo) |
| `Super + Alt + F12` | Toggle lid inhibit (when docked) |
| `Super + Ctrl + a` | Emacs org-agenda |

## Monitor Setup

Configured for triple monitor setup:
- **DisplayPort-0** (Primary): 1920x1080 @ 180Hz
- **DisplayPort-1** (Left): 1920x1080 @ 60Hz, rotated left
- **HDMI-A-0** (Top): 1920x1080 @ 60Hz

Toggle between triple and solo mode with `Super + Alt + x`.

Edit `config.h` and recompile to adjust for your setup.

## Autostart Programs

The following programs launch automatically:
- mate-polkit (authentication agent)
- flameshot (screenshot tool, runs in tray)
- openrgb (RGB control, starts minimized)
- emacs (daemon mode)
- legcord (Discord client)
- dunst (notification daemon)
- picom (compositor)
- synergy (keyboard/mouse sharing across machines)
- slstatus (status bar)
- feh (random wallpaper on startup)
- picom (compositor)
- gammastep (nightlight, off by default)

Edit the `autostart[]` array in `config.h` to customize.

## Customization

1. Edit `config.h` to customize settings
2. Recompile: `make clean && make`
3. Reinstall: `sudo make install`
4. Restart DWM: `Super + Shift + q` then log back in

## Dependencies

### Required Programs
- **Terminal**: kitty
- **Launcher**: rofi
- **Browsers**: zen-browser, qutebrowser, helium
- **File Manager**: pcmanfm-qt
- **Screenshots**: flameshot
- **Compositor**: picom
- **Status Bar**: slstatus
- **Wallpaper**: feh
- **Notifications**: dunst

### Optional
- openrgb (RGB control)
- synergy (multi-computer keyboard/mouse sharing)
- looking-glass (VM client)
- gleam (system monitor)
- KeePassXC (password manager)
- legcord (Discord client)
- burpsuite, ghidra, zaproxy, wireshark (security tools)

## Slstatus Configuration

Slstatus configuration is included in the `slstatus/` directory. Build and install:
```bash
cd slstatus
make
sudo make install
```

## License

See LICENSE file for details.
