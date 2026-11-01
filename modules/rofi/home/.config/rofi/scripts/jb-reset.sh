#!/bin/bash
# Simple rofi launcher - directly opens interactive menu

# Show notification
notify-send "JetBrains Trial Reset" "Opening interactive menu..." -t 1500 -i jetbrains-toolbox

# Launch terminal with GUI
if command -v alacritty &> /dev/null; then
    alacritty --title "JetBrains Trial Reset" -e jb-reset-gui &
elif command -v st &> /dev/null; then
    st -t "JetBrains Trial Reset" -e jb-reset-gui &
elif command -v xterm &> /dev/null; then
    xterm -T "JetBrains Trial Reset" -e jb-reset-gui &
elif command -v konsole &> /dev/null; then
    konsole -e jb-reset-gui &
else
    notify-send "No terminal found" "Please install alacritty, st, xterm or konsole" -i dialog-error
fi
