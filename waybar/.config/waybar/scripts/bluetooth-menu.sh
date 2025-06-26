#!/bin/bash

# Function to get paired devices
get_paired_devices() {
    bluetoothctl devices | grep "Device" | cut -d' ' -f2-
}

# Function to get available devices (scan results)
get_available_devices() {
    bluetoothctl devices | grep "Device" | cut -d' ' -f2-
}

# Function to check if device is connected
is_connected() {
    local mac="$1"
    bluetoothctl info "$mac" | grep -q "Connected: yes"
}

# Function to get device name from MAC
get_device_name() {
    local mac="$1"
    bluetoothctl info "$mac" | grep "Name:" | cut -d':' -f2- | sed 's/^ *//'
}

# Function to toggle bluetooth power
toggle_bluetooth() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl power off
        notify-send "Bluetooth" "Bluetooth turned off"
    else
        bluetoothctl power on
        notify-send "Bluetooth" "Bluetooth turned on"
    fi
}

# Function to scan for devices
scan_devices() {
    notify-send "Bluetooth" "Scanning for devices..."
    timeout 10 bluetoothctl scan on > /dev/null 2>&1 &
    sleep 10
    bluetoothctl scan off > /dev/null 2>&1
}

# Main menu function
show_menu() {
    local menu_options=""
    
    # Check bluetooth status
    if bluetoothctl show | grep -q "Powered: yes"; then
        menu_options+="󰨙 Turn Off Bluetooth\n"
        menu_options+=" Scan for Devices\n"
        menu_options+="---\n"
        
        # Add paired devices
        while read -r device; do
            if [ -n "$device" ]; then
                local mac=$(echo "$device" | cut -d' ' -f1)
                local name=$(echo "$device" | cut -d' ' -f2-)
                
                if is_connected "$mac"; then
                    menu_options+="󰂱 $name (Connected)\n"
                else
                    menu_options+="󱘖 $name (Disconnected)\n"
                fi
            fi
        done <<< "$(get_paired_devices)"
        
    else
        menu_options+="󰨚  Turn On Bluetooth\n"
    fi
    
    echo -e "$menu_options"
}

# Main script
main() {
    local selection=$(show_menu | wofi --dmenu --prompt "Bluetooth Menu")
    
    case "$selection" in
        "󰨙 Turn Off Bluetooth"|"󰨚  Turn On Bluetooth")
            toggle_bluetooth
            ;;
        " Scan for Devices")
            scan_devices
            # Show available devices after scan
            local available_devices=$(get_available_devices)
            if [ -n "$available_devices" ]; then
                local device_to_pair=$(echo "$available_devices" | cut -d' ' -f2- | wofi --dmenu --prompt "Select device to pair:")
                if [ -n "$device_to_pair" ]; then
                    local mac=$(echo "$available_devices" | grep "$device_to_pair" | cut -d' ' -f1)
                    bluetoothctl pair "$mac" && bluetoothctl connect "$mac"
                    notify-send "Bluetooth" "Attempting to pair with $device_to_pair"
                fi
            fi
            ;;
        *"(Connected)")
            # Disconnect device
            local device_name=$(echo "$selection" | sed 's/󰂱 //' | sed 's/ (Connected)//')
            local mac=$(get_paired_devices | grep "$device_name" | cut -d' ' -f1)
            bluetoothctl disconnect "$mac"
            notify-send "Bluetooth" "Disconnected from $device_name"
            ;;
        *"(Disconnected)")
            # Connect device
            local device_name=$(echo "$selection" | sed 's/󱘖 //' | sed 's/ (Disconnected)//')
            local mac=$(get_paired_devices | grep "$device_name" | cut -d' ' -f1)
            bluetoothctl connect "$mac"
            notify-send "Bluetooth" "Connecting to $device_name"
            ;;
    esac
}

main "$@"
