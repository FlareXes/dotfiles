#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/0-common.sh"
need_user

# =========================
# Resolution-aware boot tweaks
# =========================

# Default threshold:
# - 2560 wide = typical 1440p/1600p+ panels where TTY is tiny
HIDPI_MIN_WIDTH=2560

get_fb_resolution() {
  # primary source (simple + available on many systems)
  # format: "WIDTH,HEIGHT"
  if [[ -r /sys/class/graphics/fb0/virtual_size ]]; then
    cat /sys/class/graphics/fb0/virtual_size
    return 0
  fi
  return 1
}

get_tty_resolution() {
  # fallback: uses stty output on current TTY (not pixels)
  # not super useful alone, but can help in absence of fb info
  if command -v stty >/dev/null 2>&1; then
    stty size 2>/dev/null || true
  fi
}

get_xrandr_resolution() {
  # fallback if user is inside graphical session
  if command -v xrandr >/dev/null 2>&1; then
    xrandr 2>/dev/null | awk '/\*/ {print $1; exit}'
  fi
}

parse_resolution_width() {
  # Accepts:
  # - "3840,2160" (fb0 virtual_size)
  # - "3840x2160" (xrandr)
  # Returns width only
  local s="$1"

  if [[ "$s" =~ ^([0-9]+),([0-9]+)$ ]]; then
    echo "${BASH_REMATCH[1]}"
    return 0
  fi

  if [[ "$s" =~ ^([0-9]+)x([0-9]+)$ ]]; then
    echo "${BASH_REMATCH[1]}"
    return 0
  fi

  return 1
}

backup_file_once() {
  # Backup file only if it exists; don't overwrite old backups
  local f="$1"
  if [[ -f "$f" ]]; then
    local bak="${f}.bak"
    if [[ ! -f "$bak" ]]; then
      sudo cp -a "$f" "$bak"
      echo "==> Backup created: $bak"
    else
      echo "==> Backup exists:  $bak (kept)"
    fi
  fi
}

detect_width() {
  local fb res w

  # 1) fb resolution (best)
  if fb="$(get_fb_resolution 2>/dev/null)"; then
    if w="$(parse_resolution_width "$fb" 2>/dev/null)"; then
      echo "$w"
      return 0
    fi
  fi

  # 2) xrandr if available
  if res="$(get_xrandr_resolution 2>/dev/null)"; then
    if w="$(parse_resolution_width "$res" 2>/dev/null)"; then
      echo "$w"
      return 0
    fi
  fi

  # unknown
  return 1
}

apply_systemdboot_console_mode() {
  local mode="$1"
  local LOADER_CONF="/boot/loader/loader.conf"

  if [[ ! -f "$LOADER_CONF" ]]; then
    echo "WARNING: $LOADER_CONF not found. (Maybe not using systemd-boot?) Skipping."
    return 0
  fi

  backup_file_once "$LOADER_CONF"

  if grep -q '^console-mode' "$LOADER_CONF"; then
    sudo sed -i "s/^console-mode.*/console-mode ${mode}/" "$LOADER_CONF"
  else
    echo "console-mode ${mode}" | sudo tee -a "$LOADER_CONF" >/dev/null
  fi

  echo "==> systemd-boot: set console-mode ${mode}"
}

apply_vconsole_font() {
  local font="$1"
  local VCONSOLE="/etc/vconsole.conf"

  sudo touch "$VCONSOLE"
  backup_file_once "$VCONSOLE"

  if grep -q '^FONT=' "$VCONSOLE"; then
    sudo sed -i "s/^FONT=.*/FONT=${font}/" "$VCONSOLE"
  else
    echo "FONT=${font}" | sudo tee -a "$VCONSOLE" >/dev/null
  fi

  echo "==> vconsole: set FONT=${font}"
  sudo systemctl restart systemd-vconsole-setup || true
}

echo "==> Resolution-aware boot tweaks starting..."
echo "==> HiDPI threshold width: ${HIDPI_MIN_WIDTH}px"

WIDTH=""
if WIDTH="$(detect_width 2>/dev/null)"; then
  echo "==> Detected framebuffer/display width: ${WIDTH}px"
else
  echo "WARNING: Could not detect resolution width safely."
  echo "         Will not apply HiDPI tweaks automatically."
  echo
  echo "Tip: You can force-run tweaks manually by exporting:"
  echo "  HIDPI_FORCE=1 ./10-boot-tweaks.sh"
fi

# Force override
HIDPI_FORCE="${HIDPI_FORCE:-0}"

if [[ "$HIDPI_FORCE" == "1" ]]; then
  echo "==> HIDPI_FORCE=1 set: forcing HiDPI boot tweaks."
  apply_systemdboot_console_mode 1
  apply_vconsole_font "ter-v32b"
  echo "✅ Boot tweaks applied (forced)."
  exit 0
fi

# Auto decision
if [[ -n "${WIDTH:-}" ]] && [[ "$WIDTH" -ge "$HIDPI_MIN_WIDTH" ]]; then
  echo "==> HiDPI detected (width >= ${HIDPI_MIN_WIDTH}). Applying readability tweaks."
  apply_systemdboot_console_mode 1
  apply_vconsole_font "ter-v32b"
  echo "✅ Boot tweaks applied for HiDPI."
else
  echo "==> Not HiDPI (or unknown). Skipping readability tweaks."
  echo "==> No changes made."
fi
