#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$DIR/01-core-base.sh"
bash "$DIR/02-hyprland-desktop.sh"
bash "$DIR/03-cli-tools.sh"
bash "$DIR/04-fonts-theme.sh"
bash "$DIR/05-aur-pkgs.sh"
bash "$DIR/06-shell-ohmyzsh.sh"
bash "$DIR/07-boot-tweaks.sh"
bash "$DIR/08-nvidia-dkms.sh"
bash "$DIR/09-final.sh"
