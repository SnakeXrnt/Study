# Migrating the demo to a Raspberry Pi 5

Written 2026-09-11, against a working Pi 4 setup. Everything here has been
derived from that machine, but **none of it has been run on a Pi 5 yet**, because
there was no Pi 5 to run it on. Treat the checklist as tested logic on untested
hardware, and expect one or two surprises.

**Do not wipe the Pi 4 until the Pi 5 is proven.** The Pi 4 is a working demo. It
stays the fallback until the Pi 5 has run the whole thing end to end.

## Which image: with desktop, 64-bit. Not Lite.

Lite is tempting for an appliance and it is the wrong choice here, for reasons
specific to this project rather than general taste.

The kiosk session is built on pieces that only the desktop image ships:

| piece | comes from | what breaks without it |
|---|---|---|
| `labwc` | desktop image | no compositor, no kiosk at all |
| `lightdm` | desktop image | no auto-login, so nothing starts on power-on |
| `chromium` + `rpi-chromium-mods` | desktop image | the Pi-tuned Chromium build, which measured **three times** Firefox's frame rate |
| `/usr/bin/labwc-pi`, `/usr/bin/setup_env` | desktop image | cursor theme, keyboard layout, renderer selection |
| `/etc/xdg/labwc/{rc.xml,environment}` | desktop image | the kiosk session copies these as its base |

You can install labwc, lightdm and chromium on Lite by hand, but you do not get
the Pi's own Chromium packaging or the session helpers, and you would be
debugging a bespoke graphics stack the week of an open day.

The runtime cost of choosing desktop is close to zero, because the kiosk already
runs its own session with **no panel and no desktop**. That was measured: two
`wf-panel-pi` processes were eating about 65% of a core until the dedicated
session removed them. See `../memory/pi-deployment.md`.

Pick **Raspberry Pi OS (64-bit) with desktop**. Not "with desktop and
recommended software", which adds an office suite you will never open.

### Which release

Match the Pi 4 exactly if the imager still offers it: **Debian 12 bookworm,
64-bit**. That is what every script and note here assumes, and a matching
userland means nothing needs adapting.

Bookworm supports the Pi 5, so this is not a compromise. If the imager only
offers something newer, say so before flashing: most of this still applies, but
package names and the labwc version may have moved and the scripts want checking
first.

## Before you flash

Raspberry Pi Imager can pre-seed the things that are awkward to do later. Use
the settings gear and set:

| setting | value | why |
|---|---|---|
| hostname | something you will recognise | it appears in `ssh` and in the logs |
| username | `glo` | paths, services and the ssh alias all assume it |
| password | anything | you will use the key, not this |
| SSH | enabled, **public-key only** | password prompts do not work through Claude Code, see `../memory/working-notes.md` |
| public key | the one below | so the first login just works |

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKIqXelNbEA/MX9z6UVvpfWjAkIJk7BuGFLfHPNvuMfP ethan@mac -> glo@pi-glo
```

That is `~/.ssh/id_pi_glo.pub` on Ethan's Mac. Keeping the same key means the
existing `IdentityFile` line needs no change.

## Pi 5 specifics worth knowing before it bites you

- **It needs active cooling.** The Pi 5 throttles without a fan or the official
  cooler, and this demo pushes the GPU continuously. The Pi 4 sat at 51°C under
  load with no throttling; do not assume the Pi 5 will without a cooler.
- **It wants the 5V/5A USB-C supply.** With a smaller supply the Pi 5 limits
  total USB current, which matters once the Nano is plugged in.
- **Two micro-HDMI ports.** Use the one nearest the USB-C socket. The kiosk
  launcher picks the first enabled output automatically, so either works, but
  only one is the primary at boot.
- **The output name may differ.** The Pi 4 reports `HDMI-A-2`. Nothing hardcodes
  that: the launcher reads it from `wlr-randr` at startup.

## Migration, in order

Run these from the Mac, in `~/Study/2026-2027/pi-glo`.

**1. Reach it.** Add a second host block so both machines stay addressable:

```sshconfig
Host pi-glo5
  HostName <the Pi 5's address>
  User glo
  IdentityFile ~/.ssh/id_pi_glo
  IdentitiesOnly yes
```

Check it: `ssh pi-glo5 'hostname; uptime'`

**2. Copy the app over.**

```sh
ssh pi-glo5 'mkdir -p ~/pi-glo'
rsync -az --delete --exclude __pycache__ web/ pi-glo5:~/pi-glo/web/
```

**3. Install the prerequisites.** This is the new part, and it is idempotent:

```sh
ssh pi-glo5 'cd ~/pi-glo/web && sudo ./bootstrap-pi.sh'
```

It installs `python3-bleak`, `python3-dbus-fast`, `python3-serial`, `wlr-randr`,
`grim`, `curl` and `rsync`; adds `glo` to the `dialout` group so the serial glove
is readable; sets lightdm auto-login; and tells you plainly if you flashed Lite
by mistake.

**4. Install the demo.**

```sh
ssh pi-glo5 'cd ~/pi-glo/web && sudo ./install-pi.sh --kiosk'
```

That writes both systemd services, the kiosk session, the Chromium launcher and
`/etc/default/piglo`.

**5. Reboot and watch.** This is the real test, because the boot path is the one
thing that cannot be verified any other way.

```sh
ssh pi-glo5 'sudo reboot'
```

Give it a minute, then:

```sh
ssh pi-glo5 'systemctl is-active piglo-server piglo-ble; pgrep -c chromium; pgrep -c wf-panel-pi'
```

Expect `active`, `active`, ten or so Chromium processes, and **zero** panels. A
non-zero panel count means the session is wrong and the desktop is running twice.

**6. Look at it.** Screenshots are the only honest check of what the Pi renders:

```sh
ssh pi-glo5 'export WAYLAND_DISPLAY=wayland-0 XDG_RUNTIME_DIR=/run/user/1000; grim /tmp/shot.png'
scp pi-glo5:/tmp/shot.png .
```

## Re-measure, do not assume

Every performance number in `../memory/pi-deployment.md` was measured on the Pi
4. The Pi 5 has a different GPU and a different display pipeline, so all of them
are now guesses. Two in particular are worth redoing, because the current
configuration is tuned around them:

- **`PIGLO_MODE=1920x1080@60` in `/etc/default/piglo`.** Set because the Pi 4
  could not drive the 3D hand at 1440p, and because the open-day monitor is
  1080p. Keep it for the venue, but the Pi 5 may not need it.
- **The `setTimeout` scheduler in `web/static/index.html`.** On the Pi 4,
  `requestAnimationFrame` cost 62% of a core doing nothing. That is a quirk of
  that browser and compositor combination and may not reproduce. The comment in
  the file says to measure before changing it. This is the machine to measure on.

The method that worked: accumulate CPU time over a fixed window rather than
sampling `top`, and put a frame counter on screen and read it with `grim`.

## When the Pi 5 is proven

Only then:

- Point the `pi-glo` alias at the Pi 5 and retire `pi-glo5`, or keep both.
- Update the address and the measurements in `../memory/pi-deployment.md`.
- Keep the Pi 4 imaged and working until after the open day. It is the only
  fallback that exists.
