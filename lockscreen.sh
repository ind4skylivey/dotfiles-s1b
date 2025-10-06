#!/bin/bash

# Lock screen with dim effect (faster than blur)
#betterlockscreen --lock dim

# Update betterlockscreen cache (only needed if wallpapers change)
betterlockscreen -u ~/Pictures/screenlock/ --fx blur

# Lock the screen with a lighter blur (faster processing)
betterlockscreen --lock blur --blur 0.5
