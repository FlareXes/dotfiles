#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> System update..."
sudo pacman -Syu --noconfirm

echo "==> Base essentials..."
pac_install \
  git base-devel curl wget \
  unzip \
  man-db man-pages \
  plocate

echo "==> Enable plocate updatedb timer..."
sudo systemctl enable --now plocate-updatedb.timer || true

echo "✅ Core base done."
