# 🌆 Cyberpunk Synthwave Update - dotfiles-s1b

**New complete cyberpunk aesthetic setup for Kitty Terminal and Zen Browser with unified color scheme, 40+ professional keybindings, and comprehensive documentation.**

---

## 📦 What's New

### ✨ Kitty Terminal - Complete Overhaul
- **Color Scheme**: Cyberpunk Synthwave with neon magenta & cyan
- **Keybindings**: 40+ professional shortcuts for development & red team
- **Performance**: Optimized rendering, scrollback, and memory usage
- **Integration**: Seamless Tmux & Zellij support
- **Documentation**: Complete KITTY_GUIDE.md with all features

### 🌐 Zen Browser - Professional Theme
- **Visual Design**: Matching cyberpunk synthwave theme
- **Sidebar**: Bright purple aesthetic
- **Accents**: Neon magenta & cyan throughout UI
- **Documentation**: Complete ZEN_BROWSER_GUIDE.md with customization

### 📚 Documentation
- `CYBERPUNK_SETUP.md` - Complete overview & quick start
- `KITTY_GUIDE.md` - 40+ keybindings, customization, troubleshooting
- `ZEN_BROWSER_GUIDE.md` - Browser theme, configuration, integration

---

## 📁 New Files Added

```
dotfiles-s1b/
├── .config/kitty/
│   ├── kitty.conf                    # NEW: Main Kitty configuration (200+ lines)
│   ├── cyberpunk-synthwave.conf      # NEW: Color scheme definition
│   └── tmux-zellij-integration.conf  # NEW: Multiplexer integration guide
├── .zen-browser-config/              # NEW: Zen Browser configuration
│   ├── prefs.js                      # Browser preferences
│   └── chrome/
│       └── userChrome.css            # Browser UI styling
├── CYBERPUNK_SETUP.md                # NEW: Complete setup overview
├── KITTY_GUIDE.md                    # NEW: Detailed Kitty documentation
└── ZEN_BROWSER_GUIDE.md              # NEW: Detailed Zen Browser documentation
```

---

## 🎨 Color Palette

All tools unified under one cyberpunk synthwave aesthetic:

```
🟣 Background:        #0d1b2a  (Deep purple-blue)
💜 Primary Accent:    #FF10F0  (Magenta neon - highly visible)
🔵 Secondary Accent:  #00d9ff  (Cyan neon - highlights)
⚫ Dark Elements:      #1a1a3e  (Dark purple - panels)
🟣 Sidebar/Highlights: #8B5CF6  (Bright purple - accents)
```

---

## ⌨️ Key Features - Kitty Terminal

### Basic Navigation (4 shortcuts)
```
Ctrl+Left/Right/Up/Down  → Navigate windows
```

### Tab Management (5 shortcuts)
```
Ctrl+Shift+T/W/L/H/R     → Tab operations
```

### Development Tools (10+ shortcuts)
```
Ctrl+Alt+N               → Open Neovim
Ctrl+Alt+M               → BTOp monitor
Ctrl+Alt+G               → Git log
Ctrl+Alt+Shift+D         → Docker stats
Ctrl+Alt+Shift+P         → Dependencies list
Ctrl+Alt+Shift+S         → Find TODOs/FIXMEs
```

### System Tools (8+ shortcuts)
```
Ctrl+Alt+P               → Process list
Ctrl+Alt+I               → System info
Ctrl+Alt+Shift+A         → Audit rules
Ctrl+Alt+Shift+X         → System logs
```

### File Browsers (3 shortcuts)
```
Ctrl+Alt+Shift+F         → LF (fast)
Ctrl+Alt+Shift+N         → NNN
Ctrl+Alt+Shift+T         → Tree view
```

**Full list** → See `KITTY_GUIDE.md` (50+ keybindings documented)

---

## 🌟 Zen Browser Features

### Theme Integration
- **Matching Color Scheme**: Same as Kitty terminal
- **Neon Accents**: Magenta tabs, cyan borders
- **Dark Mode**: Comfortable for long sessions
- **Purple Sidebar**: Professional appearance

### Browser UI
- URL bar with cyan borders and magenta focus state
- Active tabs with neon glow effect
- Sidebar in bright purple
- Hover effects on all interactive elements

---

## 🚀 Quick Start

### 1. Install Kitty Configuration
```bash
cp .config/kitty/kitty.conf ~/.config/kitty/
cp .config/kitty/cyberpunk-synthwave.conf ~/.config/kitty/
cp .config/kitty/tmux-zellij-integration.conf ~/.config/kitty/

killall kitty
kitty &
```

### 2. Install Zen Browser Theme
```bash
# Find your Zen profile
ls ~/.zen/

# Copy configuration (replace PROFILE_NAME)
cp .zen-browser-config/prefs.js ~/.zen/PROFILE_NAME/
cp .zen-browser-config/chrome/userChrome.css ~/.zen/PROFILE_NAME/chrome/

killall zen
zen &
```

### 3. Configure Tmux (OPTIONAL - Keep Your Personal Config!)
Add to `~/.tmux.conf` **only if you want true color support**:
```bash
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",tmux-256color:RGB"
set -ga terminal-overrides ",xterm-kitty:RGB"
```

**Note**: This is completely optional! If you already have Tmux optimized, skip this.

See `.config/kitty/tmux-zellij-integration.conf` for detailed recommendations.

### 4. Configure Zellij (OPTIONAL - Keep Your Personal Config!)
Add to `~/.config/zellij/config.kdl` **only if you want to match the cyberpunk colors**:
```bash
themes {
    cyberpunk {
        bg "#0d1b2a"
        fg "#e8e8e8"
        red "#ff10f0"
        green "#00d9ff"
        # ... (see CYBERPUNK_SETUP.md for full config)
    }
}
theme "cyberpunk"
```

