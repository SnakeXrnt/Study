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
LAUNCHER="/usr/local/bin/piglo-kiosk"
# Outside APP_DIR on purpose: web/ is rsynced with --delete, which would wipe
# anything generated in there on the next deploy.
CH_PROFILE="$HOME_DIR/.config/piglo-chromium"

# The kiosk gets its own compositor session. The stock one is started as
# `labwc -m`, and -m means --merge-config: labwc then runs the autostart in
# EVERY XDG base dir, so a user autostart does not replace the system one, it
# runs alongside it. Seeding a user file therefore launched the whole desktop
# twice. A separate session with its own config dir and no -m starts the
# compositor and nothing else.
CONFIGTOOL="/usr/local/bin/piglo-config"
DISPLAYS="/usr/local/bin/piglo-displays"
TOUCH_RULE="/etc/udev/rules.d/99-piglo-touch.rules"
SESSION_BIN="/usr/local/bin/piglo-session"
SESSION_DESKTOP="/usr/share/wayland-sessions/piglo-kiosk.desktop"
PIGLO_ETC="/etc/piglo"
LABWC_DIR="$PIGLO_ETC/labwc"
LIGHTDM_CONF="/etc/lightdm/lightdm.conf"

need_sudo() { [ "$(id -u)" -eq 0 ] || exec sudo -E "$0" "$@"; }

uninstall() {
  systemctl disable --now piglo-server.service piglo-ble.service 2>/dev/null || true
  rm -f /etc/systemd/system/piglo-server.service /etc/systemd/system/piglo-ble.service
  systemctl daemon-reload
  if [ -f "$AUTOSTART" ]; then
    sed -i "/$MARK/,/# <<< pi-glo kiosk <<</d" "$AUTOSTART"
  fi
  # Put auto-login back on whatever session it used before the kiosk took over.
  PREV="LXDE-pi-labwc"
  [ -f "$PIGLO_ETC/previous-session" ] && PREV=$(cat "$PIGLO_ETC/previous-session")
  if [ -f "$LIGHTDM_CONF" ] && grep -q "^autologin-session=" "$LIGHTDM_CONF"; then
    sed -i "s|^autologin-session=.*|autologin-session=$PREV|" "$LIGHTDM_CONF"
    echo "  auto-login session restored to $PREV"
  fi
  rm -f "$LAUNCHER" "$DISPLAYS" "$CONFIGTOOL" "$SESSION_BIN" "$SESSION_DESKTOP" "$TOUCH_RULE"
  rm -rf "$PIGLO_ETC"
  rm -f /etc/sudoers.d/piglo-config
  echo "pi-glo removed. Desktop autostart and the Chromium profile left intact."
  exit 0
}

[ "${1:-}" = "--uninstall" ] && { need_sudo "$@"; uninstall; }
need_sudo "$@"

echo "Installing pi-glo for $USER_NAME ($APP_DIR)"
install -d -o "$USER_NAME" -g "$USER_NAME" "$HOME_DIR/pi-glo/music"
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

# Folder of audio for the swipe demo. Deliberately outside the app directory:
# deploys rsync web/ with --delete and would erase anything put inside it.
PIGLO_MUSIC=$HOME_DIR/pi-glo/music

# Mirror every connected display onto one shared logical area, so a projector
# shows exactly what the touch panel shows. Set to "no" to leave displays alone.
PIGLO_MIRROR=yes

# The logical size both displays are mapped to. Landscape, because the audience
# sees the projector.
#
# 960x540 is chosen so a 1920x1080 monitor lands on an exact 2x scale, which is
# the sharpest case there is and also the cheapest. Everything is drawn twice
# the size and still rendered into every real pixel the monitor has. Measured on
# the Pi 5, 2026-09-11: 13% of a core, against 55% at 1280x720 with a 1.5 scale.
#
# It must NOT exceed the smallest display's native size. Going above it gives
# that display a scale below 1, and Chromium then sizes its window wrongly and
# fills only part of the screen. The touch panel is 1280x720 once rotated, so
# that is the ceiling; 960x540 sits safely under it.
PIGLO_LOGICAL=960x540

# How much bigger to draw the interface. At 1920x1080 everything is small on a
# projector seen from across a room. 1.5 gives a 1280x720 layout rendered into
# 1920x1080 real pixels: same legibility as a 720p screen, none of the blur.
PIGLO_UI_SCALE=1.5

