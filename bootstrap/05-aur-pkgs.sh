#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

if command -v yay >/dev/null 2>&1; then
  echo "==> yay already installed."
  exit 0
fi

echo "==> Installing yay..."
cd /tmp
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo "✅ yay installed."

command -v yay >/dev/null 2>&1 || die "yay not installed."

echo "==> Installing AUR extras..."
yay -S --needed --noconfirm \
  ags-hyprpanel-git \
  matugen \
  python-pywalfox-librewolf

echo "✅ AUR extras installed."