**Note**: This is completely optional! If you have a custom theme, keep it!

---

## 📖 Documentation Structure

### CYBERPUNK_SETUP.md
- **Purpose**: Complete overview of entire setup
- **Contents**: Quick install, color palette, workflow integration
- **Audience**: Everyone - start here

### KITTY_GUIDE.md
- **Purpose**: Detailed Kitty documentation
- **Contents**: 50+ keybindings, customization, troubleshooting
- **Audience**: Kitty users
- **Length**: Comprehensive (~400 lines)

### ZEN_BROWSER_GUIDE.md
- **Purpose**: Detailed Zen Browser documentation
- **Contents**: Theme features, customization, CSS modifications
- **Audience**: Zen Browser users
- **Length**: Comprehensive (~350 lines)

---

## 🎯 Workflow Examples

### Web Development
```bash
# 1. Start Kitty (already has cyberpunk theme)
kitty &

# 2. Open Zen Browser for documentation
Ctrl+Alt+Z  # (custom keybinding to launch Zen)

# 3. Open editor
Ctrl+Alt+N  # Opens Neovim

# 4. Monitor system
Ctrl+Alt+M  # Opens BTOp

# 5. Check git status
Ctrl+Alt+X  # Git status
```

### Red Team / Security Research
```bash
# Quick network monitoring
Ctrl+Alt+W  # Network manager
Ctrl+Alt+T  # Network monitor (nethogs)

# System audit
Ctrl+Alt+Shift+A  # Audit rules
Ctrl+Alt+Shift+X  # System logs

# Container management
Ctrl+Alt+Shift+D  # Docker stats
Ctrl+Alt+Shift+C  # Podman ps
```

### System Administration
```bash
# Full system overview
Ctrl+Shift+C  # CPU & memory
Ctrl+Alt+I    # System info (inxi)

# Monitor processes
Ctrl+Alt+P    # Process list
Ctrl+Alt+M    # BTOp

# File management
Ctrl+Alt+Shift+F  # LF browser
Ctrl+Alt+Shift+N  # NNN browser
```

---

## 🔧 Customization

### Change Terminal Colors
Edit `cyberpunk-synthwave.conf`:
```bash
foreground #E8E8E8
background #0d1b2a
color1 #FF10F0   # Red/Magenta
color2 #00d9ff   # Green/Cyan
```

### Change Browser Theme
Edit `.zen-browser-config/prefs.js`:
```javascript
user_pref("zen.theme.accent-color", "#FF10F0");
user_pref("mod.sameerasw.zen_transparency_color", "#8B5CF6");
```

### Add Custom Keybindings
Edit `kitty.conf` and add:
```bash
map ctrl+alt+custom launch --type=overlay fish -c "your-command"
```

---

## 📊 Statistics

- **Kitty Configuration**: 200+ lines, 50+ keybindings
- **Color Scheme**: 5 main colors, 13 terminal colors defined
- **Browser Configuration**: 2 files (prefs.js + userChrome.css)
- **Documentation**: 1,500+ lines across 3 guides
- **Total Files Added**: 8 files
- **Setup Time**: ~5 minutes

---

## ✅ What Works Out of the Box

- ✅ Cyberpunk color theme (Terminal + Browser)
- ✅ All 50+ keybindings functional
- ✅ Performance optimizations active
- ✅ Tmux & Zellij integration ready
- ✅ Browser UI fully themed
- ✅ Development tools accessible
- ✅ Security tools configured

---

## 🐛 Troubleshooting

### Kitty Issues
1. **Config not loading**: `kitty --debug-config`
2. **Colors wrong**: Check `TERM=xterm-kitty`
3. **Keys not working**: Verify keybinding syntax

### Zen Browser Issues
1. **CSS not applying**: Verify `toolkit.legacyUserProfileCustomizations.stylesheets = true`
2. **Sidebar dark**: Check `mod.sameerasw.zen_transparency_color` in prefs.js
3. **Restart completely**: `killall zen && zen &`

See detailed guides for more troubleshooting.

---

## 📚 Additional Resources

- **Kitty Docs**: https://sw.kovidgoyal.net/kitty/
- **Zen Browser**: https://zen-browser.app/
- **Tmux Guide**: https://github.com/tmux/tmux/wiki
- **Zellij**: https://zellij.dev/

---

## 🎯 Next Steps

1. **Read** `CYBERPUNK_SETUP.md` for overview
2. **Install** Kitty configuration (5 minutes)
3. **Install** Zen Browser theme (2 minutes)
4. **Customize** colors if desired (optional)
5. **Configure** Tmux/Zellij for your workflow (optional)

---

## 👤 Author & Credit

**ind4skylivey** - Security researcher & developer

- GitHub: https://github.com/ind4skylivey
- Repository: dotfiles-s1b
- Theme: Cyberpunk Synthwave
- Status: Production Ready ✅

---

## 📝 Version Info

- **Version**: 1.0 (Initial Release)
- **Date**: 2026-01-07
- **Status**: Stable & Production Ready
- **Compatibility**: 
  - Kitty 0.26+
  - Zen Browser (Firefox-based)
  - Fish Shell
  - Tmux 3.0+
  - Zellij 0.30+
  - Linux/macOS/Windows

---

## 💜 Enjoy Your Cyberpunk Setup!

```
 ╔═══════════════════════════════════╗
 ║     Cyberpunk Synthwave Theme     ║
 ║  Kitty Terminal + Zen Browser     ║
 ║        Production Ready 🚀        ║
 ╚═══════════════════════════════════╝
```

Your development environment is now fully cyberpunk-themed and optimized! 🌆✨
