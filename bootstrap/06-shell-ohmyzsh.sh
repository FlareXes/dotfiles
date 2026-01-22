#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> Installing zsh..."
pac_install zsh

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "==> oh-my-zsh already present."
fi

echo "==> Set default shell to zsh..."
sudo chsh -s /usr/bin/zsh "$(whoami)"

echo "✅ zsh + oh-my-zsh done."
