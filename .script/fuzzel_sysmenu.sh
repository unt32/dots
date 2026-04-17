#!/bin/bash

AUDIO="󰕾  Audio"
BLUETOOTH="󰂯  Bluetooth"
NETWORK="󰤨  Network"
CHANGEBG="󰆍  Change Background"
SERVICES="󰍹  Services"

CHOICE=$(printf '%s\n' \
	"$NETWORK" \
	"$BLUETOOTH" \
	"$AUDIO" \
	"$CHANGEBG" \
	"$SERVICES" |
	fuzzel --dmenu \
		--prompt "Settings: " \
		--lines 5)

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
"$CHANGEBG")
	systemctl restart --user swaybg.service
	;;
"$SERVICES")
	foot -e systemctl-tui
	;;
*)
	exit 0
	;;
esac
