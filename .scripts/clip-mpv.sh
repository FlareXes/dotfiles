#!/bin/sh

# get url from clipboard
url="$(xclip -out -selection)"
url_ec="$?"

# if clipboard is not empty, abort and exit
if [[ $url_ec -ne 0 ]]; then
  notify-send -t 5000 -u critical -p "clipmpv" "Nothing to play"
  exit 1
fi

# extract video id
id=$(echo "$url" | grep -oE "watch\?v=.{11}")
# send playing notification
notify-send -t 5000 -p "clipmpv" "Playing url in mpv"
# play the video in mpv
mpv "https://youtube.com/$url" > /dev/null

# send notification is last command ends with 
# non-zero exit code or if any error occured
if [[ "$?" -ne 0 ]]; then
  notify-send -t 5000 -u critical -p "clipmpv" "Error: Falied to play video"
fi
