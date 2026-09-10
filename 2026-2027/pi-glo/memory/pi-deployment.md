# Running on the Pi

Installed and verified 2026-09-06. **The Pi was unreachable on 2026-09-10** —
see `open-items.md` before trusting the network details here.

## Access

```sh
ssh pi-glo
```

A Host block in `~/.ssh/config` on Ethan's Mac maps to `glo@192.168.3.121` with
the dedicated key `~/.ssh/id_pi_glo` and `IdentitiesOnly yes` — kept separate
from the GitHub key so neither unlocks the other.

The Pi had **two addresses**: `192.168.3.121` and `192.168.3.60`. Both were
serving; the SSH alias uses `.121`.

Passwordless sudo already ships on this image via `/etc/sudoers.d/010_pi-nopasswd`
(`glo ALL=(ALL) NOPASSWD: ALL`), so `sudo -n` works over SSH with no setup.

## What is installed

| | |
|---|---|
| `~/pi-glo/web/` | the app, deployed by rsync from the Mac |
| `piglo-server.service` | the visualiser, port 8080 |
| `piglo-ble.service` | the BLE bridge |
| `/etc/default/piglo` | which sensor source to use |
| `python3-bleak`, `python3-dbus-fast` | **from apt, not pip** |

Both services are enabled at boot.

**Use apt, not pip.** Debian 12 marks the system Python externally-managed
(`/usr/lib/python3.11/EXTERNALLY-MANAGED`), so `pip install` refuses. `bleak` is
0.20.2 from apt, which has no `__version__` attribute — importing it and reading
that will throw. `BLEDevice.rssi` is also deprecated in this version; read RSSI
from `AdvertisementData` in the scan callback instead.

```sh
systemctl status piglo-server piglo-ble
journalctl -u piglo-ble -f          # watch the glove connect
```

## Changing the sensor source

Edit `/etc/default/piglo`:

```sh
PIGLO_SOURCE=--idle                  # no serial glove — BLE swipe only
PIGLO_SOURCE=--port /dev/ttyACM0     # the 6-IMU hand
PIGLO_SOURCE=--simulate              # synthetic everything
sudo systemctl restart piglo-server
```

As of 2026-09-06 it was set to `--idle`, because the hand is on BLE and no
serial device is attached.

## Redeploying

```sh
rsync -az --delete --exclude __pycache__ web/ pi-glo:~/pi-glo/web/
ssh pi-glo 'sudo systemctl restart piglo-server piglo-ble'
```

## Kiosk mode

Opt-in, because a kiosk that seizes the screen at every login is disruptive
while developing:

```sh
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --kiosk'
ssh pi-glo 'cd ~/pi-glo/web && sudo ./install-pi.sh --uninstall'
```

Two traps, both handled in the installer but worth knowing:

**Chromium needs `--ozone-platform=wayland`.** The desktop is labwc, which is
Wayland, but this Chromium build defaults to the X11 backend and exits with
`Missing X server or $DISPLAY`. Setting `WAYLAND_DISPLAY` is not enough; the
flag is required.

**A user `~/.config/labwc/autostart` replaces the system one entirely.** Writing
one naively kills the taskbar, desktop icons and display config. The installer
seeds it from `/etc/xdg/labwc/autostart` first, then appends the kiosk line
between markers so it can be removed cleanly.

## Taking a screenshot on the Pi

`grim` and `scrot` are both installed. Under Wayland:

```sh
ssh pi-glo 'export WAYLAND_DISPLAY=wayland-0 XDG_RUNTIME_DIR=/run/user/1000
            grim /tmp/shot.png'
scp pi-glo:/tmp/shot.png .
```

This is the only way to verify what the Pi actually renders. Viewing the UI from
a laptop browser tests the laptop's GPU, not the Pi's.

## Flashing the Nano

PlatformIO, from the repo root:

```sh
cd ~/pi-glo/Saxion-SSP
pio run --project-dir examples/ble-tinyml-enum              # build
pio run -t upload --project-dir examples/ble-tinyml-enum    # flash
```

`-t upload` builds too; splitting them just avoids leaving the bootloader
waiting through a slow first compile (TFLite Micro takes ~4 minutes cold, ~13 s
warm).

PlatformIO triggers the 1200-baud reset itself when a sketch is running. If it
cannot find the port, **double-tap the reset button** — the orange LED breathes
slowly — and re-run immediately. Check mode via USB product id: `0x005A` is
bootloader, `0x805A` is a running sketch.

Only `external/eigen` and the `-pid` driver submodules are uninitialised, and
`ble-tinyml-enum` needs neither (eigen is in `lib_ignore`, BMI270 comes from
`lib_deps`). `fusion`, `tl` and `fmt` are vendored directly, not submodules.
