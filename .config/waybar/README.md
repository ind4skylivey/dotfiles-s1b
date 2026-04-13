# Waybar Configuration - KDE Plasma 6 Wayland

Super professional cyberpunk waybar configuration for KDE Plasma with multi-monitor support.

## Features

✅ **Multi-Monitor Support** (3 monitors)
- DP-1: LG (Main monitor) - Full configuration
- DP-2: ASUS (Vertical) - Compact configuration  
- HDMI-A-1: Samsung - Full configuration

✅ **Modules Included**
- Launcher (Wofi integration)
- Virtual Desktops (4 spaces with visual indicator)
- Quick Apps (Zen Browser, PhpStorm, Zed IDE, Steam)
- Window Title + Git Status
- VPN Status
- CPU Temperature
- Network, CPU, Memory Usage
- Session Uptime
- PulseAudio Volume
- Clock
- Power (Logout)
- **Independent Wallpapers per Monitor** with swww

## Installation

```bash
# Copy to ~/.config/waybar
cp -r .config/waybar ~/.config/

# Copy autostart scripts
cp -r .config/autostart ~/.config/

# Copy wofi configuration
cp -r .config/wofi ~/.config/

# Install dependencies
sudo pacman -S waybar wofi swww

# Launch waybar
~/.config/waybar/launch-multi.sh
```

## Directory Structure

```
.config/
├── waybar/
│   ├── config-dp1.jsonc      # Main monitor (LG)
│   ├── config-dp2.jsonc      # Vertical monitor (ASUS)
│   ├── config-hdmi.jsonc     # Secondary monitor (Samsung)
│   ├── style-dp1.css
│   ├── style-dp2.css
│   ├── style-hdmi.css
│   ├── launch-multi.sh        # Start waybar on all monitors
│   ├── MULTI-MONITOR.md       # Multi-monitor documentation
│   └── scripts/
│       ├── workspaces.py      # Virtual desktop indicator
│       ├── window_title.py    # Active window title
│       ├── temperature.py     # CPU temperature
│       ├── vpn_status.sh      # VPN connection status
│       ├── uptime.sh          # Session time
│       ├── wallpaper.sh       # Single monitor wallpaper
│       ├── wallpaper-all.sh   # Multi-monitor wallpaper (main)
│       └── quick_apps.py      # Application shortcuts
├── wofi/
│   └── style.css             # Wofi launcher styling
└── autostart/
    ├── waybar.desktop         # Autostart waybar on session
    ├── restore-wallpaper.desktop # Restore wallpaper on boot
    └── restore-wallpaper.sh   # Wallpaper restoration script
```

## Usage

### Launching

```bash
# Auto-starts on session login
# Or manual start:
~/.config/waybar/launch-multi.sh
```

### Wallpaper Management

**Buttons in Waybar (Left Panel):**
- **◀** - Previous wallpaper (all monitors, different)
- **🖼** - Random wallpaper (all monitors get different random)
- **▶** - Next wallpaper (all monitors, different)

Each monitor independently cycles through wallpapers from `~/Pictures/backgrounds/`

### Virtual Desktops

- **Scroll on workspaces** - Navigate between 4 desktops
- **Click on workspaces** - Jump to next desktop
- Visual indicator shows current desktop (⬤ = active, ○ = inactive)

### Quick Apps

**Hover and click on app icons (left panel):**
- 🖊️ **Zen Browser** - Click to launch
- 🎨 **PhpStorm** - Click to launch
- 💻 **Zed IDE** - Click to launch
- 🎮 **Steam** - Click to launch

## Configuration

### Per-Monitor Settings

Edit `config-dpX.jsonc` to customize:
- Module order (left/center/right)
- Colors and styling (via CSS)
- Module update intervals
- Tooltip text

### Styling

- **style-dp1.css** - Main monitor styling
- **style-dp2.css** - Vertical monitor styling (compact)
- **style-hdmi.css** - Secondary monitor styling

Edit hex colors (`#ff0000`) and padding values to customize appearance.

## Dependencies

```bash
sudo pacman -S waybar wofi swww lm-sensors
```

Optional for better integration:
```bash
sudo pacman -S zenity kdialog
```

## Keyboard Shortcuts

- **Super + D** - Show/hide desktop (KDE default)
- **Click wallpaper buttons** - Change wallpapers per monitor
- **Scroll on workspaces** - Navigate desktops
- **Click app icons** - Launch applications

## Troubleshooting

### Waybar doesn't appear

```bash
killall waybar
~/.config/waybar/launch-multi.sh
```

### Wallpapers not changing

Ensure swww is running:
```bash
swww-daemon
```

### Check logs

```bash
tail -30 ~/.cache/wallpaper_script.log
```

### Temperature shows N/A

Install lm-sensors:
```bash
sudo pacman -S lm-sensors
sudo sensors-detect
```

## Color Scheme

- **Primary:** `#ff0000` (Red - Cyberpunk style)
- **Background:** `rgba(10, 10, 10, 0.9)` (Almost black)
- **Text:** `#ffffff` (White)
- **Accent (VPN):** `#00ff00` (Green)
- **Accent (Warm):** `#ffaa00` (Orange)

## Notes

- Waybar syncs with KDE Plasma 6 on Wayland
- Multi-monitor setup is automatic via `launch-multi.sh`
- Wallpaper state persists across sessions via `~/.fehbg`
- All scripts use bash with proper error handling
- Supports dynamic monitor plug/unplug

## Credits

Configuration optimized for:
- KDE Plasma 6 (Wayland)
- Arch Linux
- Multi-monitor setups (3+ displays)
- Professional cyberpunk aesthetic
