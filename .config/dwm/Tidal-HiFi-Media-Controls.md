# Tidal-HiFi Media Controls Guide

## 🎵 Playback Controls

| Action | Keybinding | Command |
|--------|-----------|---------|
| Play/Pause | `Super + Ctrl + Space` | `playerctl play-pause` |
| Stop | `Super + Shift + Space` | `playerctl stop` |
| Previous Track | `Super + Shift + ←` | `playerctl previous` |
| Next Track | `Super + Shift + →` | `playerctl next` |

## 🔊 Volume Controls

### Using Multimedia Keys (Physical Media Keys)
| Action | Key | Command |
|--------|-----|---------|
| Volume Down | `XF86AudioLowerVolume` | `amixer sset Master 5%-` |
| Volume Up | `XF86AudioRaiseVolume` | `amixer sset Master 5%+` |
| Mute/Unmute | `XF86AudioMute` | `amixer sset Master toggle` |

### Using Keyboard Shortcuts
| Action | Keybinding | Command |
|--------|-----------|---------|
| Volume Down | `Super + Ctrl + ↓` | `pactl set-sink-volume @DEFAULT_SINK@ -5%` |
| Volume Up | `Super + Ctrl + ↑` | `pactl set-sink-volume @DEFAULT_SINK@ +5%` |
| Mute/Unmute | `Super + Ctrl + m` | `pactl set-sink-mute @DEFAULT_SINK@ toggle` |

## 📝 Notes

- `MODKEY` = `Super` (Windows key)
- All controls use `playerctl` for media playback, which works with Tidal-HiFi
- Volume notifications are shown via `dunst`
