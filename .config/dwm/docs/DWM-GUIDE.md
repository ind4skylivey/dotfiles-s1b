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
  - `Super+a` emacsclient
  - `Super+v` legcord
  - `Super+g` burpsuite
  - `Super+b` `xdg-open https://`
  - `Super+p` / `Super+Shift+p` / `Super+Ctrl+p` flameshot full/gui/clipboard
  - `Print` flameshot gui
  - `Super+e` pcmanfm-qt
  - `Super+w` looking-glass-client; `Super+Shift+w` random wallpaper
  - `Super+Shift+s` gamescope session
  - `Super+n` zen-browser
- **Security/lock**
  - `Super+Ctrl+Shift+l` → `/home/il1v3y/lockscreen.sh` (betterlockscreen)
- **Clipboard/emoji**
  - `Super+c` cliphist | rofi | wl-copy (fallback xclip)
  - `Super+;` rofimoji copy
- **Password manager**
  - `Super+o` keepassxc
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
- **Navigation/tags**
  - `Super+Tab` last view; `Super+q` kill client
  - `Super+1..9` view; `Super+Shift+1..9` tag; Ctrl variants toggleview/toggletag
  - `Super+0` view all
  - `Super+[ / ]` shiftview; `Super+Shift+[ / ]` shifttag
  - `Super+, / .` focus monitor; `Super+Shift+, / .` tag to monitor
- **System**
  - `Super+Shift+q` quit dwm
  - `Super+Ctrl+q` rofi powermenu
  - `Super+Ctrl+Shift+r` reboot
  - `Super+Ctrl+Shift+s` suspend
- **Custom scripts** (`~/.config/dwm/scripts/`)
  - `Super+Shift+c` picom profile toggle
  - `Super+\`` scratchpad terminal
  - `Super+Shift+n` toggle-nightlight
  - `Super+Shift+x` toggle-xrandr profile
  - `Super+Shift+F12` toggle lid inhibit
  - `Super+Esc` htop (kitty)

## Mouse Bindings
- Tag bar: Mod+Button1 tag, Mod+Button3 toggletag; no Mod: view/toggleview.
- Client: Mod+Button1 moveorplace; Mod+Button3 resize.

## Rules (class → behavior/tag)
- Terminals (St/kitty/Alacritty): terminal, no swallow.
- Browsers (firefox/chrome/brave/zen): tag 2.
- Gaming: lutris, steam floating; gamescope normal.
- File managers (dolphin/pcmanfm-qt/Thunar): floating on tag 4.
- Chat (vesktop/discord/Legcord): tag 5.
- Security tools (BurpSuite, Ghidra, ZAP): tag 6; Wireshark: tag 7.
- Utilities (Pavucontrol, Blueman, nm-connection-editor, GtkFileChooserDialog, xdg-desktop-portal, pop-up): floating.
- Event Tester: noswallow.

## Status Bar
- `slstatus` as STATUSBAR; systray enabled.

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
- Apps/tools: betterlockscreen, openrgb, emacsclient, legcord, burpsuite, kitty, pcmanfm-qt, looking-glass-client, gamescope session, zen-browser.
- Clipboard/emoji/temp: cliphist, rofi, wl-copy, xclip, redshift, rofimoji.
- Monitoring: htop; power actions via systemctl.

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
