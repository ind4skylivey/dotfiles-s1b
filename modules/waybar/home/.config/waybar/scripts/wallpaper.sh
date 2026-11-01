#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/backgrounds"
STATE_FILE="$HOME/.cache/waybar_wallpaper_state.txt"
STATE_DP1="$HOME/.cache/wallpaper_dp1.txt"
STATE_DP2="$HOME/.cache/wallpaper_dp2.txt"
STATE_HDMI="$HOME/.cache/wallpaper_hdmi.txt"
LOG_FILE="$HOME/.cache/wallpaper_script.log"
mkdir -p "$(dirname "$STATE_FILE")"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Ejecutando: $1 para monitor: ${2:-DP-1}" >> "$LOG_FILE"

get_wallpapers() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) | sort
}

set_wallpaper() {
    local wallpaper="$1"
    local monitor="${2:-DP-1}"
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] set_wallpaper: $wallpaper para $monitor" >> "$LOG_FILE"
    
    if [ ! -f "$wallpaper" ]; then
        echo "Wallpaper no encontrado: $wallpaper" >> "$LOG_FILE"
        return 1
    fi
    
    # Iniciar awww si no está corriendo
    if ! pgrep -x "awww-daemon" > /dev/null; then
        awww-daemon &
        sleep 1
    fi
    
    # Cambiar wallpaper para el monitor específico
    awww img "$wallpaper" --outputs "$monitor" --transition-type fade --transition-duration 1 2>>"$LOG_FILE"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] awww ejecutado para $monitor" >> "$LOG_FILE"
    
    # Guardar estado por monitor
    case "$monitor" in
        DP-1) echo "$wallpaper" > "$STATE_DP1" ;;
        DP-2) echo "$wallpaper" > "$STATE_DP2" ;;
        HDMI-A-1) echo "$wallpaper" > "$STATE_HDMI" ;;
    esac
    
    echo "$wallpaper" > "$STATE_FILE"
}

get_current_wallpaper() {
    local monitor="${1:-DP-1}"
    
    case "$monitor" in
        DP-1) 
            if [ -f "$STATE_DP1" ]; then
                cat "$STATE_DP1"
            else
                get_wallpapers | head -1
            fi
            ;;
        DP-2)
            if [ -f "$STATE_DP2" ]; then
                cat "$STATE_DP2"
            else
                get_wallpapers | head -1
            fi
            ;;
        HDMI-A-1)
            if [ -f "$STATE_HDMI" ]; then
                cat "$STATE_HDMI"
            else
                get_wallpapers | head -1
            fi
            ;;
        *)
            if [ -f "$STATE_FILE" ]; then
                cat "$STATE_FILE"
            else
                get_wallpapers | head -1
            fi
            ;;
    esac
}

random_wallpaper() {
    local monitor="${1:-DP-1}"
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        echo "No hay wallpapers" >> "$LOG_FILE"
        return 1
    fi
    
    local random_idx=$((RANDOM % ${#wallpapers[@]}))
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] random_wallpaper: índice $random_idx para $monitor" >> "$LOG_FILE"
    set_wallpaper "${wallpapers[$random_idx]}" "$monitor"
}

next_wallpaper() {
    local monitor="${1:-DP-1}"
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        return 1
    fi
    
    local current=$(get_current_wallpaper "$monitor")
    local current_idx=0
    
    for i in "${!wallpapers[@]}"; do
        if [ "${wallpapers[$i]}" = "$current" ]; then
            current_idx=$i
            break
        fi
    done
    
    local next_idx=$(( (current_idx + 1) % ${#wallpapers[@]} ))
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] next_wallpaper: índice $next_idx para $monitor" >> "$LOG_FILE"
    set_wallpaper "${wallpapers[$next_idx]}" "$monitor"
}

prev_wallpaper() {
    local monitor="${1:-DP-1}"
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        return 1
    fi
    
    local current=$(get_current_wallpaper "$monitor")
    local current_idx=0
    
    for i in "${!wallpapers[@]}"; do
        if [ "${wallpapers[$i]}" = "$current" ]; then
            current_idx=$i
            break
        fi
    done
    
    local prev_idx=$(( (current_idx - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]} ))
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] prev_wallpaper: índice $prev_idx para $monitor" >> "$LOG_FILE"
    set_wallpaper "${wallpapers[$prev_idx]}" "$monitor"
}

count_wallpapers() {
    get_wallpapers | wc -l
}

case "$1" in
    random) random_wallpaper "${2:-DP-1}" ;;
    next) next_wallpaper "${2:-DP-1}" ;;
    prev) prev_wallpaper "${2:-DP-1}" ;;
    current) basename "$(get_current_wallpaper "${2:-DP-1}")" ;;
    count) count_wallpapers ;;
    *) echo "Uso: $0 {random|next|prev|current|count} [monitor]"; echo "Monitores: DP-1 (default), DP-2, HDMI-A-1"; exit 1 ;;
esac
