# Cyberpunk Synthwave Aesthetic - Complete Setup Guide

**A unified cyberpunk synthwave theme for your entire development environment: Kitty Terminal, Zen Browser, Tmux, and Zellij.**

---

## 🎨 Overview

This dotfiles repository now includes a complete cyberpunk synthwave aesthetic package for maximum productivity and eye-catching visuals.

### What's Included
✅ **Kitty Terminal** - Optimized terminal with 40+ keybindings  
✅ **Zen Browser** - Matching browser theme with neon accents  
✅ **Tmux Integration** - True color support and keybindings  
✅ **Zellij Integration** - Complete theme configuration  
✅ **Color Scheme** - Consistent cyberpunk palette across all tools  

---

## 📁 Directory Structure

```
dotfiles-s1b/
├── .config/kitty/
│   ├── kitty.conf                    # Main Kitty configuration
│   ├── cyberpunk-synthwave.conf      # Color scheme
│   └── tmux-zellij-integration.conf  # Multiplexer integration guide
├── .zen-browser-config/
│   ├── prefs.js                      # Zen Browser preferences
│   └── chrome/
│       └── userChrome.css            # Browser UI styling
├── KITTY_GUIDE.md                    # Complete Kitty documentation
├── ZEN_BROWSER_GUIDE.md              # Complete Zen Browser documentation
└── CYBERPUNK_SETUP.md                # This file
```

---

## 🎨 Color Palette

All tools use the same cyberpunk synthwave colors for consistency:

```
🟣 Background (Deep Purple-Blue)     #0d1b2a
💜 Primary Accent (Magenta Neon)     #FF10F0
🔵 Secondary Accent (Cyan Neon)      #00d9ff
⚫ Dark Elements (Dark Purple)        #1a1a3e
🟣 Highlights (Bright Purple)        #8B5CF6
```

### Visual Reference
```
┌─────────────────────────────────────────┐
│ ╔════════════════════════════════════╗  │  ← Magenta neon border
│ ║ Zen Browser Tab (Active)           ║  │
│ ╚════════════════════════════════════╝  │
│ ┌─────────────────────────────────────┐ │  ← Cyan border
│ │ URL: https://example.com           │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ [Sidebar in bright purple]              │
│ ├─ Home                                 │
│ ├─ Settings                             │
│ └─ Extensions                           │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ il1v3y@machine ~ 🚀                    │  ← Kitty terminal
│ ► _                                     │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🚀 Quick Installation

### 1. Kitty Terminal Setup

```bash
# Copy Kitty configs
cp .config/kitty/kitty.conf ~/.config/kitty/
cp .config/kitty/cyberpunk-synthwave.conf ~/.config/kitty/
cp .config/kitty/tmux-zellij-integration.conf ~/.config/kitty/

# Restart Kitty
killall kitty
kitty &
```

### 2. Zen Browser Setup

```bash
# Find your Zen profile
ls ~/.zen/

# Copy files to your profile (replace PROFILE_NAME)
cp .zen-browser-config/prefs.js ~/.zen/PROFILE_NAME/
cp .zen-browser-config/chrome/userChrome.css ~/.zen/PROFILE_NAME/chrome/

# Restart Zen
killall zen
zen &
```

### 3. Tmux Integration (OPTIONAL)

**Important**: This is completely optional! Keep your personal Tmux config if it's working well.

If you want true color support, add to `~/.tmux.conf`:
```bash
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",tmux-256color:RGB"
set -ga terminal-overrides ",xterm-kitty:RGB"
set -s allow-passthrough on
```

See `.config/kitty/tmux-zellij-integration.conf` for detailed recommendations.

### 4. Zellij Integration (OPTIONAL)

**Important**: This is completely optional! Keep your personal Zellij config if it's working well.

Add to `~/.config/zellij/config.kdl`:
```bash
themes {
    cyberpunk {
        bg "#0d1b2a"
        fg "#e8e8e8"
        black "#2e2e2e"
        red "#ff10f0"
        green "#00d9ff"
        yellow "#d084d1"
        blue "#6b46c1"
        magenta "#ff10f0"
        cyan "#00d9ff"
        white "#e8e8e8"
    }
}

theme "cyberpunk"
```

---

## ⌨️ Essential Keybindings

### Kitty Terminal

**Navigation**
```
Ctrl+Left/Right/Up/Down    → Move between windows
Ctrl+Shift+T               → New tab
Ctrl+Shift+W               → Close tab
Ctrl+Shift+L/H             → Next/previous tab
```

**Power Tools**
```
Ctrl+Alt+N                 → Open Neovim
Ctrl+Alt+M                 → BTOp monitor
Ctrl+Alt+B                 → Git branches
Ctrl+Alt+Shift+D           → Docker stats
```

**Full list** → See `KITTY_GUIDE.md`

---

## 📚 Detailed Guides

### Kitty Terminal
Read **KITTY_GUIDE.md** for:
- Complete keybindings reference (40+ shortcuts)
- Performance optimization settings
- Customization options
- Troubleshooting

### Zen Browser
Read **ZEN_BROWSER_GUIDE.md** for:
- Theme customization
- Configuration details
- Integration with other tools
- CSS modifications

### Tmux & Zellij
See `.config/kitty/tmux-zellij-integration.conf` for:
- Tmux configuration
- Zellij setup
- Color scheme integration

---

## 🎯 Workflow Integration

### Development Workflow
```bash
# 1. Open Kitty (cyberpunk aesthetic)
kitty &

