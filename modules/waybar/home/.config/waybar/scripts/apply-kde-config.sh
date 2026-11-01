#!/bin/bash

echo "Reloading KDE configuration for virtual desktops..."

killall -9 kwin_x11 kwin_wayland 2>/dev/null
sleep 2

if command -v kwin_x11 &>/dev/null; then
    kwin_x11 &
elif command -v kwin_wayland &>/dev/null; then
    kwin_wayland &
fi

sleep 3
echo "KDE window manager restarted. You may need to manually log out/in for full effect."
