#!/bin/bash

AUDIO="󰕾  Audio/Sound"
BLUETOOTH="󰂯  Bluetooth"
NETWORK="󰤨  Network/Wi-Fi"
SERVICES="󰍹  Services"

CHOICE=$(printf '%s\n' \
  "$NETWORK" \
  "$BLUETOOTH" \
  "$AUDIO" \
  "$SERVICES" |
  fuzzel --dmenu \
    --prompt "Settings: " \
    --lines 4)

case "$CHOICE" in
"$AUDIO")
  foot -e wiremix
  ;;
"$BLUETOOTH")
  foot -e bluetui
  ;;
"$NETWORK")
  networkmanager_dmenu
  ;;
"$SERVICES")
  EDITOR=vim foot -e systemctl-tui
  ;;
*)
  exit 0
  ;;
esac