# 2. Start Tmux/Zellij session
tmux new-session -s dev

# 3. Open Zen Browser for documentation
zen &

# 4. Use Ctrl+Alt+N to open Neovim for coding
Ctrl+Alt+N
```

### Red Team/Security Research
```bash
# Quick network monitoring
Ctrl+Alt+W  # Network manager
Ctrl+Alt+T  # Network monitor (nethogs)

# System audit
Ctrl+Alt+Shift+A  # Audit rules

# Container management
Ctrl+Alt+Shift+D  # Docker stats
```

### System Administration
```bash
# System monitoring
Ctrl+Alt+M  # BTOp (system monitor)
Ctrl+Alt+I  # System info

# Process management
Ctrl+Alt+P  # Process list with fzf

# Disk & files
Ctrl+Alt+Shift+F  # LF file browser
```

---

## 🔧 Customization

### Change Colors Globally

**Kitty** - Edit `cyberpunk-synthwave.conf`:
```bash
foreground #E8E8E8
background #0d1b2a
color1 #FF10F0   # Magenta
color2 #00d9ff   # Cyan
```

**Zen Browser** - Edit `.zen-browser-config/prefs.js`:
```javascript
user_pref("zen.theme.accent-color", "#FF10F0");
user_pref("mod.sameerasw.zen_transparency_color", "#8B5CF6");
```

### Add Custom Keybindings

**Kitty** - Add to `kitty.conf`:
```bash
map ctrl+alt+y launch --type=overlay fish -c "your-command"
```

---

## 🐛 Troubleshooting

### Kitty
- **Config not loading**: `kitty --debug-config`
- **Colors wrong**: Verify `TERM=xterm-kitty`
- **Keybindings broken**: Check for syntax errors in `kitty.conf`

### Zen Browser
- **CSS not applying**: Enable `toolkit.legacyUserProfileCustomizations.stylesheets`
- **Sidebar dark**: Verify `mod.sameerasw.zen_transparency_color` in `prefs.js`
- **Colors not syncing**: Restart Zen completely

### Tmux/Zellij
- **Colors not showing**: Add `set -ga terminal-overrides ",xterm-kitty:RGB"`
- **Keys not working**: Enable `set -s allow-passthrough on`

---

## 📊 Performance

### Terminal Performance
- Rendering optimized (10ms repaint delay)
- Low CPU usage
- 10,000 line scrollback buffer
- Minimal memory footprint

### Browser Performance
- CSS-only styling (no extensions)
- No performance impact
- Smooth animations at 60fps
- Lightweight theme

---

## 🔗 Related Configurations

This setup pairs well with:
- **Shell**: Fish Shell (see `.config/fish/config.fish`)
- **Editor**: Neovim (dark theme recommended)
- **Multiplexer**: Tmux or Zellij
- **Wallpaper**: Dark background matching `#0d1b2a`

---

## 📝 File Manifest

| File | Purpose |
|------|---------|
| `kitty.conf` | Main Kitty terminal configuration |
| `cyberpunk-synthwave.conf` | Terminal color scheme |
| `tmux-zellij-integration.conf` | Multiplexer integration guide |
| `prefs.js` | Zen Browser preferences |
| `userChrome.css` | Zen Browser UI styling |
| `KITTY_GUIDE.md` | Complete Kitty documentation |
| `ZEN_BROWSER_GUIDE.md` | Complete Zen Browser documentation |
| `CYBERPUNK_SETUP.md` | This overview file |

---

## 🚀 Next Steps

1. **Install** - Follow Quick Installation above
2. **Customize** - Adjust colors and keybindings to your preference
3. **Optimize** - Configure Tmux/Zellij for your workflow
4. **Enjoy** - Embrace the cyberpunk aesthetic! 🌆💜

---

## 👤 Author

**ind4skylivey** - Security researcher & developer

- GitHub: https://github.com/ind4skylivey
- Theme: Cyberpunk Synthwave
- Status: Production Ready
- Last Updated: 2026-01-07

---

## 📜 License

See LICENSE file in repository root.

---

## 💡 Tips for Maximum Cyberpunk Experience

1. **Wallpaper** - Use dark background matching `#0d1b2a`
2. **Terminal Font** - MesloLGS Nerd Font Mono (already configured)
3. **GTK Theme** - Consider dark GTK theme for system consistency
4. **Sound** - Disable terminal bells for cleaner experience
5. **Multiple Workspaces** - Use different Tmux/Zellij sessions per project

---

Enjoy your cyberpunk development environment! 🚀✨
