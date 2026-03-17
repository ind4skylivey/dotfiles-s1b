#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/backgrounds"
STATE_DP1="$HOME/.cache/wallpaper_dp1_idx.txt"
STATE_DP2="$HOME/.cache/wallpaper_dp2_idx.txt"
STATE_HDMI="$HOME/.cache/wallpaper_hdmi_idx.txt"
LOG_FILE="$HOME/.cache/wallpaper_script.log"
mkdir -p "$(dirname "$STATE_DP1")"

MONITORS=("DP-1" "DP-2" "HDMI-A-1")

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Ejecutando: $1 - Wallpapers DIFERENTES para cada monitor" >> "$LOG_FILE"

get_wallpapers() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) | sort
}

set_wallpapers_different() {
    local action="$1"
    
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        echo "No hay wallpapers" >> "$LOG_FILE"
        return 1
    fi
    
    # Iniciar swww si no está corriendo
    if ! pgrep -x "swww-daemon" > /dev/null; then
        swww-daemon &
        sleep 2
    fi
    
    local total=${#wallpapers[@]}
    
    # Procesar cada monitor
    for monitor in "${MONITORS[@]}"; do
        local state_file="$HOME/.cache/wallpaper_${monitor///-/_}_idx.txt"
        local current_idx=$(cat "$state_file" 2>/dev/null || echo "0")
        
        case "$action" in
            random)
                current_idx=$((RANDOM % total))
                ;;
            next)
                current_idx=$(( (current_idx + 1) % total ))
                ;;
            prev)
                current_idx=$(( (current_idx - 1 + total) % total ))
                ;;
        esac
        
        local wallpaper="${wallpapers[$current_idx]}"
        
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $monitor: $action -> índice $current_idx -> $(basename $wallpaper)" >> "$LOG_FILE"
        
        # Cambiar wallpaper
        swww img "$wallpaper" --outputs "$monitor" --transition-type fade --transition-duration 1 2>>"$LOG_FILE" &
        
        # Guardar índice
        echo "$current_idx" > "$state_file"
        
        sleep 0.3
    done
    
    wait
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cambio completado para todos los monitores" >> "$LOG_FILE"
}

case "$1" in
    random) set_wallpapers_different "random" ;;
    next) set_wallpapers_different "next" ;;
    prev) set_wallpapers_different "prev" ;;
    *) echo "Uso: $0 {random|next|prev}"; exit 1 ;;
esac
