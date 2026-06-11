# DWM Configuration Guide

## Overview
- **Base**: dwm 6.5 built from `~/.config/dwm`; Mod key = Super (Mod4).
- **Features/Patches**: autostart array, movestack, setcfact (per-client factor), fake fullscreen toggle, cyclelayout, shiftview/shifttag, moveorplace mouse helpers, swallowfloating toggle, scratchpad via script.

## Visual Style
- **Borders**: 2 px; noborder for fullscreen; snap: 8 px.
- **Bar**: top, systray on monitor 1, spacing 6.
- **Fonts**: `MesloLGS Nerd Font Mono 11`, `NotoColorEmoji 11`.
- **Colors**
  - Normal: fg `#b388ff`, bg `#110022`, border `#5c0099`
  - Selected: fg `#ffffff`, bg `#bd00ff`, border `#ff2200`
  - Urgent: fg `#ffffff`, bg/border `#ff0000`
  - Title: fg `#ffffff`, bg `#1a0033`, border `#5c0099`
  - Layout: fg `#00ffff`, bg `#000000`, border `#5c0099`
- **Tags (icons)**: `  󰊖      `

## Layouts
- `[]=` tile (default)
- `><>` floating
- `[M]` monocle
- `lockfullscreen = 1` (keeps focus on fullscreen window)

## Autostart
- Power/blanking: `xset s off`, `xset s noblank`, `xset -dpms`, repeat rate `300 50`.
- Session env: `dbus-update-activation-environment --systemd --all`.
- Agents/apps: mate-polkit agent, dunst, picom -b, slstatus, synergy, flameshot (tray), openrgb --startminimized, emacs --daemon, legcord.
- Wallpaper: `feh --randomize --bg-fill ~/Pictures/backgrounds/*`.
- Displays (xrandr):
  - DP-0 primary 1920x1080@180 (bottom).
  - DP-1 1920x1080@60 rotated left, left of DP-0.
  - HDMI-A-0 1920x1080@60 above DP-0.

## Keybindings (Super = Mod4)
- **Launchers/apps**
  - `Super+z` rofi drun
  - `Super+x` kitty
  - `Super+Alt+e` emacsclient
  - `Super+v` legcord
  - `Super+g` burpsuite
  - `Super+b` zen-browser
  - `Super+p` / `Super+Shift+p` / `Super+Ctrl+p` / `Super+Alt+p` flameshot full/gui/clipboard/region-clipboard
  - `Print` flameshot gui
  - `Super+e` pcmanfm-qt
  - `Super+w` looking-glass-client; `Super+Shift+w` random wallpaper
  - `Super+Shift+s` gamescope session
  - `Super+n` qutebrowser
  - `Super+Alt+h` helium
- **Security/lock**
  - `Super+Ctrl+Shift+l` → `/home/il1v3y/lockscreen.sh` (betterlockscreen)
- **Clipboard/emoji**
  - `Super+c` cliphist → rofi → wl-copy (falls back to xclip on pure X11)
  - `Super+;` rofimoji copy
- **Password manager**
  - `Super+o` keepassxc

- **Media/aux shortcuts**
  - `Super+Up/Down` brightness ±10%
  - `Super+Ctrl+Up/Down` volume ±
  - `Super+Ctrl+m` mute
  - `Super+Shift+F5-F8` playerctl: play-pause/stop/prev/next
- **Color temperature**
  - `Super+F1` redshift 3500K
  - `Super+Shift+F1` redshift -x
- **Stack/layout control**
  - `Super+j/k` focus stack; `Super+Shift+j/k` move stack
  - `Super+i/d` master count ±1
  - `Super+h/l` mfact ±0.05
  - `Super+Shift+h/l` cfact ±0.25; `Super+Shift+o` cfact reset
  - `Super+Enter` zoom
  - `Super+t/f/m/space` set layouts; `Super+Ctrl+Left/Right` cycle layouts
  - `Super+Shift+m` toggle floating; `Super+Shift+y` fake fullscreen toggle

