#!/usr/bin/env bash

trap '' SIGINT
set -e

DATE=$(date +%F)
SOURCE="$HOME/"
DESTINATION="/tmp/$DATE/"
EXCLUDE_FILE="$HOME/.rsync-exclude.txt"

rsync -azh --info=PROGRESS2 --delete --exclude-from="$EXCLUDE_FILE" "$SOURCE" "$DESTINATION"

if [[ "$?" -eq 0 ]]; then
    notify-send "Backup Successful"
else
    notify-send "Backup Failed"
fi

# Backup GitHub Repository
cd "$DESTINATION" && gitback --noauth --username flarexes --threads 5

# Archive the Backup
7z a -mhe -p "$HOME/$DATE.7z" "$DESTINATION"

# Upload to Server
SOURCE="$HOME/$DATE.7z"
DESTINATION="/home/craft/backups/$(date +%F)/"
REMOTE="server"

rsync -azh --info=PROGRESS2 --delete -e "ssh" "$SOURCE" "$REMOTE:$DESTINATION"