# The touch panel is portrait natively and gets rotated to landscape.
# Use 90 or 270 depending on which way round the panel is mounted.
PIGLO_PANEL_TRANSFORM=90

# Fastest refresh rate to use. The panel is 60Hz and the glove sends 20Hz, so
# there is nothing to gain above 60, and this monitor offers 144.
PIGLO_REFRESH_MAX=60

# Display mode for the kiosk, used only when PIGLO_MIRROR=no. Blank leaves the
# monitor on its preferred mode. The 3D hand costs roughly 134ms a frame at
# 2560x1440 and 83ms at 1920x1080 on a Pi 4, so a lower mode buys frame rate.
PIGLO_MODE=1920x1080@60
CFG
  echo "  wrote /etc/default/piglo (source: --idle)"
else
  echo "  kept existing /etc/default/piglo"
  # Top up any setting added since this file was first written, without
  # touching the ones already there. An upgrade must never quietly reset the
  # sensor source someone chose.
  add_setting() {
    grep -q "^$1=" /etc/default/piglo && return 0
    printf '\n%s\n%s=%s\n' "$2" "$1" "$3" >> /etc/default/piglo
    echo "  added $1 to /etc/default/piglo"
  }
  add_setting PIGLO_MUSIC \
    "# Folder of audio for the swipe demo. Outside the app directory on purpose:
# deploys rsync web/ with --delete and would erase anything inside it." "$HOME_DIR/pi-glo/music"
  add_setting PIGLO_MIRROR \
    "# Mirror every connected display onto one shared logical area, so a projector
# shows exactly what the touch panel shows. Set to \"no\" to leave displays alone." yes
  add_setting PIGLO_LOGICAL \
    "# The logical size both displays are mapped to. 960x540 puts a 1920x1080
# monitor on an exact 2x scale: biggest text, sharpest image, cheapest to draw.
# Must not exceed the smallest display's native size." 960x540
  add_setting PIGLO_UI_SCALE \
    "# How much bigger to draw the interface, so 1920x1080 stays legible on a
# projector without giving up resolution." 1.5
  add_setting PIGLO_PANEL_TRANSFORM \
    "# The touch panel is portrait natively and gets rotated to landscape.
# Use 90 or 270 depending on which way round the panel is mounted." 90
  add_setting PIGLO_TOUCH_MATRIX \
    "# libinput calibration matrix for the touchscreen. Blank derives it from
# PIGLO_PANEL_TRANSFORM. Rotating an output does not rotate its touch input, so
# this is what actually makes presses land where you press.
#   90 -> 0 -1 1 1 0 0     270 -> 0 1 0 -1 0 1     180 -> -1 0 1 0 -1 1" ""
  add_setting PIGLO_REFRESH_MAX \
    "# Fastest refresh rate to use. The panel is 60Hz and the glove sends 20Hz,
# so there is nothing to gain above 60." 60
  add_setting PIGLO_MODE \
    "# Display mode for the kiosk, used only when PIGLO_MIRROR=no." 1920x1080@60
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
ExecStart=/usr/bin/python3 server.py \$PIGLO_SOURCE --http-port \${PIGLO_HTTP_PORT} --music \${PIGLO_MUSIC}
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

# ---- the settings helper ------------------------------------------------
# The visualiser runs as an ordinary user and must never be given general root
# just to change a setting. This helper is the entire privileged surface: it
# accepts a fixed list of keys, validates every value against a pattern, and
# writes nothing else. Anything unrecognised is refused.
cat > "$CONFIGTOOL" <<'CFGTOOL'
#!/bin/sh
# pi-glo settings helper. Generated by install-pi.sh — edit there, not here.
#
#   piglo-config get
#   piglo-config set KEY VALUE
#   piglo-config restart
#
# Deliberately tiny and deliberately strict. It is reached over sudo from a web
# server that anyone on the network can talk to, so the whitelist below is the
# security boundary. Add a key only with a pattern that cannot express a shell
# metacharacter.
set -eu
CFG=/etc/default/piglo

