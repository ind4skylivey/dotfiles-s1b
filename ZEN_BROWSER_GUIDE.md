# Zen Browser - Cyberpunk Synthwave Theme Configuration Guide

**A complete Zen Browser setup with a matching cyberpunk synthwave theme, neon accents, and professional configuration.**

## 📋 Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Color Scheme](#color-scheme)
- [Theme Features](#theme-features)
- [Configuration Files](#configuration-files)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

---

## 🎨 Overview

This Zen Browser configuration includes:
- **Cyberpunk Synthwave Theme**: Matching Kitty terminal aesthetics
- **Neon Magenta & Cyan Accents**: Modern, eye-catching UI
- **Purple Bright Sidebar**: Professional appearance
- **Custom userChrome.css**: Advanced browser UI styling
- **Dark Mode Optimization**: Comfortable for long work sessions

### Color Palette
```
🟣 Background:        #0d1b2a (Deep purple-blue)
💜 Accent Primary:    #FF10F0 (Magenta neon - buttons, active elements)
🔵 Accent Secondary:  #00d9ff (Cyan neon - borders, highlights)
⚫ Dark Elements:      #1a1a3e (Inactive tabs, panels)
🟣 Sidebar:           #8B5CF6 (Bright purple - sidebar background)
```

---

## 📦 Installation

### 1. Locate Zen Profile Directory
```bash
# Find your Zen profile (usually one of these)
ls -la ~/.zen/*/

# Look for a folder like: 7h4wrogl.Default\ \(release\)
```

### 2. Copy Configuration Files
```bash
# Replace PROFILE_NAME with your actual profile folder name
cp prefs.js ~/.zen/PROFILE_NAME/
cp userChrome.css ~/.zen/PROFILE_NAME/chrome/
```

### 3. Enable Legacy CSS Support
The configuration already includes:
```javascript
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
```

### 4. Restart Zen Browser
Close Zen completely and reopen:
```bash
killall zen
zen &
```

---

## 🎨 Color Scheme

The theme uses the same cyberpunk synthwave palette as Kitty for consistency.

### Main Colors
| Element | Hex | Usage |
|---------|-----|-------|
| Background | `#0d1b2a` | Main browser background |
| URL Bar | `#0d1b2a` | Address bar background |
| Accent | `#FF10F0` | Buttons, tabs, highlights |
| Secondary | `#00d9ff` | Borders, secondary elements |
| Sidebar | `#8B5CF6` | Sidebar background |
| Inactive Tab | `#1a1a3e` | Non-active tabs |
| Active Tab | `#FF10F0` | Current tab (magenta) |

---

## ✨ Theme Features

### URL Bar
- **Background**: Dark cyberpunk (`#0d1b2a`)
- **Border**: Cyan neon (`#00d9ff`)
- **Focus State**: Magenta glow with border highlight
- **Text**: Light cyberpunk text (`#00d9ff`)

### Tabs
- **Inactive Tabs**: Dark purple (`#1a1a3e`) with cyan border
- **Active Tab**: Bright magenta (`#FF10F0`) with neon glow effect
- **Animation**: Subtle pulsing glow on active tab

### Sidebar
- **Background**: Bright purple (`#8B5CF6`)
- **Buttons**: Respects theme colors with hover effects
- **Icons**: High contrast against purple background

### Menus & Popups
- **Background**: Dark cyberpunk (`#0d1b2a`)
- **Border**: Magenta neon (`#FF10F0`)
- **Hover**: Magenta accent on menu items
- **Text**: Cyan neon for contrast (`#00d9ff`)

### Bookmarks Bar
- **Background**: Gradient from dark to darker purple
- **Text**: Cyan neon for visibility
- **Hover**: Magenta highlight

---

## 📁 Configuration Files

### `prefs.js`
Contains Zen-specific preferences:
```javascript
user_pref("zen.theme.accent-color", "#FF10F0");  // Primary magenta
user_pref("mod.cleanedurlbar.customcolor", "#0d1b2a");  // Dark background
user_pref("mod.sameerasw.zen_transparency_color", "#8B5CF6");  // Sidebar purple
```

### `userChrome.css`
Advanced browser UI styling with:
- Custom color variables
- Neon glow effects
- Hover states
- Border styling
- Smooth transitions

---

## 🎯 Key Preferences

### Theme Colors
```javascript
// Primary accent - Magenta neon
user_pref("zen.theme.accent-color", "#FF10F0");

// URL bar colors
user_pref("mod.cleanedurlbar.customcolor", "#0d1b2a");  // Background
user_pref("mod.cleanedurlbar.customselectcolor", "rgba(255, 16, 240, 0.75)");  // Selection

// Hover effects
user_pref("mod.tidypopup.hovercolor", "rgba(255, 16, 240, 1)");  // Magenta

// Sidebar background
user_pref("mod.sameerasw.zen_transparency_color", "#8B5CF6");  // Bright purple
```

---

## 🔧 Customization

### Change Primary Accent Color
Edit `prefs.js`:
```javascript
user_pref("zen.theme.accent-color", "#YOUR_COLOR");
```

Examples:
```javascript
// Hot Pink
user_pref("zen.theme.accent-color", "#FF1493");

// Neon Green
user_pref("zen.theme.accent-color", "#39FF14");

// Electric Blue
user_pref("zen.theme.accent-color", "#0080FF");
```

### Modify Sidebar Color
Edit `prefs.js`:
```javascript
user_pref("mod.sameerasw.zen_transparency_color", "#YOUR_COLOR");
```

### Edit CSS Styling
Edit `userChrome.css` to modify:
- Border styles
- Glow effects
- Colors
- Transitions
- Font sizes

Example - Add more glow to active tab:
```css
.tabbrowser-tab[selected="true"] {
  box-shadow: 0 0 20px rgba(255, 16, 240, 0.8) !important;  /* Stronger glow */
}
```

---

## 🌐 Integration with Kitty Terminal

Both Kitty and Zen Browser use the same color palette for a cohesive workflow:

| Element | Kitty | Zen |
|---------|-------|-----|
| Primary Accent | Magenta (`#FF10F0`) | Accent Color |
| Secondary Accent | Cyan (`#00d9ff`) | Borders & Text |
| Background | Deep Purple (`#0d1b2a`) | URL Bar & Menus |
| Highlights | Purple (`#8B5CF6`) | Sidebar |

This creates a unified cyberpunk aesthetic across your entire terminal environment.

---

## 🐛 Troubleshooting

### CSS Not Applying
1. Verify `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in `prefs.js`
2. Check userChrome.css is in `~/.zen/PROFILE_NAME/chrome/`
3. Close and reopen Zen completely
4. Check browser console for errors: `Ctrl+Shift+K`

### Colors Not Showing
1. Restart Zen Browser
2. Clear Zen cache: `~/.zen/PROFILE_NAME/startupCache/`
3. Verify color values are valid hex codes

### Sidebar Still Dark
If sidebar remains dark after applying theme:
1. Check `mod.sameerasw.zen_transparency_color` in `prefs.js`
2. Try restarting Zen completely
3. Verify the addon/mod is enabled

### Performance Issues
If UI feels slow:
1. Disable animations in userChrome.css (remove @keyframes neon-glow)
2. Reduce box-shadow effects
3. Close unnecessary tabs

---

## 📚 Zen Browser Resources

- **Zen Browser Official**: https://zen-browser.app/
- **Firefox Customization**: https://developer.mozilla.org/en-US/docs/Tools/Browser_Console
- **userChrome.css Guide**: https://www.userchrome.org/

---

## 📝 Notes

- **Author**: ind4skylivey
- **Theme**: Cyberpunk Synthwave (matching Kitty terminal)
- **Status**: Production Ready
- **Last Updated**: 2026-01-07
- **Compatibility**: Zen Browser (Firefox-based), Linux/macOS/Windows

---

## 🎯 Quick Setup Summary

1. Copy `prefs.js` to your Zen profile directory
2. Copy `userChrome.css` to your Zen profile's `chrome/` folder
3. Restart Zen Browser
4. Enjoy your cyberpunk Zen experience! 🚀

---

## 💡 Pro Tips

### For Maximum Effect
- Use full screen mode: `F11`
- Combine with dark wallpaper matching `#0d1b2a`
- Use Kitty terminal alongside Zen for unified aesthetics

### Performance
- The theme is lightweight and doesn't impact performance
- CSS animations are optimized for smooth 60fps
- All changes are applied via userChrome.css (no Firefox modifications)

### Workflow Integration
- Same color scheme across Kitty + Zen = faster context switching
- Neon colors help with focus on important UI elements
- Dark background reduces eye strain during long sessions
