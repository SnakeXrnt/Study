#!/usr/bin/env bash
# Take a fresh Raspberry Pi OS (with desktop) install to the point where
# install-pi.sh can run. Safe to re-run.
#
#   sudo ./bootstrap-pi.sh
#
# Assumes the "with desktop" image. On Lite, labwc, lightdm and the Pi's
# Chromium packaging are absent and this will tell you so rather than guess.
set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
LIGHTDM_CONF="/etc/lightdm/lightdm.conf"

need_sudo() { [ "$(id -u)" -eq 0 ] || exec sudo -E "$0" "$@"; }
need_sudo "$@"

echo "Bootstrapping pi-glo prerequisites for $USER_NAME"
echo

# ---- sanity -------------------------------------------------------------
ARCH="$(uname -m)"
[ "$ARCH" = "aarch64" ] || { echo "Expected a 64-bit OS, found $ARCH. Reflash with the 64-bit image."; exit 1; }
MODEL="$(tr -d '\0' < /proc/device-tree/model 2>/dev/null || echo unknown)"
. /etc/os-release
echo "  board:  $MODEL"
echo "  os:     $PRETTY_NAME ($VERSION_CODENAME), $ARCH"
echo

# ---- packages -----------------------------------------------------------
# bleak and dbus-fast come from apt, never pip: Debian marks the system Python
# externally-managed and pip refuses outright.
PKGS=(python3-bleak python3-dbus-fast python3-serial wlr-randr grim curl rsync)
echo "Installing: ${PKGS[*]}"
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "${PKGS[@]}"
echo "  done"
echo

# ---- things the desktop image is supposed to have already ---------------
missing=0
for cmd in labwc lightdm; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "  MISSING: $cmd — this looks like Raspberry Pi OS Lite."
    missing=1
  fi
done
if ! command -v chromium-browser >/dev/null 2>&1 && ! command -v chromium >/dev/null 2>&1; then
  echo "  MISSING: chromium"
  missing=1
fi
if [ "$missing" -eq 1 ]; then
  cat <<'EOF'

  Install the missing pieces, or reflash with the "with desktop" image:

      sudo apt install labwc lightdm chromium

  The desktop image also ships /usr/bin/labwc-pi, /usr/bin/setup_env and
  /etc/xdg/labwc/*, which the kiosk session borrows for cursor theme, keyboard
  layout and output setup. Without them the kiosk still runs, but you lose those.
EOF
  echo
fi

# ---- serial access for the 6-IMU glove ----------------------------------
if id -nG "$USER_NAME" | tr ' ' '\n' | grep -qx dialout; then
  echo "  $USER_NAME is already in 'dialout' (serial access)"
else
  usermod -aG dialout "$USER_NAME"
  echo "  added $USER_NAME to 'dialout' — log out and back in for it to apply"
fi

# ---- auto-login, so the kiosk comes up on power-on -----------------------
if [ -f "$LIGHTDM_CONF" ]; then
  if grep -q "^autologin-user=" "$LIGHTDM_CONF"; then
    sed -i "s/^autologin-user=.*/autologin-user=$USER_NAME/" "$LIGHTDM_CONF"
  else
    sed -i "/^\[Seat:\*\]/a autologin-user=$USER_NAME" "$LIGHTDM_CONF"
  fi
  echo "  auto-login user set to $USER_NAME"
else
  echo "  WARNING: $LIGHTDM_CONF not found; set auto-login by hand"
fi

# ---- report -------------------------------------------------------------
echo
echo "Versions installed:"
for p in "${PKGS[@]}" labwc lightdm chromium; do
  v="$(dpkg-query -W -f='${Version}' "$p" 2>/dev/null || true)"
  printf "  %-20s %s\n" "$p" "${v:-not installed}"
done
echo
echo "Next:"
echo "  1. copy the app over:   rsync -az --delete --exclude __pycache__ web/ <pi>:~/pi-glo/web/"
echo "  2. install services:    cd ~/pi-glo/web && sudo ./install-pi.sh --kiosk"
echo "  3. reboot and check it comes up on its own"
