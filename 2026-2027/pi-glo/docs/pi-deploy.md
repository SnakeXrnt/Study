# Running on the Pi

Installed and verified 2026-09-06. The Pi is the demo box; the TTGO is no longer
in the loop.

## What is installed

| | |
|---|---|
| `~/pi-glo/web/` | the app, deployed by rsync from the Mac |
| `piglo-server.service` | the visualiser, on port 8080 |
| `piglo-ble.service` | the BLE bridge to the Nano 33 BLE |
| `/etc/default/piglo` | which sensor source to use |
| `python3-bleak`, `python3-dbus-fast` | from apt, **not** pip — Debian 12 marks the system Python externally-managed |

Both services are enabled and start at boot.

```sh
systemctl status piglo-server piglo-ble
journalctl -u piglo-ble -f          # watch the glove connect
```

Open <http://localhost:8080/> on the Pi, or `http://192.168.3.60:8080/` from any
device on the network.

## Changing the sensor source

Edit `/etc/default/piglo`:

```sh
PIGLO_SOURCE=--idle                  # no serial glove — BLE swipe only (current)
PIGLO_SOURCE=--port /dev/ttyACM0     # the 6-IMU hand over USB serial
PIGLO_SOURCE=--simulate              # synthetic everything
sudo systemctl restart piglo-server
```

`--idle` still serves the UI and still shows swipe gestures; it just has no hand
data. A heartbeat keeps predictions flowing to the browser even with no sensor
stream, which is what makes BLE-only operation work.

## Redeploying after changes

```sh
rsync -az --delete --exclude __pycache__ web/ pi-glo:~/pi-glo/web/
ssh pi-glo 'sudo systemctl restart piglo-server piglo-ble'
```

## Kiosk mode

Opt-in, because a kiosk that seizes the screen at every login is disruptive
while developing:

```sh
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --kiosk'   # enable
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --uninstall'  # remove everything
```

Two things that bit us and are now handled in the script:

**Chromium needs `--ozone-platform=wayland`.** The desktop is labwc, which is
Wayland, but this Chromium build defaults to the X11 backend and exits with
`Missing X server or $DISPLAY`.

**A user `~/.config/labwc/autostart` replaces the system one entirely.** Writing
one naively kills the taskbar, desktop icons and display config. The installer
seeds it from `/etc/xdg/labwc/autostart` first, then appends the kiosk line
between markers so it can be removed cleanly.

## Performance

The Pi 4 drives a 2560x1440 screen here, which is a lot of pixels for a
VideoCore VI. Two changes took the hand view from **13 fps to 22 fps**:

- **Render on demand.** The scene is only redrawn when something actually
  changes — new sensor data, a camera move, a control change. Previously it
  redrew 60 times a second regardless. The Render readout in Diagnostics shows
  `idle` when nothing is moving; that is correct, not a stall.
- **Capped drawing buffer** at 1400px wide, upscaled by CSS. Barely visible,
  and it lifted the GPU ceiling above the data rate.

22 fps is now the *ceiling imposed by the data*, not the GPU: the firmware emits
at 20 Hz, so there are only ~20 new poses per second to draw. Rendering faster
would draw the same pose twice.

If it ever needs more headroom: turn off *Compare with raw* (it halves the work),
or drop `MAX_BUFFER_W` in `static/index.html`.

## Not yet done

- Nothing has been tested with the glove actually powered on. The BLE bridge has
  been verified end to end with synthetic packets in the firmware's exact wire
  format, and the Pi's adapter discovers 19 nearby devices, but no `NanoCmd` has
  ever answered.
- The USB-serial hand path is untested on the Pi.