# key:pattern. The pattern is a POSIX ERE the whole value must match.
allowed() {
  case "$1" in
    PIGLO_SOURCE)          echo '^--(idle|simulate|port /dev/tty[A-Za-z0-9]+|replay [A-Za-z0-9._/-]+)$' ;;
    PIGLO_HTTP_PORT)       echo '^[0-9]{2,5}$' ;;
    PIGLO_MUSIC)           echo '^/[A-Za-z0-9._/ -]+$' ;;
    PIGLO_MIRROR)          echo '^(yes|no)$' ;;
    PIGLO_LOGICAL)         echo '^[0-9]{3,4}x[0-9]{3,4}$' ;;
    PIGLO_PANEL_TRANSFORM) echo '^(normal|90|180|270)$' ;;
    PIGLO_REFRESH_MAX)     echo '^[0-9]{2,3}$' ;;
    PIGLO_TOUCH_MATRIX)    echo '^(-?[0-9.]+( -?[0-9.]+){5})?$' ;;
    PIGLO_MODE)            echo '^([0-9]{3,4}x[0-9]{3,4}(@[0-9.]+)?)?$' ;;
    *)                     echo "" ;;
  esac
}

case "${1:-}" in
  get)
    grep -E '^PIGLO_[A-Z_]+=' "$CFG" 2>/dev/null || true
    ;;
  set)
    KEY="${2:-}"; VALUE="${3:-}"
    PAT="$(allowed "$KEY")"
    [ -n "$PAT" ] || { echo "refused: unknown key $KEY" >&2; exit 2; }

    # Reject control characters BEFORE matching the pattern. grep works a line
    # at a time, so a value like "yes\nPIGLO_OTHER=x" would match the pattern on
    # its first line and then be written whole, appending a second key. systemd
    # reads this file as an EnvironmentFile, so that is arbitrary environment
    # injection into the service. Found by review on 2026-09-11 and confirmed
    # exploitable before this check existed.
    # Compare byte counts rather than inspecting the stripped result: command
    # substitution removes trailing newlines, so a value ending in one looked
    # empty and slipped through the first version of this check.
    RAW=$(printf '%s' "$VALUE" | wc -c)
    VIS=$(printf '%s' "$VALUE" | LC_ALL=C tr -cd '[:print:]' | wc -c)
    if [ "$RAW" -ne "$VIS" ]; then
      echo "refused: control characters in value for $KEY" >&2; exit 3
    fi

    # The trailing newline keeps an intentionally empty value matchable; without
    # it grep sees no lines at all and refuses every empty value.
    printf '%s\n' "$VALUE" | grep -Eq "$PAT" || { echo "refused: bad value for $KEY" >&2; exit 3; }
    if grep -q "^$KEY=" "$CFG"; then
      TMP="$(mktemp)"
      awk -v k="$KEY" -v v="$VALUE" '
        $0 ~ "^" k "=" { print k "=" v; done = 1; next }
        { print }
        END { if (!done) print k "=" v }
      ' "$CFG" > "$TMP" && cat "$TMP" > "$CFG" && rm -f "$TMP"
    else
      printf '%s=%s\n' "$KEY" "$VALUE" >> "$CFG"
    fi
    echo "$KEY=$VALUE"
    ;;
  restart)
    # --no-block so the caller is not killed mid-reply when it restarts itself.
    systemctl restart --no-block piglo-server.service
    echo "restarting piglo-server"
    ;;

  # ---- WiFi -------------------------------------------------------------
  # Reading is unprivileged, but joining a network is not, so it comes through
  # here. The password is NEVER passed as an argument: it arrives on stdin and
  # goes straight to nmcli --ask, so it does not appear in the process list, in
  # this script's arguments, or in any log.
  wifi-status)
    DEV=$(nmcli -t -f NAME,TYPE,DEVICE con show --active | awk -F: '$2 == "802-11-wireless" { print $3; exit }')
    nmcli -t -f NAME,TYPE,DEVICE con show --active | awk -F: '$2 == "802-11-wireless" { print "ssid=" $1; print "device=" $3 }'
    nmcli -t -f IN-USE,SSID,SIGNAL dev wifi list 2>/dev/null | awk -F: '$1 == "*" { print "signal=" $3 }'
    [ -n "$DEV" ] && nmcli -t -f DEVICE,STATE dev | awk -F: -v d="$DEV" '$1 == d { print "state=" $2 }'
    # The address of whichever interface is actually carrying the connection,
    # which is the one to type into a phone.
    [ -n "$DEV" ] && ip -4 -o addr show dev "$DEV" 2>/dev/null \
      | awk '{ split($4, a, "/"); print "ip=" a[1]; exit }'
    ;;
  wifi-list)
    # One line per network, strongest first, duplicates collapsed.
    nmcli --get-values IN-USE,SSID,SIGNAL,SECURITY dev wifi list --rescan auto 2>/dev/null \
      | awk -F: 'NF >= 4 && $2 != "" && !seen[$2]++ { print $1 "|" $2 "|" $3 "|" $4 }' \
      | sort -t"|" -k3,3nr
    ;;
  wifi-connect)
    SSID="${2:-}"
    [ -n "$SSID" ] || { echo "refused: no network named" >&2; exit 2; }
    # Reads the password from stdin. An open network sends an empty line.
    if [ -t 0 ]; then
      nmcli dev wifi connect "$SSID" 2>&1
    else
      nmcli --ask dev wifi connect "$SSID" 2>&1
    fi
    ;;
  # ---- Bluetooth audio --------------------------------------------------
  # The adapter is shared with the glove's BLE link, which is the whole reason
  # this is treated carefully. Scanning was measured not to disturb the glove;
  # streaming is the case to watch.
  bt-scan)
    SECS="${2:-12}"
    printf '%s' "$SECS" | grep -Eq '^[0-9]{1,2}$' || SECS=12
    # Zero means "just list what is already known", so the page can show the
    # current state without putting the radio to work next to the glove.
    [ "$SECS" -gt 0 ] && bluetoothctl --timeout "$SECS" scan on >/dev/null 2>&1
    for mac in $(bluetoothctl devices 2>/dev/null | awk '{print $2}'); do
      info=$(bluetoothctl info "$mac" 2>/dev/null) || continue
      icon=$(printf '%s' "$info" | awk -F': ' '/Icon:/ { print $2; exit }')
      case "$icon" in
        audio*|*headset*|*speaker*|*headphones*) ;;
        *) continue ;;
      esac
      name=$(printf '%s' "$info" | awk -F': ' '/Name:/ { print $2; exit }')
      paired=$(printf '%s' "$info" | awk -F': ' '/Paired:/ { print $2; exit }')
      conn=$(printf '%s' "$info" | awk -F': ' '/Connected:/ { print $2; exit }')
      printf '%s|%s|%s|%s\n' "$mac" "${name:-$mac}" "$paired" "$conn"
    done
    ;;
  bt-connect|bt-disconnect|bt-forget)
    MAC="${2:-}"
    printf '%s' "$MAC" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$' \
      || { echo "refused: not a Bluetooth address" >&2; exit 2; }
    case "$1" in
      bt-connect)
        # Pair only if it is not already bonded. Most speakers are "just works";
        # one needing a PIN will fail here rather than hang.
        if ! bluetoothctl info "$MAC" 2>/dev/null | grep -q "Paired: yes"; then
          bluetoothctl --timeout 25 pair "$MAC" 2>&1 | tail -2
        fi
        bluetoothctl trust "$MAC" 2>&1 | tail -1
        bluetoothctl --timeout 20 connect "$MAC" 2>&1 | tail -2
        ;;
      bt-disconnect) bluetoothctl disconnect "$MAC" 2>&1 | tail -1 ;;
      bt-forget)     bluetoothctl remove "$MAC" 2>&1 | tail -1 ;;
    esac
    ;;
  wifi-forget)
    SSID="${2:-}"
    [ -n "$SSID" ] || { echo "refused: no network named" >&2; exit 2; }
    nmcli con delete "$SSID" 2>&1
    ;;
  *)
    echo "usage: piglo-config get | set KEY VALUE | restart | wifi-status | wifi-list | wifi-connect SSID | wifi-forget SSID | bt-scan [s] | bt-connect MAC | bt-disconnect MAC | bt-forget MAC" >&2; exit 1 ;;
