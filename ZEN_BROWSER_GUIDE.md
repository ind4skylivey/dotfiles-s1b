# Zen Browser — Cyberpunk Theme Setup

Zen Browser is my go-to browser. It's Firefox-based but with a modern UI that actually looks good out of the box. I theme it to match my terminal so switching between browser and terminal doesn't feel like jumping between two different worlds.

---

## Overview

This setup gives you:
- Cyberpunk Synthwave theme matching Kitty terminal
- Neon magenta and cyan accents
- Purple sidebar
- Dark mode optimized for long sessions
- Custom userChrome.css for UI styling

**The palette:**
```
Background:        #0d1b2a (Deep purple-blue)
Primary accent:    #FF10F0 (Magenta — buttons, active elements)
Secondary accent:  #00d9ff (Cyan — borders, highlights)
Dark elements:     #1a1a3e (Inactive tabs, panels)
Sidebar:           #8B5CF6 (Bright purple)
```

---

## Installation

### 1. Find Your Profile

Zen stores profiles in `~/.zen/`. You'll see folders like `7h4wrogl.Default (release)`. That's your profile name.

```bash
ls -la ~/.zen/*/
```

### 2. Copy the Config Files

```bash
# Replace PROFILE_NAME with your actual folder
cp prefs.js ~/.zen/PROFILE_NAME/
cp userChrome.css ~/.zen/PROFILE_NAME/chrome/
```

Note: the chrome folder needs to be lowercase.

### 3. Restart Zen

Close Zen completely, then reopen. The CSS won't apply if you just refresh the page.

```bash
killall zen
zen &
```

---

## What Each Part Does

### prefs.js

Sets Zen's built-in theme options:
```javascript
user_pref("zen.theme.accent-color", "#FF10F0");  // Primary magenta
user_pref("mod.cleanedurlbar.customcolor", "#0d1b2a");  // URL bar background
user_pref("mod.sameerasw.zen_transparency_color", "#8B5CF6");  // Sidebar purple
```

### userChrome.css

The heavy lifting. This file styles the browser UI itself — tabs, menus, the bookmarks bar. I added neon glow effects and smooth transitions here.

---

## Theme Details

### URL Bar
- Dark cyberpunk background
- Cyan neon border
- Magenta glow when focused
- Cyan text

### Tabs
- Inactive: dark purple with cyan border
- Active: bright magenta with a subtle pulsing glow
- Smooth transitions when switching

### Sidebar
- Bright purple background
- High contrast icons
- Hover effects match the theme

### Menus and Popups
- Dark background
- Magenta neon border
- Magenta hover on items
- Cyan text for readability

### Bookmarks Bar
- Gradient from dark to darker purple
- Cyan text
- Magenta on hover

---

## Customization

### Change the Accent Color

In `prefs.js`, change the accent color:
```javascript
user_pref("zen.theme.accent-color", "#YOUR_COLOR");
```

Some ideas:
```javascript
// Hot pink
user_pref("zen.theme.accent-color", "#FF1493");

// Neon green
user_pref("zen.theme.accent-color", "#39FF14");

// Electric blue
user_pref("zen.theme.accent-color", "#0080FF");
```

### Change the Sidebar Color

```javascript
user_pref("mod.sameerasw.zen_transparency_color", "#YOUR_COLOR");
```

### Tweak the CSS

Edit `userChrome.css` to adjust:
- Border styles and widths
- Glow effect intensity
- Transition speeds
- Font sizes

Want a stronger glow on active tabs?
```css
.tabbrowser-tab[selected="true"] {
  box-shadow: 0 0 20px rgba(255, 16, 240, 0.8) !important;
}
```

---

## Matching Kitty Terminal

I use the same color palette in Kitty and Zen so everything feels cohesive:

| Element | Kitty | Zen |
|---------|-------|-----|
| Primary accent | Magenta `#FF10F0` | Accent color |
| Secondary accent | Cyan `#00d9ff` | Borders, text |
| Background | Deep purple `#0d1b2a` | URL bar, menus |
| Highlights | Purple `#8B5CF6` | Sidebar |

When you switch between terminal and browser, you're staying in the same visual space.

---

## Troubleshooting

### CSS not applying

1. Make sure `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in prefs.js
2. Check that `userChrome.css` is in `~/.zen/PROFILE_NAME/chrome/` (lowercase "chrome")
3. Restart Zen completely — a refresh isn't enough
4. Open browser console (`Ctrl+Shift+K`) to check for errors

### Colors look wrong

1. Full restart: `killall zen && zen &`
2. Clear cache: `rm -rf ~/.zen/PROFILE_NAME/startupCache/`
3. Make sure your hex codes are valid (6 characters, includes the `#`)

### Sidebar is still dark

1. Check `mod.sameerasw.zen_transparency_color` in prefs.js
2. Make sure the Zen mod/addon that enables sidebar theming is installed
3. Full restart

### Performance feels slow

1. Disable animations by removing the `@keyframes` sections from userChrome.css
2. Reduce or remove `box-shadow` effects
3. Close unnecessary tabs

---

## Tips

### Fullscreen Mode

Press `F11` for distraction-free browsing. The cyberpunk theme looks great in fullscreen.

### Wallpaper

I use a wallpaper that matches the `#0d1b2a` background color. Makes the browser feel like it extends seamlessly from the terminal.

### Workflow

Having the same colors in Kitty and Zen means less visual context-switching. I can keep more mental focus on what I'm doing rather than adjusting to a different color scheme.

---

## Resources

- [Zen Browser](https://zen-browser.app/)
- [Firefox Browser Console](https://developer.mozilla.org/en-US/docs/Tools/Browser_Console)
- [userChrome.org](https://www.userchrome.org/) — CSS customization reference

---

It's a simple setup, but it makes the browser feel like part of the same environment as the terminal. Takes about 5 minutes to install and I think it's worth it.
