# Cyberpunk Synthwave Update

So I finally did it. I went all-in on the cyberpunk aesthetic across my dev environment, and honestly, I'm pretty happy with how it turned out.

---

## What I Added

### Kitty Terminal Overhaul

The terminal got a complete rewrite. New color scheme, better keybindings, and I documented everything so I don't forget how it all works.

The color scheme is a dark purple-blue base with neon magenta and cyan accents — the kind of thing that looks great in screenshots but is actually pretty easy on the eyes for long sessions. I optimized the rendering settings too; Kitty was already fast, but it feels snappier now.

I also spent way too long putting together keybindings for all the tools I use regularly. Git, Docker, process monitors, file browsers — it's all bound now. No more typing out `docker stats` every time I want to check if a container's running.

### Zen Browser Theme

Zen Browser was already my daily driver, but it didn't match the terminal. Now it does. Purple sidebar, magenta tabs, cyan borders — same palette, cohesive look. It makes switching between browser and terminal feel less jarring.

### Documentation

I wrote up three guides so I don't have to figure this stuff out twice:
- `CYBERPUNK_SETUP.md` — the overview and quick start
- `KITTY_GUIDE.md` — the full Kitty reference
- `ZEN_BROWSER_GUIDE.md` — browser configuration and tricks

---

## The Files

```
dotfiles-s1b/
├── .config/kitty/
│   ├── kitty.conf                    # Main config (200+ lines)
│   ├── cyberpunk-synthwave.conf      # Color scheme
│   └── tmux-zellij-integration.conf  # Multiplexer tips
├── .zen-browser-config/              # Zen Browser theming
│   ├── prefs.js                     # Preferences
│   └── chrome/
│       └── userChrome.css           # UI styling
├── CYBERPUNK_SETUP.md
├── KITTY_GUIDE.md
└── ZEN_BROWSER_GUIDE.md
```

---

## Color Palette

The whole thing runs on this palette:

```
Background:        #0d1b2a  (Deep purple-blue)
Primary Accent:    #FF10F0  (Magenta neon)
Secondary Accent:  #00d9ff  (Cyan neon)
Dark Elements:     #1a1a3e  (Panels, inactive tabs)
Highlights:        #8B5CF6  (Bright purple)
```

The magenta and cyan pop against the dark background without being headache-inducing. I tried a few variations — going too bright just hurts your eyes after an hour.

---

## Kitty Keybindings

Here's what I use most:

**Navigation:**
```
Ctrl+Arrow keys     → Move between windows
```

**Tabs:**
```
Ctrl+Shift+T        → New tab
Ctrl+Shift+W        → Close tab
Ctrl+Shift+L/H/R    → Tab operations
```

**Development tools:**
```
Ctrl+Alt+N          → Neovim
Ctrl+Alt+M          → BTOp (system monitor)
Ctrl+Alt+G          → Git log
Ctrl+Alt+Shift+D    → Docker stats
Ctrl+Alt+Shift+S    → Find TODOs/FIXMEs
```

**System stuff:**
```
Ctrl+Alt+P          → Process list
Ctrl+Alt+I          → System info
Ctrl+Alt+Shift+A    → Audit rules
Ctrl+Alt+Shift+X    → System logs
```

**File browsers:**
```
Ctrl+Alt+Shift+F    → LF
Ctrl+Alt+Shift+N    → NNN
Ctrl+Alt+Shift+T    → Tree view
```

The full list in `KITTY_GUIDE.md` has 50+ bindings.

---

## Browser Theme

The browser UI now matches the terminal:

**URL bar** — dark background with cyan border, magenta glow on focus

**Tabs** — inactive ones are dark purple with cyan border, active tab glows magenta

**Sidebar** — bright purple, high contrast icons

**Menus** — dark with magenta borders, cyan text

---

## Quick Start

### Install Kitty

```bash
cp .config/kitty/kitty.conf ~/.config/kitty/
cp .config/kitty/cyberpunk-synthwave.conf ~/.config/kitty/
cp .config/kitty/tmux-zellij-integration.conf ~/.config/kitty/

killall kitty
kitty &
```

### Install Zen Browser

```bash
# Find your profile
ls ~/.zen/

# Copy config (replace PROFILE_NAME)
cp .zen-browser-config/prefs.js ~/.zen/PROFILE_NAME/
cp .zen-browser-config/chrome/userChrome.css ~/.zen/PROFILE_NAME/chrome/

killall zen
zen &
```

### Tmux/Zellij (Optional)

If you want true color support in Tmux, add to `~/.tmux.conf`:
```bash
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",tmux-256color:RGB"
set -ga terminal-overrides ",xterm-kitty:RGB"
```

For Zellij, there's a cyberpunk theme option in the integration guide. Completely optional — if you have your own theme, keep it.

---

## Workflow Examples

### Web Development

```bash
# Start terminal with cyberpunk theme
kitty &

# Open browser for docs
zen &

# Editor
Ctrl+Alt+N  # Opens Neovim

# Check system
Ctrl+Alt+M  # BTOp
Ctrl+Alt+G  # Git log
```

### Security Work

```bash
# Network monitoring
Ctrl+Alt+W  # Network manager
Ctrl+Alt+T  # nethogs

# System audit
Ctrl+Alt+Shift+A  # Audit rules
Ctrl+Alt+Shift+X  # Logs

# Containers
Ctrl+Alt+Shift+D  # Docker stats
Ctrl+Alt+Shift+C  # Podman ps
```

### System Admin

```bash
# Full overview
Ctrl+Shift+C  # CPU & memory
Ctrl+Alt+I    # inxi system info

# Process watching
Ctrl+Alt+P    # Process list
Ctrl+Alt+M    # BTOp

# File management
Ctrl+Alt+Shift+F  # LF
Ctrl+Alt+Shift+N  # NNN
```

---

## Customization

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

In `kitty.conf`:
```bash
map ctrl+alt+custom launch --type=overlay fish -c "your-command"
```

---

## Troubleshooting

### Kitty acting weird

Run `kitty --debug-config` to see what's loading.

Make sure `TERM=xterm-kitty` is set.

### Browser CSS not applying

Check that `toolkit.legacyUserProfileCustomizations.stylesheets = true` is in prefs.js.

Verify userChrome.css is in `~/.zen/PROFILE_NAME/chrome/` (note the lowercase "chrome" folder).

Full restart: `killall zen && zen &`

---

## What Works

- Cyberpunk theme across terminal and browser
- 50+ functional keybindings
- Performance optimizations active
- Tmux and Zellij integration ready
- Browser UI fully themed

---

If you try it out, let me know what you think. The setup takes about 5 minutes to install and I think it makes the dev environment a lot more pleasant to use.