esac
CFGTOOL
chmod 755 "$CONFIGTOOL"
echo "  wrote $CONFIGTOOL"

# Narrow sudo: this one command, no password, nothing else.
cat > /etc/sudoers.d/piglo-config <<SUDO
$USER_NAME ALL=(root) NOPASSWD: $CONFIGTOOL
SUDO
chmod 440 /etc/sudoers.d/piglo-config
visudo -cf /etc/sudoers.d/piglo-config >/dev/null && echo "  sudo rule installed for $CONFIGTOOL"

systemctl daemon-reload
systemctl enable --now piglo-server.service piglo-ble.service
echo "  services enabled and started"

# ---- optional kiosk ------------------------------------------------------
if [ "${1:-}" = "--kiosk" ]; then
  # Chromium is configured entirely by flags below, so there is no profile file
  # to write. It gets its own user-data-dir so the demo never inherits whatever
  # browsing state the desktop user has.
  install -d -o "$USER_NAME" -g "$USER_NAME" "$CH_PROFILE"

  cat > "$DISPLAYS" <<'DISPLAYS_EOF'
#!/bin/sh
# Put every enabled display onto the same logical area, which is how wlroots
# mirrors: outputs are views into one shared layout, so two outputs covering the
# same area both render the same thing.
#
# The important part is HOW they are matched. Measured on the Pi 5, 2026-09-11,
# same page and same scene:
#
#   projector 1920x1080 scaled 1.5 to match the panel   38 fps, 33ms
#   both displays on a native 1280x720 mode, scale 1     60 fps, 17ms
#   panel alone, no mirroring at all                     60 fps, 17ms
#
# So mirroring is free and fractional scaling is not. A non-integer scale makes
# the browser render at 1.5x and the compositor rescale every frame, and it cost
# nearly half the frame rate. This script therefore prefers a mode that gives the
# logical size natively on each output, and only falls back to scaling when no
# such mode exists.
#
# The trade-off is that the projector runs at PIGLO_LOGICAL rather than its
# full resolution. For an audience watching a 3D hand that is a good trade.
#
# Generated by install-pi.sh — edit there, not here.
set -eu

