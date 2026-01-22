#!/usr/bin/env bash
set -euo pipefail

# -------- logging (append-only) --------
LOG_DIR="$HOME/arch-postinstall-logs"
mkdir -p "$LOG_DIR"

TS="$(date '+%Y-%m-%d_%H-%M-%S')"
LOG_FILE="$LOG_DIR/postinstall_${TS}.log"

# Log everything: stdout + stderr
exec > >(tee -a "$LOG_FILE") 2>&1

echo "======================================="
echo " Arch Postinstall Logs"
echo " Log file: $LOG_FILE"
echo " Started : $(date)"
echo " User    : $(whoami)"
echo "======================================="

# -------- utils --------
die() { echo "ERROR: $*" >&2; exit 1; }

need_user() {
  if [[ "$EUID" -eq 0 ]]; then
    die "Do NOT run as root. Run as your user."
  fi
}

pac_install() {
  sudo pacman -S --needed --noconfirm "$@"
}

has_pkg() {
  pacman -Q "$1" >/dev/null 2>&1
}

kernel_pkg_for_running_kernel() {
  # Example output of uname -r: 6.7.4-arch1-1 -> want linux-headers
  # For linux-lts kernel: 6.6.x-lts -> want linux-lts-headers
  local krel
  krel="$(uname -r)"

  if echo "$krel" | grep -q 'lts'; then
    echo "linux-lts"
  elif echo "$krel" | grep -q 'zen'; then
    echo "linux-zen"
  elif echo "$krel" | grep -q 'hardened'; then
    echo "linux-hardened"
  else
    echo "linux"
  fi
}

install_kernel_headers_safe() {
  local kernel_pkg headers_pkg
  kernel_pkg="$(kernel_pkg_for_running_kernel)"
  headers_pkg="${kernel_pkg}-headers"

  echo "==> Detected running kernel: $(uname -r)"
  echo "==> Kernel package assumed: $kernel_pkg"
  echo "==> Headers package: $headers_pkg"

  if pacman -Qi "$kernel_pkg" >/dev/null 2>&1; then
    echo "==> $kernel_pkg is installed."
  else
    echo "WARNING: $kernel_pkg does NOT appear installed via pacman."
    echo "         Skipping header install to avoid mismatch."
    echo "         (If you use a custom kernel, install the correct headers manually.)"
    return 0
  fi

  if pacman -Qi "$headers_pkg" >/dev/null 2>&1; then
    echo "==> $headers_pkg already installed."
  else
    echo "==> Installing headers: $headers_pkg"
    pac_install "$headers_pkg"
  fi
}
