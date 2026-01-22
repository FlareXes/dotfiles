#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> Fonts..."
pac_install \
  terminus-font \
  noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra \
  ttf-liberation ttf-dejavu \
  ttf-jetbrains-mono-nerd

echo "==> GTK theme..."
pac_install adw-gtk-theme papirus-icon-theme kvantum

echo "==> Font cache rebuild..."
fc-cache -fv

echo "✅ Fonts/themes done."