CFG=/etc/default/piglo
val() { sed -n "s/^$1=//p" "$CFG" 2>/dev/null | tr -d '"' | head -1; }

[ "$(val PIGLO_MIRROR)" = "yes" ] || exit 0
command -v wlr-randr >/dev/null 2>&1 || exit 0

LOGICAL="$(val PIGLO_LOGICAL)"; LOGICAL="${LOGICAL:-1280x720}"
TRANSFORM="$(val PIGLO_PANEL_TRANSFORM)"; TRANSFORM="${TRANSFORM:-90}"
MAXHZ="$(val PIGLO_REFRESH_MAX)"; MAXHZ="${MAXHZ:-60}"
LW="${LOGICAL%x*}"
LH="${LOGICAL#*x}"

SNAPSHOT="$(wlr-randr 2>/dev/null)" || exit 0
[ -n "$SNAPSHOT" ] || exit 0

echo "$SNAPSHOT" | awk '/^[A-Za-z0-9]/ { print $1 }' | while read -r NAME; do
  [ -n "$NAME" ] || continue

  # Just this output's block of the report.
  BLOCK="$(printf '%s\n' "$SNAPSHOT" | awk -v n="$NAME" '
      $0 ~ "^" n " " { inblock = 1; next }
      /^[A-Za-z0-9]/  { inblock = 0 }
      inblock')"

  printf '%s\n' "$BLOCK" | grep -q "Enabled: yes" || continue

  # The display's own preferred mode, which is its native resolution. Not the
  # current one: a previous run may have left it on something lower, and then
  # it would never climb back up.
  CUR="$(printf '%s\n' "$BLOCK" | awk '/preferred/ { print $1; exit }')"
  [ -n "$CUR" ] || CUR="$(printf '%s\n' "$BLOCK" | awk '/current/ { print $1; exit }')"
  case "$CUR" in *x*) ;; *) continue ;; esac
  W="${CUR%x*}"; H="${CUR#*x}"

  # Taller than wide means the portrait touch panel, which gets rotated. After
  # rotating, the mode we want is the logical size with its sides swapped.
  if [ "$H" -gt "$W" ]; then
    TR="$TRANSFORM"; WANT="${LH}x${LW}"; EFF="$H"
  else
    TR="normal";     WANT="${LW}x${LH}"; EFF="$W"
  fi

  # Run every display at its OWN native resolution and scale it to the shared
  # logical size. That is what keeps the projector sharp: it gets a real
  # 1920x1080 signal rather than an upscaled 720p one.
  #
  # Measured on the Pi 5, 2026-09-11:
  #   both forced to a native 1280x720            60 fps, but a 1080p monitor
  #                                               upscales it and text is blurry
  #   each native, projector 1920x1080 scaled 1.5 38 fps, and sharp
  #
  # 38 fps is plenty here: the glove produces 20 new poses a second, so the
  # extra frames never carried new information. Sharpness wins.
  #
  # One thing to avoid: a logical size LARGER than a display's native size gives
  # that display a scale below 1, and Chromium then sizes its window wrongly and
  # fills only part of the screen. Keep PIGLO_LOGICAL at or below the smallest
  # display's native size.
  #
  # Refresh rate is chosen, not left to chance: monitors commonly list the
  # cinema rate first, which looks like a slideshow, and the fastest is not
  # right either since this one offers 144Hz against a 60Hz panel.
  HZ="$(printf '%s\n' "$BLOCK" \
        | awk -v want="$CUR" -v cap="$MAXHZ" '
            $1 == want && $2 == "px," {
              r = $3 + 0
              if (r <= cap) { if (r > best) best = r }
              else          { if (over == 0 || r < over) over = r }
            }
            END { if (best > 0) printf "%.3f", best; else if (over > 0) printf "%.3f", over }')"

  SCALE="$(awk -v e="$EFF" -v l="$LW" 'BEGIN { printf "%.6f", e / l }')"
  if [ -n "$HZ" ]; then MODEARG="${CUR}@${HZ}Hz"; else MODEARG="$CUR"; fi

  if wlr-randr --output "$NAME" --mode "$MODEARG" --transform "$TR" --pos 0,0 --scale "$SCALE" 2>/dev/null; then
    echo "piglo-displays: $NAME -> $MODEARG native, transform $TR, scale $SCALE"
  else
    echo "piglo-displays: could not arrange $NAME" >&2
  fi
