#!/bin/bash
# Direct rofi launcher with logging for debugging

# Create log file
LOGFILE="/tmp/jb-reset-rofi.log"
echo "=== JB-Reset launched at $(date) ===" >> "$LOGFILE"
echo "Called from: $0" >> "$LOGFILE"
echo "USER: $USER" >> "$LOGFILE"
echo "DISPLAY: $DISPLAY" >> "$LOGFILE"
echo "PATH: $PATH" >> "$LOGFILE"

# Show menu in rofi and get selection
CHOICE=$(printf "📋 List Products\n🔄 Reset All Products\n📊 Show Status\n🎯 Interactive Menu\n❌ Exit" | rofi -dmenu -i -p "JetBrains Trial Reset" -theme-str 'window {width: 400px;}' 2>> "$LOGFILE")

echo "Choice selected: $CHOICE" >> "$LOGFILE"

# If no choice (ESC pressed), exit
if [ -z "$CHOICE" ]; then
    echo "No choice, exiting" >> "$LOGFILE"
    exit 0
fi

# Handle selection
case "$CHOICE" in
    "📋 List Products")
        echo "Launching: List Products" >> "$LOGFILE"
        alacritty --title "JB Reset - List" -e bash -c "jb-reset list; echo ''; read -p 'Press ENTER to close...'" >> "$LOGFILE" 2>&1 &
        ;;
    "🔄 Reset All Products")
        echo "Launching: Reset All" >> "$LOGFILE"
        CONFIRM=$(printf "Yes\nNo" | rofi -dmenu -i -p "Reset ALL JetBrains trials?" -theme-str 'window {width: 350px;}' 2>> "$LOGFILE")
        echo "Confirm: $CONFIRM" >> "$LOGFILE"
        if [ "$CONFIRM" = "Yes" ]; then
            alacritty --title "JB Reset - Reset All" -e bash -c "jb-reset reset --all; echo ''; read -p 'Press ENTER to close...'" >> "$LOGFILE" 2>&1 &
            notify-send "Trial Reset" "All products have been reset" -i jetbrains-toolbox
        fi
        ;;
    "📊 Show Status")
        echo "Launching: Status" >> "$LOGFILE"
        alacritty --title "JB Reset - Status" -e bash -c "jb-reset status; echo ''; read -p 'Press ENTER to close...'" >> "$LOGFILE" 2>&1 &
        ;;
    "🎯 Interactive Menu")
        echo "Launching: Interactive Menu" >> "$LOGFILE"
        alacritty --title "JetBrains Trial Reset" -e jb-reset-gui >> "$LOGFILE" 2>&1 &
        ;;
    "❌ Exit")
        echo "Exit selected" >> "$LOGFILE"
        exit 0
        ;;
esac

echo "Script finished" >> "$LOGFILE"
