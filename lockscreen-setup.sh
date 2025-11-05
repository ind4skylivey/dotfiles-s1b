#!/bin/bash

# Setup script for betterlockscreen
# Run this once or whenever you change wallpapers

WALLPAPER_DIR="$HOME/Pictures/screenlock"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory not found: $WALLPAPER_DIR"
    echo "Please create it and add your lockscreen wallpapers."
    exit 1
fi

echo "Setting up betterlockscreen with wallpapers from $WALLPAPER_DIR"
echo "This may take a moment..."

betterlockscreen -u "$WALLPAPER_DIR" --fx blur

echo "Setup complete! You can now use ./lockscreen.sh to lock your screen."
