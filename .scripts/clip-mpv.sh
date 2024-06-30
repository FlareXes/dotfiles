#!/usr/bin/bash

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  url="$(wl-paste)"
else
  url="$(xclip -out -selection)"
fi

# if clipboard is not empty, abort and exit
if [[ "$?" -ne 0 ]]; then
  notify-send -t 3000 -u critical -p "clipmpv" "Nothing to play"
  exit 1
fi

# send playing notification
notify-send -t 3000 -p "clipmpv" "Playing url in mpv"

# play the video in mpv
mpv --script-opts-append=ytdl_hook-try_ytdl_first=yes --ytdl-raw-options=format-sort='proto:m3u8' $url > /dev/null

# send notification if last command ends with non-zero exit code
if [[ "$?" -ne 0 ]]; then
  notify-send -t 3000 -u critical -p "clipmpv" "Error: Falied to play video"
fi
