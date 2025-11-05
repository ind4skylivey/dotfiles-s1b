#!/bin/bash

# Lock screen script using betterlockscreen
# 
# Setup (run once or when wallpapers change):
#   betterlockscreen -u ~/Pictures/screenlock/ --fx blur
#
# This script assumes the cache is already set up

# Lock the screen with blur effect
betterlockscreen --lock blur