- **Notifications & mic**
  - `Super+Shift+d` dunst pause (Do Not Disturb mode)
  - `Super+Shift+u` toggle mic mute
- **Navigation/tags**
  - `Super+Tab` last view; `Super+q` kill client
  - `Super+1..9` view; `Super+Shift+1..9` tag; Ctrl variants toggleview/toggletag
  - `Super+0` view all
  - `Super+[ / ]` shiftview; `Super+Shift+[ / ]` shifttag
  - `Super+, / .` focus monitor; `Super+Shift+, / .` tag to monitor
- **System**
  - `Super+Shift+q` quit dwm
  - `Super+Ctrl+q` rofi powermenu (6 options: lock, lock blur, suspend, logout, reboot, shutdown)
  - `Super+Ctrl+Shift+r` reboot
  - `Super+Ctrl+Shift+s` suspend
- **Custom scripts** (`~/.config/dwm/scripts/`)
  - `Super+Alt+o` picom profile toggle (transparent/solid)
  - `Super+\`` scratchpad terminal
  - `Super+Alt+n` toggle nightlight (gammastep 4500K)
  - `Super+Alt+x` toggle xrandr profile (triple/solo display)
  - `Super+Alt+F12` toggle lid inhibit (when docked)
  - `Super+Esc` system monitor (gleam)

## Mouse Bindings
- Tag bar: Mod+Button1 tag, Mod+Button3 toggletag; no Mod: view/toggleview.
- Client: Mod+Button1 moveorplace; Mod+Button3 resize.

## Rules (class → behavior/tag)
- Terminals (St/kitty/Alacritty): terminal, no swallow.
- Browsers (firefox/chrome/brave/zen/zen-alpha/helium/qutebrowser): tag 2.
- Gaming: lutris, steam_app_default, retroarch, es-de floating; gamescope normal.
- File managers (dolphin/pcmanfm-qt/Thunar): floating on tag 4.
- Chat (vesktop/discord/Legcord): tag 5.
- Security tools (BurpSuite, Ghidra, ZAP): tag 6; Wireshark: tag 7.
- Utilities (Pavucontrol, Blueman, nm-connection-editor, GtkFileChooserDialog, xdg-desktop-portal, pop-up): floating.
- Event Tester: noswallow.

## Status Bar
- `slstatus` as STATUSBAR; systray enabled.

## Powermenu
- **Keybind**: `Super+Ctrl+q`
- **Script**: `~/.config/dwm/config/rofi/powermenu.sh`
- **Theme**: `~/.config/rofi/themes/powermenu.rasi` (DWM purple/violet palette)
- **Message**: "S1B Gr0uP.inc"
- **Options** (6, horizontal layout):

| Icon | Action | Command |
|------|--------|---------|
| 󰌾 | Lock | `betterlockscreen -l` |
| 󰍁 | Lock Blur | `betterlockscreen -l blur --blur 0.5` |
|  | Suspend | `mpc pause` + `amixer mute` + `systemctl suspend` |
| 󰍃 | Logout | `pkill dwm` (WM-aware) |
| 󰜉 | Reboot | `systemctl reboot` |
| 󰐥 | Shutdown | `systemctl poweroff` |

- **Theme colors**: bg #110022, surface #1a0033, accent #bd00ff, fg #b388ff, alert #ff2200
- **Font**: MesloLGS Nerd Font Mono

## Lock Screen
- Script: `/home/il1v3y/lockscreen.sh`
  - Cache update: `betterlockscreen -u ~/Pictures/screenlock/ --fx blur`
  - Lock: `betterlockscreen --lock blur --blur 0.5`
- Keybind: `Super+Ctrl+Shift+l`.

## Build/Reload
- From `~/.config/dwm`: `make` then `sudo make install`.
- Restart dwm (logout/login or `pkill -HUP dwm` if supervised).
- Installed binary: `/usr/local/bin/dwm`.

