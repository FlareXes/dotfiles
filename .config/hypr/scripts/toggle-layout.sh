#!/bin/bash

mainMod="SUPER"

# Get the current layout
current_layout=$(hyprctl getoption general:layout | grep -oP '(?<=str: ).*')

# Clear existing bindings for $mainMod + Tab
hyprctl "keyword unbind $mainMod, Tab"

# Set keybindings based on the current layout
if [ "$current_layout" == "dwindle" ]; then
    hyprctl "keyword general:layout master"
    hyprctl "keyword bind $mainMod, Tab, layoutmsg, rollnext"
elif [ "$current_layout" == "master" ]; then
    hyprctl "keyword general:layout dwindle"
    hyprctl "keyword bind $mainMod, Tab, cyclenext"
fi
