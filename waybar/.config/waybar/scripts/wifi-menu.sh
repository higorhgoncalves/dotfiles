#!/bin/bash

# Get list of available WiFi networks
networks=$(nmcli -t -f SSID dev wifi | grep -v '^$' | sort -u)

# Show networks in wofi and get selection
selected=$(echo "$networks" | wofi --dmenu --prompt "Select WiFi Network")

# If a network was selected, connect to it
if [ -n "$selected" ]; then
    # Check if network requires password
    if nmcli -t -f SECURITY dev wifi list | grep -q "$selected.*WPA\|$selected.*WEP"; then
        # Prompt for password
        password=$(wofi --dmenu --password --prompt "Password for $selected:")
        if [ -n "$password" ]; then
            nmcli dev wifi connect "$selected" password "$password"
        fi
    else
        # Connect to open network
        nmcli dev wifi connect "$selected"
    fi
fi