## Dependencies Referenced
- Core: X11 libs, xbacklight, amixer, dunst/notify-send, flameshot, feh, picom, synergy, slstatus, xrandr.
- Apps/tools: betterlockscreen, openrgb, emacsclient, legcord, burpsuite, kitty, pcmanfm-qt, looking-glass-client, gamescope session, zen-browser, helium, qutebrowser.
- Clipboard/emoji/temp: cliphist, rofi, wl-copy, xclip, redshift, rofimoji, protontray.
- Monitoring: gleam, htop, pavucontrol; power actions via systemctl.

## Monitors & Inputs
- Triple monitor layout coded in autostart:
  - DP-0 primary 1920x1080@180 (bottom)
  - DP-1 1920x1080@60 rotated left, left of DP-0
  - HDMI-A-0 1920x1080@60 above DP-0
- `refresh_rate = 180` aligns pointer handling with the primary monitor.

## Wallpaper Paths
- Startup random: `~/Pictures/backgrounds/*`.
- Lockscreen cache: `~/Pictures/screenlock/`.

## Troubleshooting
- Lock screen: rerun cache update; ensure `$DISPLAY`; dunst optional.
- Clipboard menu: on pure X11, switch command to xclip-only or use clipmenu/greenclip.
- Redshift: ensure `~/.config/redshift/redshift.conf` or geoclue configuration.
- Always rebuild/install after editing `config.h`.

---

## Scripts Reference

Custom scripts in `~/.config/dwm/scripts/` for extended functionality.

### scratchpad.sh
- **Purpose**: Floating terminal that toggles visibility (like a pastebin/quick-note)
- **Keybind**: `` Super+` ``
- **Behavior**: Creates a kitty instance with class "scratchpad", toggles map/unmap
- **Dependencies**: xdotool, kitty

### toggle-xrandr-profile.sh
- **Purpose**: Toggle between triple-monitor and solo display profile
- **Keybind**: `Super+Shift+x`
- **Behavior**:
  - Triple: DP-0 primary (180Hz) + DP-1 left (rotated) + HDMI-A-0 above
  - Solo: DP-0 only (180Hz)
- **State**: Persisted in `/tmp/dwm-xrandr-profile`
- **Notifications**: dunstify with profile name
- **Dependencies**: xrandr, dunstify

### apply-xrandr-layout.sh
- **Purpose**: Auto-detect connected monitors and apply best layout
- **Keybind**: Not bound (manual use only)
- **Behavior**: Reads connected outputs from xrandr, builds command dynamically
- **Dependencies**: xrandr

### toggle-nightlight.sh
- **Purpose**: Toggle color temperature adjustment (blue light filter)
- **Keybind**: `Super+Alt+n`
- **Behavior**:
  - On: gammastep at 4500K
  - Off: kill gammastep
- **Notifications**: dunstify status
- **Dependencies**: gammastep, dunstify

### toggle-lid-inhibit.sh
- **Purpose**: Prevent laptop lid close from suspending when docked
- **Keybind**: `Super+Alt+F12`
- **Behavior**:
  - On: systemd-inhibit handle-lid-switch
  - Off: follow default behavior
- **Notifications**: dunstify "Laptop lid follows default behavior" or "Lid switch inhibited (docked)"
- **Dependencies**: systemd-inhibit, dunstify

### vol-raise.sh / vol-lower.sh / vol-mute.sh
- **Purpose**: PulseAudio volume control with notifications
- **Keybinds**: `Super+Ctrl+Up` / `Super+Ctrl+Down` / `Super+Ctrl+m`
- **Behavior**: Adjusts default sink volume by 5%, shows dunst notification with current level
- **Dependencies**: pactl, dunstify

### cliphist-select.sh
- **Purpose**: Browse and select from clipboard history
- **Keybind**: `Super+c`
- **Behavior**: Opens rofi with recent clipboard entries, selected item copied to clipboard
- **Dependencies**: cliphist, rofi, wl-copy (falls back to xclip on pure X11)

---

## Daily Workflow

### Typical Session
1. Login → DWM starts → autostart runs all daemons
2. `Super+z` → rofi drun → launch apps
3. Windows auto-tagged by rules (browsers → tag 2, chat → tag 5)
4. `Super+1..9` navigate tags, `Super+Shift+1..9` move windows

### Window Management Flow
```
1. Open app → auto-tagged by class rule
2. Super+j/k → cycle focus in stack
3. Super+h/l → adjust mfact (master width)
4. Super+Enter → zoom/swap with master
5. Super+Shift+f → toggle floating
6. Super+Shift+y → fake fullscreen (single window, bar visible)
```

### Quick Actions
- **Screenshot**: `Super+p` (full), `Super+Shift+p` (gui), `Super+Ctrl+p` (clipboard), `Super+Alt+p` (region→clipboard)
- **Clipboard history**: `Super+c` → rofi → select → wl-copy
- **Emoji picker**: `Super+;` → rofimoji
- **Scratchpad**: `` Super+` `` → type notes → toggle off

