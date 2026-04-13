#!/bin/bash
# Restaurar wallpaper al iniciar sesión con awww
sleep 2

# Iniciar awww daemon si no está corriendo
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 1
fi

# Restaurar wallpaper anterior
if [ -f ~/.cache/waybar_wallpaper_state.txt ]; then
    WALLPAPER=$(cat ~/.cache/waybar_wallpaper_state.txt)
    if [ -f "$WALLPAPER" ]; then
        awww img "$WALLPAPER" --transition-type fade --transition-duration 0 &
    fi
fi
