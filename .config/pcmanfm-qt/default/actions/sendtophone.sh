#!/bin/bash

# Get list of available devices with their IDs
devices_raw=$(kdeconnect-cli -a 2>&1)

# Check if any devices are available
if [ -z "$devices_raw" ] || [ "$devices_raw" = "0 devices found" ]; then
    kdialog --error "No connected devices found.\nPlease connect your device via KDE Connect."
    exit 1
fi

# Parse device list into format: "Device Name|device_id"
device_list=""
while IFS= read -r line; do
    if [[ $line =~ ^-\ (.+):\ ([a-f0-9_]+)\ \(.*\) ]]; then
        device_name="${BASH_REMATCH[1]}"
        device_id="${BASH_REMATCH[2]}"
        device_list="${device_list}${device_id} \"${device_name}\" "
    fi
done <<< "$devices_raw"

# If no devices parsed, show error
if [ -z "$device_list" ]; then
    kdialog --error "Failed to parse device list"
    exit 1
fi

# Show device selection dialog
eval "selected_id=\$(kdialog --menu \"Select device to send file(s):\" $device_list)"

# If user cancelled or no selection made
if [ -z "$selected_id" ]; then
    exit 0
fi

# Send each file to the selected device
success=true
for file in "$@"; do
    if ! kdeconnect-cli -d "$selected_id" --share "$file" 2>&1; then
        success=false
    fi
done

# Show notification
if [ "$success" = true ]; then
    kdialog --passivepopup "File(s) sent successfully" 3
else
    kdialog --error "Failed to send some files"
fi
