#!/bin/bash
# Restaurar wallpaper al iniciar sesión con swww
sleep 2

# Iniciar swww daemon si no está corriendo
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Restaurar wallpaper anterior
if [ -f ~/.cache/waybar_wallpaper_state.txt ]; then
    WALLPAPER=$(cat ~/.cache/waybar_wallpaper_state.txt)
    if [ -f "$WALLPAPER" ]; then
        swww img "$WALLPAPER" --transition-type fade --transition-duration 0 &
    fi
fi
