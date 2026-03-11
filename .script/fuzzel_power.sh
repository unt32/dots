#!/bin/bash
# Fuzzel Power Control Menu
# Compositor: niri
# Locker: swaylock (reads ~/.config/swaylock/config)

LOCK="󰌾  Lock"
LOGOUT="󰗽  Logout"
SCREEN_OFF="󰍹  Screen Off"
HIBERNATE="󰒲  Hibernate"
REBOOT="󰑓  Reboot"
SOFT_REBOOT="󰑓  Soft Reboot"
FIRMWARE="󰚑  Firmware Setup"
SHUTDOWN="󰐥  Shutdown"

CHOICE=$(printf '%s\n' \
    "$LOCK" \
    "$LOGOUT" \
    "$SCREEN_OFF" \
    "$HIBERNATE" \
    "$REBOOT" \
    "$SOFT_REBOOT" \
    "$FIRMWARE" \
    "$SHUTDOWN" \
    | fuzzel --dmenu \
             --prompt "Power: " \
             --lines 8)

case "$CHOICE" in
    "$LOCK")
        swaylock
        ;;
    "$LOGOUT")
        niri msg action quit
        ;;
    "$SCREEN_OFF")
        niri msg action power-off-monitors && swaylock
        ;;
    "$HIBERNATE")
        systemctl hibernate
        ;;
    "$REBOOT")
        systemctl reboot
        ;;
    "$SOFT_REBOOT")
        systemctl soft-reboot
        ;;
    "$FIRMWARE")
        systemctl reboot --firmware-setup
        ;;
    "$SHUTDOWN")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac