#!/usr/bin/env bash
# Install pi-glo as boot services on the Raspberry Pi.
#
#   ./install-pi.sh            services only (visualiser + BLE bridge)
#   ./install-pi.sh --kiosk    also start Chromium full-screen at login
#
# Reversible: ./install-pi.sh --uninstall
set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
HOME_DIR="$(getent passwd "$USER_NAME" | cut -d: -f6)"
APP_DIR="$HOME_DIR/pi-glo/web"
AUTOSTART="$HOME_DIR/.config/labwc/autostart"
MARK="# >>> pi-glo kiosk >>>"

need_sudo() { [ "$(id -u)" -eq 0 ] || exec sudo -E "$0" "$@"; }

uninstall() {
  systemctl disable --now piglo-server.service piglo-ble.service 2>/dev/null || true
  rm -f /etc/systemd/system/piglo-server.service /etc/systemd/system/piglo-ble.service
  systemctl daemon-reload
  if [ -f "$AUTOSTART" ]; then
    sed -i "/$MARK/,/# <<< pi-glo kiosk <<</d" "$AUTOSTART"
  fi
  echo "pi-glo removed. Desktop autostart left intact."
  exit 0
}

[ "${1:-}" = "--uninstall" ] && { need_sudo "$@"; uninstall; }
need_sudo "$@"

echo "Installing pi-glo for $USER_NAME ($APP_DIR)"
[ -f "$APP_DIR/server.py" ] || { echo "server.py not found in $APP_DIR"; exit 1; }

# ---- configuration -------------------------------------------------------
if [ ! -f /etc/default/piglo ]; then
  cat > /etc/default/piglo <<'CFG'
# Sensor source for the visualiser. Exactly one:
#   --idle                no serial glove attached; BLE swipe only
#   --port /dev/ttyACM0   the 6-IMU hand over USB serial
#   --simulate            synthetic everything, for testing without hardware
PIGLO_SOURCE=--idle

PIGLO_HTTP_PORT=8080
CFG
  echo "  wrote /etc/default/piglo (source: --idle)"
else
  echo "  kept existing /etc/default/piglo"
fi

# ---- visualiser ----------------------------------------------------------
cat > /etc/systemd/system/piglo-server.service <<SVC
[Unit]
Description=pi-glo visualiser
After=network-online.target

[Service]
User=$USER_NAME
WorkingDirectory=$APP_DIR
EnvironmentFile=/etc/default/piglo
ExecStart=/usr/bin/python3 server.py \$PIGLO_SOURCE --http-port \${PIGLO_HTTP_PORT}
Restart=always
RestartSec=3
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
SVC

# ---- BLE bridge ----------------------------------------------------------
cat > /etc/systemd/system/piglo-ble.service <<SVC
[Unit]
Description=pi-glo BLE bridge (Nano 33 BLE swipe gestures)
After=bluetooth.service piglo-server.service
Wants=bluetooth.service

[Service]
User=$USER_NAME
WorkingDirectory=$APP_DIR
EnvironmentFile=/etc/default/piglo
ExecStart=/usr/bin/python3 glove_ble.py --server http://localhost:\${PIGLO_HTTP_PORT}
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
SVC

systemctl daemon-reload
systemctl enable --now piglo-server.service piglo-ble.service
echo "  services enabled and started"

# ---- optional kiosk ------------------------------------------------------
if [ "${1:-}" = "--kiosk" ]; then
  # A user autostart file REPLACES the system one, so seed it from the system
  # copy first or the panel and desktop never start.
  if [ ! -f "$AUTOSTART" ]; then
    install -d -o "$USER_NAME" -g "$USER_NAME" "$(dirname "$AUTOSTART")"
    cp /etc/xdg/labwc/autostart "$AUTOSTART"
    chown "$USER_NAME:$USER_NAME" "$AUTOSTART"
    echo "  seeded $AUTOSTART from the system default"
  fi
  sed -i "/$MARK/,/# <<< pi-glo kiosk <<</d" "$AUTOSTART"
  PORT=$(grep -oP '(?<=^PIGLO_HTTP_PORT=).*' /etc/default/piglo | tr -d '"')
  cat >> "$AUTOSTART" <<KIOSK
$MARK
( sleep 8; /usr/bin/chromium-browser --ozone-platform=wayland --kiosk --noerrdialogs --disable-infobars \\
    --disable-session-crashed-bubble --check-for-update-interval=31536000 \\
    --disable-features=Translate http://localhost:${PORT}/ ) &
# <<< pi-glo kiosk <<<
KIOSK
  chown "$USER_NAME:$USER_NAME" "$AUTOSTART"
  echo "  kiosk added to $AUTOSTART (takes effect on next login/reboot)"
fi

echo
echo "Status:"
systemctl --no-pager --lines=0 status piglo-server.service piglo-ble.service 2>&1 | grep -E "^(●|   Active)" || true
echo
IP=$(hostname -I | awk '{print $1}')
PORT=$(grep -oP '(?<=^PIGLO_HTTP_PORT=).*' /etc/default/piglo | tr -d '"')
echo "  Local:   http://localhost:${PORT}/"
echo "  Network: http://${IP}:${PORT}/"
echo
echo "Switch to the USB-serial hand later by editing /etc/default/piglo:"
echo "  PIGLO_SOURCE=--port /dev/ttyACM0     then: sudo systemctl restart piglo-server"
