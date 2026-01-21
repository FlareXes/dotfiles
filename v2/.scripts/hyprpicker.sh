#!/usr/bin/env bash

LOCK="/tmp/picker.lock"

# Toggle off hyprpicker if running
pkill -x hyprpicker && exit 0

# Open lock FD
exec 9>"$LOCK"

# Try to acquire lock
if ! flock -n 9; then
  # Picker menu already open, do nothing
  exit 0
fi

FORMATS="hex\nrgb\nhsl\nhsv\ncmyk"

# Run wofi while holding the lock
FORMAT=$(printf "%b" "$FORMATS" | wofi --dmenu --prompt "Format")

# IMPORTANT: release lock explicitly
flock -u 9
exec 9>&-

# User cancelled
[ -z "$FORMAT" ] && exit 0

# Now run hyprpicker without holding the lock
hyprpicker -a -f "$FORMAT"