### Multi-Monitor Workflow
- `Super+,` / `Super+.` → focus monitor left/right
- `Super+Shift+,` / `Super+Shift+.` → tag window to monitor
- `Super+Shift+x` → toggle triple/solo display

### Power Management
- Lock: `Super+Ctrl+Shift+l` → betterlockscreen
- Menu: `Super+Ctrl+q` → rofi powermenu
- Suspend: `Super+Ctrl+Shift+s`
- Reboot: `Super+Ctrl+Shift+r`

---

## Extended Style

### Picom Compositor Profiles

Located in `~/.config/picom/`:

#### picom.conf (Transparent - Default)
```ini
backend = "xrender"
vsync = false
fading = false
active-opacity = 1.0
inactive-opacity = 1.0
opacity-rule = [
  "100:class_g = 'warp'",
  "90:class_g = 'kitty'"
]
```
- Better visuals, subtle transparency on kitty
- Use for general desktop use

#### picom-solid.conf (Solid - Performance)
```ini
# Same as above but with:
inactive-opacity = 1.0
# No opacity rules
```
- Toggle with `Super+Shift+c`
- Better performance for gaming, FPS games

### Rofi Configuration

Main config: `~/.config/dwm/config/rofi/config.rasi`
```rasi
configuration {
  show-icons: true;
  icon-theme: "Papirus";
  display-drun: " ";
  display-window: " ";
  display-combi: "  ";
}
@theme "themes/cybers1b.rasi"
```

Themes available:
- `cybers1b.rasi` - App launcher (Cyberpunk HUD + Tech Sidebar)
- `powermenu.rasi` - Power menu (Purple/Violet palette)

### Terminal Colors (kitty/alacritty)

Both use Nordic theme in `~/.config/dwm/config/`:

#### kitty/nord.conf
- Background: `#2E3440`
- Foreground: `#D8DEE9`
- Accent: `#88C0D0` (cyan), `#A3BE8C` (green), `#BF616A` (red)

#### alacritty/nordic.toml
- Same palette as kitty
- Nordic theme port

### Wallpaper Rotation

- **Startup**: `feh --randomize --bg-fill ~/Pictures/backgrounds/*`
- **Manual**: `Super+Shift+w` (random from directory)
- **Custom**: Add images to `~/Pictures/backgrounds/`

---

## Setup & Maintenance

### Automated Setup

Run `setup.sh` for one-time installation:
```bash
cd ~/.config/dwm
./setup.sh
```

What it does:
1. Detects OS (Debian/Ubuntu, RHEL/Fedora, Arch)
2. Installs build dependencies
3. Installs Meslo Nerd Font
4. Copies config folders to `~/.config/`
5. Builds picom with animations (optional)
6. Creates wallpaper directory

### Manual Build

