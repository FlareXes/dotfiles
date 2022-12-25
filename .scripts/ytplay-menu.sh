#!/bin/sh

QUERY=$(rofi -dmenu -p "Search: " | tr ' ' '+')

if [ -z "$QUERY" ]; then
  notify-send -t 5000 -u critical -p "yt-menu" "Nothing to play"
  exit 1
fi

# send playing notification
notify-send -t 5000 -p "yt-menu" "Playing url in mpv"

# get the id of video you wanna play
VIDEO_ID=$(curl -s "https://vid.puffyan.us/search?q=$QUERY"| grep -oE "watch\?v=.{11}" | head -n 1)

# play the video in mpv
mpv "https://youtube.com/$VIDEO_ID" > /dev/null

# send notification is last command ends with
# non-zero exit code or if any error occured
if [[ "$?" -ne 0 ]]; then
  notify-send -t 5000 -u critical -p "yt-menu" "Error: Falied to play video"
fi

