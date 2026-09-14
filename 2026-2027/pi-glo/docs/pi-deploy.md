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

**Enabled as of 2026-09-11.** On power-on the Pi auto-logs in, waits for the
visualiser to answer, and opens Chromium full-screen on it.

```sh
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --kiosk'      # enable
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --uninstall'  # remove everything
```

The launcher is `/usr/local/bin/piglo-kiosk`, hooked in by one marked line in
`~/.config/labwc/autostart`. It reads the port from `/etc/default/piglo`, polls
the URL for up to 90 seconds, then runs:

```sh
chromium-browser --ozone-platform=wayland --kiosk --noerrdialogs \
    --password-store=basic --use-mock-keychain \
    --user-data-dir=~/.config/piglo-chromium http://localhost:8080/
```

`--password-store=basic` and `--use-mock-keychain` stop Chromium asking to
unlock the login keyring on every start, which otherwise puts a dialog over the
demo. The kiosk stores no passwords, so it has no business touching the keyring.

Three things that bit us and are now handled in the script:

**The browser must be told to use Wayland.** The desktop is labwc, and Chromium
exits with `Missing X server or $DISPLAY` without `--ozone-platform=wayland`.

**A user `~/.config/labwc/autostart` replaces the system one entirely.** Writing
one naively kills the taskbar, desktop icons and display config. The installer
seeds it from `/etc/xdg/labwc/autostart` first, then appends the kiosk line
between markers so it can be removed cleanly.

**The launcher must live outside `web/`.** Redeploys rsync that folder with
`--delete`, which would remove anything generated inside it.

The kiosk uses its own Chromium user-data-dir so the demo never inherits the
desktop user's browsing state. Chromium is configured entirely by flags, so
there is no profile file to maintain.

## Performance

**Re-measured 2026-09-11; the earlier 13-to-22 fps figures here were wrong.**
Full findings in `../memory/pi-deployment.md` under *Performance*, including
everything that was measured and made no difference.

The single biggest factor is the browser:

| browser, 1920x1080, hand at full width | frame time | rate |
|---|---|---|
| Firefox ESR 140 | 99 ms | 11 fps |
| **Chromium 152** | **33 ms** | **34 fps** |

*Compare with raw* roughly halves that, because two viewports mean two WebGL
contexts rendering and two canvases composited.

Two things that are **not** worth optimising, both measured:

- **Model complexity.** The hand is 5588 triangles. Cutting it to 72, one box per
  finger, bought 16%. A wireframe was no faster at all.
- **Antialiasing, drawing-buffer size, and the unused second WebGL context.** All
  no change.

The other large saving was not in drawing at all: an idle `requestAnimationFrame`
loop cost 66.6% of a core against 4.4% for the same work scheduled with
`setTimeout`, while using 2ms of JavaScript per second either way. The page now
uses rAF only while the hand is moving.

## Not yet done

- Nothing has been tested with the glove actually powered on. The BLE bridge has
  been verified end to end with synthetic packets in the firmware's exact wire
  format, and the Pi's adapter discovers 19 nearby devices, but no `NanoCmd` has
  ever answered.
- The USB-serial hand path is untested on the Pi.