```bash
cd ~/.config/dwm
make clean
make
sudo make install
```

### Reload DWM

Without logout:
```bash
pkill -HUP dwm
```

Or if using a session manager, log out and back in.

### Rebuild After Changes

Always rebuild after editing:
- `config.h` (main DWM config)
- `slstatus/config.h` (status bar)
- Any patch applied

### Dependency Check

Core build:
- libconfig-dev, libdbus-1-dev, libev-dev
- libx11-xcb-dev, libxcb1-dev, libxcb-util-dev
- libxft-dev, libimlib2-dev, libxinerama-dev

Runtime:
- X11, xbacklight, amixer
- dunst, flameshot, feh, picom
- slstatus, xrandr
- betterlockscreen, redshift/gammastep
- cliphist, rofi, rofimoji
- kitty, emacsclient

### File Structure

```
~/.config/dwm/
├── DWM-GUIDE.md           # This guide
├── config.h               # DWM source config
├── config.mk              # Build config
├── Makefile               # Build system
├── dwm.c                  # Main source
├── dwm.desktop            # Login manager entry
├── .xinitrc               # X session start
├── setup.sh               # Automated setup
├── autostart              # Autostart script
├── slstatus/              # Status bar
│   ├── config.h
│   └── Makefile
├── scripts/               # Custom scripts
│   ├── scratchpad.sh
│   ├── toggle-xrandr-profile.sh
│   ├── toggle-nightlight.sh
│   ├── toggle-lid-inhibit.sh
│   ├── picom-profile-toggle.sh
│   ├── vol-raise.sh
│   ├── vol-lower.sh
│   ├── vol-mute.sh
│   ├── cliphist-select.sh
│   └── apply-xrandr-layout.sh
├── config/                # App configs
│   ├── rofi/
│   ├── kitty/
│   └── alacritty/
└── dwmblocks/             # Optional blocks
```

### Key Files to Customize

| File | Purpose | Requires Rebuild |
|------|---------|------------------|
| `config.h` | Keybinds, colors, rules, layouts | Yes |
| `slstatus/config.h` | Status bar format | Yes |
| `config/rofi/*.rasi` | Rofi theme | No (reload rofi) |
| `config/kitty/kitty.conf` | Terminal settings | No (restart terminal) |
| `~/.config/picom/picom.conf` | Compositor | Yes (restart picom) |

### Symlink Architecture

App configs use **symlinks** from runtime paths to templates:

```
~/.config/rofi/config.rasi        → ~/.config/dwm/config/rofi/config.rasi
~/.config/rofi/powermenu.sh      → ~/.config/dwm/config/rofi/powermenu.sh
~/.config/rofi/themes/*.rasi      → ~/.config/dwm/config/rofi/themes/*.rasi
```

**Source of truth**: Always edit files in `~/.config/dwm/config/`. Changes reflect instantly at runtime.

**setup.sh** uses symlinks (not `cp -r`), so re-running it won't overwrite local changes.

---

## Quick Reference Card

```
MOD = Super (Mod4)

LAUNCH     : Super+z    TERMINAL   : Super+x    BROWSER : Super+n/Alt+h/b
EMACS      : Super+Alt+e    FILEMGR    : Super+e    CHAT    : Super+v
GAMES      : Super+Shift+s   LOCK      : Super+Ctrl+Shift+l

FOCUS      : j/k       MOVE       : Shift+j/k
MASTER     : i/d       MFACT     : h/l         ZOOM    : Enter
LAYOUT     : t/f/m/space   FLOAT    : Shift+f    FFULL  : Shift+y

TAG        : 1-9       VIEW      : 1-9         ALL     : 0
LAST       : Tab       SHIFT     : Shift+1-9   KILL    : q

MONITOR    : ,/.       TAG-MON   : Shift+,/.

SYS        : Ctrl+q    SUSPEND   : Ctrl+Shift+s
REBOOT     : Ctrl+Shift+r       REFRESH   : HUP dwm
```
