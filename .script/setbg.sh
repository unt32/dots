#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
	echo "Error: Wallpaper directory '$WALLPAPER_DIR' does not exist."
	exit 1
fi

IMAGE_PATH=$(find "$WALLPAPER_DIR" -type f -iregex '.*\.\(jpg\|jpeg\|png\|gif\|webp\)$' | shuf -n 1)

if [ -z "$IMAGE_PATH" ]; then
	echo "Error: No images found in '$WALLPAPER_DIR'."
	exit 1
fi

echo "Setting background to: $IMAGE_PATH"

swaybg -i "$IMAGE_PATH" -m fill
