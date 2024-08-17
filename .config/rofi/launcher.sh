#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Current Styles
# type-1, style-9

dir="$HOME/.config/rofi/"
theme='style'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
