#!/bin/bash
# Clipboard history selector using cliphist and rofi

if command -v cliphist &>/dev/null && command -v rofi &>/dev/null; then
    cliphist list | rofi -dmenu | cliphist decode | wl-copy
elif command -v xclip &>/dev/null; then
    # Fallback - just copy whatever is in primary
    xclip -selection clipboard -o 2>/dev/null
fi