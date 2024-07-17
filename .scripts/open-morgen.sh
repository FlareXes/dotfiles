#!/usr/bin/env bash

active_window=$(hyprctl activewindow | awk '/class:/ {print $2}')

if [[ "$active_window" == "Morgen" ]]; then
    hyprctl dispatch killactive 
else
    morgen
fi
