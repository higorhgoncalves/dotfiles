#!/bin/bash

# Função para confirmação
confirm_action() {
    local action="$1"
    local confirmation=$(echo -e "Yes\nNo" | wofi --dmenu --prompt "Confirm $action?")
    [ "$confirmation" = "Yes" ]
}

# Função principal do menu
show_power_menu() {
    local menu_options=""
    
    # Opções de energia
    menu_options+=" Lock\n"
    menu_options+=" Shutdown\n"
    menu_options+=" Reboot\n"
    menu_options+=" Suspend\n"
    menu_options+=" Hibernate\n"
    menu_options+="󰞘 Logout\n"
    
    echo -e "$menu_options"
}

# Script principal
main() {
    local selection=$(show_power_menu | wofi --dmenu --prompt "Power Menu")
    
    case "$selection" in
        " Lock")
            # Tenta diferentes lock screens
            if command -v hyprlock >/dev/null 2>&1; then
                pidof hyprlock || hyprlock
            else
                notify-send "Power Menu" "No lock screen found"
            fi
            ;;
        " Shutdown")
            if confirm_action "Shutdown"; then
                systemctl poweroff
            fi
            ;;
        " Reboot")
            if confirm_action "Reboot"; then
                systemctl reboot
            fi
            ;;
        " Suspend")
            if confirm_action "Suspend"; then
                systemctl suspend
            fi
            ;;
        " Hibernate")
            if confirm_action "Hibernate"; then
                systemctl hibernate
            fi
            ;;
        "󰞘 Logout")
            if confirm_action "Logout"; then
                # Detecta o ambiente e faz logout apropriado
                if command -v hyprctl >/dev/null 2>&1; then
                    hyprctl dispatch exit
                else
                    pkill -KILL -u "$USER"
                fi
            fi
            ;;
    esac
}

main "$@"