done
DISPLAYS_EOF
  chmod 755 "$DISPLAYS"
  echo "  wrote $DISPLAYS"

  cat > "$LAUNCHER" <<LAUNCH
#!/bin/sh
# pi-glo kiosk launcher. Generated by install-pi.sh — edit there, not here.
set -eu

PORT="\$(sed -n 's/^PIGLO_HTTP_PORT=//p' /etc/default/piglo | tr -d '"' | head -1)"
MODE="\$(sed -n 's/^PIGLO_MODE=//p' /etc/default/piglo | tr -d '"' | head -1)"
# Draw the interface larger without dropping resolution: the window stays at
# the projector's native size and the page scales itself. Chromium's
# --force-device-scale-factor was tried and is wrong on Wayland; it sized the
# window in scaled units so it filled only part of the screen.
UI_SCALE="\$(sed -n 's/^PIGLO_UI_SCALE=//p' /etc/default/piglo | tr -d '"' | head -1)"
URL="http://localhost:\${PORT:-8080}/"
[ -n "\$UI_SCALE" ] && [ "\$UI_SCALE" != "1" ] && URL="\${URL}?ui=\${UI_SCALE}"
PROFILE="$CH_PROFILE"

# Arrange the displays first. With PIGLO_MIRROR=yes this mirrors every screen
# onto one logical area and PIGLO_MODE is not used; the projector then shows
# exactly what the panel shows.
MIRROR="\$(sed -n 's/^PIGLO_MIRROR=//p' /etc/default/piglo | tr -d '"' | head -1)"
if [ "\$MIRROR" = "yes" ]; then
  /usr/local/bin/piglo-displays || true
  MODE=""
fi

# Otherwise set a single display mode, if one is configured and the screen
# actually offers it. Forcing a mode a panel does not have just fails silently,
# so check first and say so in the log when it does not apply.
if [ -n "\$MODE" ] && command -v wlr-randr >/dev/null 2>&1; then
  OUT="\$(wlr-randr 2>/dev/null | awk '/^[A-Za-z0-9]/ { print \$1; exit }')"
  RES="\${MODE%@*}"
  if [ -n "\$OUT" ] && wlr-randr 2>/dev/null | grep -q "\$RES px"; then
    wlr-randr --output "\$OUT" --mode "\$MODE" 2>/dev/null || true
  else
    echo "piglo-kiosk: \$RES not offered by \${OUT:-this display}; leaving the mode as it is" >&2
  fi
fi

# Wait for the visualiser to actually answer rather than guessing with a fixed
# sleep. If it never comes up we still launch, so the failure is visible on
# screen instead of leaving a blank desktop with no explanation.
i=0
while [ "\$i" -lt 90 ]; do
  curl -sf -o /dev/null "\$URL" && break
  i=\$((i + 1))
  sleep 1
done

# Chromium, not Firefox. Measured on the Pi 2026-09-11, same page, same screen:
#   Firefox   11 fps, 99ms a frame, ~55% of a core
#   Chromium  34 fps, 33ms a frame, ~10% of a core
# The bottleneck was never the scene, it was Firefox's presentation path here.
#
#   --ozone-platform=wayland  the desktop is labwc; without this Chromium exits
#                             with "Missing X server or \$DISPLAY"
#   --password-store=basic    keeps Chromium away from the system keyring, so it
#   --use-mock-keychain       never shows the unlock dialog over the demo
# The package is called "chromium" but the Pi's packaging also drops a
# "chromium-browser" alias in. Which one exists varies by image, so take
# whichever is there rather than assuming.
CHROME=""
for c in chromium-browser chromium; do
  command -v "\$c" >/dev/null 2>&1 && { CHROME="\$c"; break; }
