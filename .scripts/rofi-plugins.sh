#!/usr/bin/env bash

dir="$HOME/.config/rofi/"
theme='style'

choice=$(printf "Emoji\nCalculator" | rofi -dmenu -theme ${dir}/${theme}.rasi)

if [[ "$choice" == "Calculator" ]]; then
    rofi -show calc -modi calc -no-show-match -no-sort -theme ${dir}/${theme}.rasi
elif [[ "$choice" == "Emoji" ]]; then
    rofi -modi emoji -show emoji -theme ${dir}/${theme}.rasi
fi

