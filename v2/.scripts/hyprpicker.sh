#!/usr/bin/env bash

# Available formats
FORMATS="hex\nrgb\nhsl\nhsv\ncmyk"

# Show wofi menu
FORMAT=$(echo -e "$FORMATS" | wofi --dmenu --prompt "Format")

# Exit if nothing selected
[ -z "$FORMAT" ] && exit 0

# Run hyprpicker with selected format
hyprpicker -a -f "$FORMAT"

