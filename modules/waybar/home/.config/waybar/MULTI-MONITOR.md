# Waybar Multi-Monitor Configuration

## Monitors Setup

Your system has 3 monitors:
- **DP-1**: Primary screen (2016x1134, horizontal)
- **DP-2**: ASUS (1080x1920, vertical)
- **HDMI-A-1**: Secondary screen (2016x1134, horizontal)

## Configuration Files

### By Monitor
- `config-dp1.jsonc` - Full configuration for DP-1 (primary)
- `config-dp2.jsonc` - Compact configuration for DP-2 (vertical ASUS)
- `config-hdmi.jsonc` - Full configuration for HDMI-A-1

### CSS Styles
- `style-dp1.css` - 12px font for DP-1
- `style-dp2.css` - 10px font for DP-2 (compact)
- `style-hdmi.css` - 12px font for HDMI-A-1

## Launching Waybar

### Option 1: All screens (recommended)
```bash
~/.config/waybar/launch-multi.sh
```

### Option 2: A specific screen
```bash
waybar -c ~/.config/waybar/config-dp1.jsonc -s ~/.config/waybar/style-dp1.css &
waybar -c ~/.config/waybar/config-dp2.jsonc -s ~/.config/waybar/style-dp2.css &
waybar -c ~/.config/waybar/config-hdmi.jsonc -s ~/.config/waybar/style-hdmi.css &
```

### Option 3: Kill all instances
```bash
killall waybar
```

## Autostart in KDE Plasma

For waybar to launch automatically:

### Method 1: Create autostart file
```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/waybar.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Waybar
Exec=~/.config/waybar/launch-multi.sh
NoDisplay=true
EOF
```

### Method 2: Add to ~/.xprofile or ~/.bashrc
```bash
echo '~/.config/waybar/launch-multi.sh &' >> ~/.xprofile
```

## Modifying Configuration

### Add module to a specific screen
Edit the corresponding `config-dp*.jsonc` file:
1. Add the module to `modules-left`, `modules-center`, or `modules-right`
2. Define its configuration in the module section
3. Reload: `killall waybar && ~/.config/waybar/launch-multi.sh`

### Change style of a screen
Edit the corresponding `style-dp*.css` file:
1. Modify colors, padding, fonts, etc.
2. Reload: `killall waybar && ~/.config/waybar/launch-multi.sh`

## DP-2 (ASUS Vertical) Specifics

DP-2 configuration is minimalist because space is limited:
- Reduced height to 24px (vs 34px on others)
- 10px font (vs 12px on others)
- No modules in `modules-center` (essentials only)
- Fewer modules overall to avoid overflow

If you want to add more modules to DP-2, consider:
- Further reducing font size
- Increasing bar height
- Removing some modules from others

## Troubleshooting

### Bar doesn't appear on a monitor
Verify the monitor name is correct:
```bash
xrandr --listactivemonitors
```

### Text cutoff on DP-2
- Reduce font in `style-dp2.css`
- Increase height in `config-dp2.jsonc`
- Remove less-used modules

### Multiple bars on the same monitor
Execute:
```bash
killall waybar
sleep 1
~/.config/waybar/launch-multi.sh
```