done
[ -n "\$CHROME" ] || { echo "no chromium binary found" >&2; exit 1; }

exec "\$CHROME" \\
  --ozone-platform=wayland \\
  --kiosk --noerrdialogs --disable-infobars --no-first-run \\
  --autoplay-policy=no-user-gesture-required \\
  --disable-session-crashed-bubble --disable-features=Translate \\
  --check-for-update-interval=31536000 \\
  --password-store=basic --use-mock-keychain \\
  --user-data-dir="\$PROFILE" \\
  "\$URL"
LAUNCH
  chmod 755 "$LAUNCHER"
  echo "  wrote $LAUNCHER"

  # ---- a session that runs the compositor and nothing else ----------------
  install -d "$LABWC_DIR"
  for f in rc.xml environment; do
    [ -f "/etc/xdg/labwc/$f" ] && cp "/etc/xdg/labwc/$f" "$LABWC_DIR/$f"
  done

  # Map the touchscreen to the panel it is physically attached to.
  #
  # The stock rc.xml ships rules for names like "11-005d Goodix Capacitive
  # TouchScreen", but the kernel here reports plain "Goodix Capacitive
  # TouchScreen" with no bus prefix, so none of them match. An unmapped touch
  # device is not tied to any output, so it never inherits that output's
  # rotation, and rotating the panel to landscape then puts every touch in the
  # wrong place. Detect the real names and write rules that do match.
  PANEL_OUT=""
  for st in /sys/class/drm/card*-DSI-*/status; do
    [ -f "$st" ] || continue
    [ "$(cat "$st")" = "connected" ] || continue
    PANEL_OUT="$(basename "$(dirname "$st")" | sed 's/^card[0-9]*-//')"
    break
  done

  if [ -n "$PANEL_OUT" ] && [ -f "$LABWC_DIR/rc.xml" ]; then
    RULES=""
    OLDIFS="$IFS"
    NL="$(printf '\nx')"; NL="${NL%x}"
    IFS="$NL"
    for dev in $(sed -n 's/^N: Name="\(.*\)"$/\1/p' /proc/bus/input/devices | grep -i touch | sort -u); do
      if grep -qF "deviceName=\"$dev\"" "$LABWC_DIR/rc.xml"; then
        echo "  touch: '$dev' already has a rule"
        continue
      fi
      RULES="$RULES  <touch deviceName=\"$dev\" mapToOutput=\"$PANEL_OUT\" mouseEmulation=\"yes\" />$NL"
      echo "  touch: mapped '$dev' to $PANEL_OUT"
    done
    IFS="$OLDIFS"

    # Rotating an output does NOT rotate its touchscreen. Mapping the device to
    # the output ties the two together but leaves the coordinates unrotated, so
    # pressing the top right of a panel rotated to landscape registers somewhere
    # else entirely. libinput needs an explicit calibration matrix.
    #
    #   transform 90  -> 0 -1 1  1 0 0
    #   transform 270 -> 0  1 0 -1 0 1
    #   transform 180 -> -1 0 1  0 -1 1
    #
    # PIGLO_TOUCH_MATRIX in /etc/default/piglo overrides this if the panel is
    # mounted the other way round. Swap to the 270 row if presses land mirrored.
    PANEL_TR="$(sed -n 's/^PIGLO_PANEL_TRANSFORM=//p' /etc/default/piglo 2>/dev/null | tr -d '"' | head -1)"
    MATRIX="$(sed -n 's/^PIGLO_TOUCH_MATRIX=//p' /etc/default/piglo 2>/dev/null | tr -d '"' | head -1)"
    if [ -z "$MATRIX" ]; then
      case "${PANEL_TR:-90}" in
        90)  MATRIX="0 -1 1 1 0 0" ;;
        270) MATRIX="0 1 0 -1 0 1" ;;
        180) MATRIX="-1 0 1 0 -1 1" ;;
        *)   MATRIX="" ;;
      esac
    fi

    # The calibration goes in a udev rule, not in labwc's config. labwc's own
    # <calibrationMatrix> was tried on 2026-09-11 and did not take effect, while
    # LIBINPUT_CALIBRATION_MATRIX is read by libinput itself when it opens the
    # device, before any compositor gets a say.
    CAL=""
    if [ -n "$MATRIX" ]; then
      {
        echo "# pi-glo: rotate touch coordinates to match the rotated panel."
        echo "# Generated by install-pi.sh. Change PIGLO_TOUCH_MATRIX in"
        echo "# /etc/default/piglo and re-run the installer to update."
        OLDIFS2="$IFS"; IFS="$NL"
        for dev in $(sed -n 's/^N: Name="\(.*\)"$/\1/p' /proc/bus/input/devices | grep -i touch | sort -u); do
          echo "ATTRS{name}==\"$dev\", ENV{LIBINPUT_CALIBRATION_MATRIX}=\"$MATRIX\""
        done
        IFS="$OLDIFS2"
      } > "$TOUCH_RULE"
      udevadm control --reload-rules 2>/dev/null || true
      udevadm trigger --subsystem-match=input 2>/dev/null || true
      echo "  touch: calibration matrix [$MATRIX] written to $TOUCH_RULE"
    fi

    if [ -n "$RULES$CAL" ]; then
      TMP="$(mktemp)"
      awk -v rules="$RULES$CAL" '
        /<\/openbox_config>/ && !inserted { printf "%s", rules; inserted = 1 }
        { print }
      ' "$LABWC_DIR/rc.xml" > "$TMP" && mv "$TMP" "$LABWC_DIR/rc.xml"
    fi
  else
    echo "  touch: no connected DSI panel detected; leaving touch rules alone"
  fi

  # kanshi handles output configuration. It costs nothing and leaving it out
  # risks the display coming up at the wrong resolution.
  cat > "$LABWC_DIR/autostart" <<AUTO
