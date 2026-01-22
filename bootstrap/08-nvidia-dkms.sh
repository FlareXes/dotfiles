#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

echo "==> NVIDIA DKMS setup..."
install_kernel_headers_safe

echo "==> Installing nvidia-dkms..."
pac_install nvidia-dkms

echo "✅ NVIDIA dkms done."
echo "NOTE: Reboot recommended."
