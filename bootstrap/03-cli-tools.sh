#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> Modern CLI toolkit..."
pac_install \
  neovim \
  zoxide bat eza \
  jq fzf \
  tealdeer \
  wl-clipboard \
  mpv yt-dlp imv \
  brightnessctl playerctl

echo "✅ CLI tools installed."
