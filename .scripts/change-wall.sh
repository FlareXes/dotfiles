#!/bin/bash

# Author: FlareXes
# GitHub: https://github.com/FlareXes/dotfiles/blob/main/.scripts/change-wall.sh
# Description: A hyprpaper script to updates the current wallpaper.

# Check for required dependencies
dependencies=("convert" "file" "hyprpaper")

for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        echo "Error: Required command '$dep' is not installed."
        echo "Install Required Dependencies: 'file', 'hyprpaper', and 'imagemagick'"
        exit 1
    fi
done

# Check if a file argument was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a wallpaper file as an argument."
    echo "Usage: $0 <image_file>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    echo "Usage: $0 <image_file>"
    exit 1
fi

input_file="$1"
wallpaper="$HOME/.cache/current_wallpaper.png"

# Get the file MIME type
file_type=$(file --mime-type -b "$input_file")

# Check if the image is already in PNG format or convert to PNG
if [ "$file_type" == "image/png" ]; then
    echo "[INFO] The file is already in PNG format."

    # Update the current wallpaper
    cp "$input_file" "$wallpaper"
else
    echo "[INFO] Convert the image to PNG format."

    output_file="$(mktemp /tmp/current_wallpaper.XXXXXXXXX.png)"
    convert "$input_file" "$output_file"

    # Check if conversion was successful
    if [ $? -ne 0 ]; then
        echo "Error: Conversion failed."
        exit 1
    fi

    # Update the current wallpaper
    cp "$output_file" "$wallpaper"
fi

# Reload hyprpaper
killall -e hyprpaper & 
sleep 1; 
hyprpaper &

echo "[SUCCESS] Wallpaper updated successfully."