/usr/bin/kanshi &
$LAUNCHER &
AUTO

  cat > "$SESSION_BIN" <<SESS
#!/bin/sh
# pi-glo kiosk session. Generated by install-pi.sh — edit there, not here.
#
# Deliberately NOT "labwc -m". The stock session merges config from every XDG
# base dir, which runs the system autostart as well and brings up the panel and
# the desktop. Those are invisible behind a full-screen kiosk and cost real CPU.
#
# No `set -e` on purpose: labwc-pi does not use it either, and a stray non-zero
# line here would mean no display at all rather than a degraded one.

[ -f /usr/bin/setup_env ] && . /usr/bin/setup_env

# labwc-pi does this; kanshi fails without the file.
[ -f "\$HOME/.config/kanshi/config" ] || {
  mkdir -p "\$HOME/.config/kanshi"
  touch "\$HOME/.config/kanshi/config"
}

exec /usr/bin/labwc -C $LABWC_DIR
SESS
  chmod 755 "$SESSION_BIN"

  cat > "$SESSION_DESKTOP" <<DESK
[Desktop Entry]
Type=Application
Name=pi-glo kiosk
Comment=Compositor and the pi-glo demo, nothing else
Exec=$SESSION_BIN
DESK
  echo "  wrote $SESSION_BIN and $SESSION_DESKTOP"

  # Point auto-login at it, remembering what it was so --uninstall can undo.
  if [ -f "$LIGHTDM_CONF" ]; then
    CURRENT=$(sed -n 's/^autologin-session=//p' "$LIGHTDM_CONF" | head -1)
    if [ -n "$CURRENT" ] && [ "$CURRENT" != "piglo-kiosk" ]; then
      printf '%s\n' "$CURRENT" > "$PIGLO_ETC/previous-session"
    fi
    if grep -q "^autologin-session=" "$LIGHTDM_CONF"; then
      sed -i "s|^autologin-session=.*|autologin-session=piglo-kiosk|" "$LIGHTDM_CONF"
    else
      sed -i "/^\[Seat:\*\]/a autologin-session=piglo-kiosk" "$LIGHTDM_CONF"
    fi
    echo "  auto-login session set to piglo-kiosk"
  else
    echo "  WARNING: $LIGHTDM_CONF not found; set the auto-login session by hand"
  fi

  # The old approach seeded a user labwc autostart, which under -m ran the whole
  # desktop a second time. Remove ours if it is still just that seeded copy.
  if [ -f "$AUTOSTART" ]; then
    sed -i "/$MARK/,/# <<< pi-glo kiosk <<</d" "$AUTOSTART"
    if cmp -s "$AUTOSTART" /etc/xdg/labwc/autostart; then
      rm -f "$AUTOSTART"
      echo "  removed the duplicated $AUTOSTART"
    else
      echo "  left $AUTOSTART in place; it has edits that are not ours"
    fi
  fi
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
