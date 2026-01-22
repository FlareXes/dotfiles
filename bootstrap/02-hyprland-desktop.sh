#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> Desktop compositor + session bits..."
pac_install \
  hyprland hypridle hyprlock hyprpicker \
  xdg-desktop-portal-hyprland \
  qt5-wayland qt6-wayland \
  polkit-gnome \
  udiskie \
  nwg-look \
  swww \
  wofi

echo "✅ Hyprland desktop packages done."
echo "NOTE: Add polkit agent autostart to hyprland.conf:"
echo "exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
