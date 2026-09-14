# Open items

Check this before starting work. Most recent first.

## Resolved: the Pi moved to 145.76.18.112 — 2026-09-11

The Pi was never gone. It changed address, and its old address was reassigned to
a different machine, which is exactly why `ssh pi-glo` reported a changed host
key. The warning was correct and pointed at the other device, not at the Pi.

Verified by **key continuity, not by assumption**: all three host keys served by
`145.76.18.112` match byte-for-byte the keys recorded for `192.168.3.121` on
2026-09-06, and the host still reports its hostname as `1770np-pi`. Same
machine, new address.

What changed on Ethan's Mac. Both files were backed up first, alongside the
originals, suffixed `.bak-20260911`:

- `~/.ssh/config` — the `pi-glo` block's `HostName` is now `145.76.18.112`.
- `~/.ssh/known_hosts` — the Pi's three keys added under the new address, and
  the stale `192.168.3.121` lines removed, since a different device answers
  there now.

`ssh pi-glo` connects. On reconnection both `piglo-server` and `piglo-ble`
reported `active`, and `/etc/default/piglo` still read `PIGLO_SOURCE=--idle`.

Two things to know about the new address:

- **It is DHCP.** The lease had under an hour left when checked, so it will move
  again. If `ssh pi-glo` fails in future, suspect the address before suspecting
  anything else, and read the Pi's real address off its own screen.
- **It is a publicly routable address, not a private one.** The Mac sat on the
  same `/26` when this was verified, so reachability from outside the campus was
  not tested. Worth establishing before the open day.

## Resolved: the firmware is committed and pushed — 2026-09-11

The three modified files that existed only on Ethan's Mac are now on `openday`
as commit `1ac3352`, "feat : live BLE telemetry characteristic", and the local
checkout is level with `origin/openday` in both directions. The build-breaking
`g_ g_calibrating` typo went with it, so `openday` compiles for the teammate
again.

The telemetry characteristic itself is described in `protocols.md`. It is no
longer an uncommitted local change.

## Planned: fusion moves off the Nano and onto the Pi — decided 2026-09-11

**Decision, not yet built. No code or firmware has changed.** The Nano will be
reflashed to stream **raw accelerometer and gyroscope data** for all six sensors,
and everything currently done on-device moves to the Pi: misalignment,
sensitivity and offset correction, gyro bias tracking, Madgwick fusion, the
palm-relative transform, and the forward-kinematics pass.

Everything `protocols.md` and `hardware.md` say about the serial wire format
describes the **current** firmware, which still fuses on-device and emits
quaternions. Both are correct until the reflash happens. Do not read them as
describing the target.

What this actually costs, checked against the code on 2026-09-11:

- **The serial parser rejects raw records today.** `FrameAssembler._parse` in
  `web/server.py` requires exactly seven floats per record and returns `None`
  otherwise, counting the record as bad. A six-float raw record is dropped by
  every branch. The record shape has to be redefined before anything parses.
- **The wire format is unspecified.** Field order, units, whether each sensor
  still gets its own record, and the output rate are all open. Settle this
  first; the last data contract written ahead of the firmware had to be
  rewritten.
- **Throughput needs measuring, not assuming.** The firmware fuses internally at
  200 Hz, and fusion needs input near that rate to be worth moving. Six sensors
  at 200 Hz with six ASCII floats each is roughly 66 KB/s. The nominal 115200
  baud does not apply directly, since `/dev/ttyACM0` is USB CDC and the rate
  setting is cosmetic, but this is a large step up from the current 20 Hz
  quaternion burst and has never been measured.
- **The calibration constants live in firmware.** `CAL_DISABLE_FUNCTIONAL` is
  set, so the baked `g_gyro_accel_misalignment_matrices` are what is actually
  used. Those values must move to the Pi or be re-derived, or the fusion runs on
  uncorrected data.
- **CPU budget is unknown.** Madgwick across six sensors at 100 to 200 Hz in
  Python, on a Pi 4 that is also rendering the UI, may not fit. Measure on the
  Pi. Remember Debian 12 marks the system Python externally-managed, so numpy
  comes from apt, not pip.
- **Yaw drift does not improve.** There are still no magnetometers. Heading
  stays unobservable wherever the fusion runs.

Two things get easier, and they are the reason to do it:

- `loc` stops being a dead constant, because the FK pass runs somewhere it can
  be given real bone lengths.
- The online `q_offset` alignment from `projections.py` becomes implementable,
  since the host would own the full pipeline rather than receiving its output.

## Resolved: the energy trace draws — 2026-09-11

Closed by observation, with the glove powered on and connected to the Pi 5. The
trace renders live motion energy, crosses the firmware's start threshold, and the
state chip follows `idle` to `recording` as the hand moves.

The original hypothesis, an exception thrown earlier in `tick()`, was never
confirmed and is moot: `tick()` was rewritten during the 2026-09-11 performance
work and the path is now gated on new data and guarded throughout.

**This was also the first real swipe end to end**, which `Never tested` below had
flagged. Observed on the Pi 5: `LEFT` classified at 0.9961 confidence with the
full per-class score vector, link RSSI -54, 217 packets, none dropped, and the
live telemetry characteristic subscribed and delivering energy at 20Hz.

**One trap found while doing it.** `PIGLO_SOURCE=--simulate` also starts the fake
prediction generator, which posts invented gestures and scores over the same
overlay endpoints the real glove uses. With hardware attached the two fight and
the interface shows a mixture. Use `--idle` whenever a real glove is connected.

## The kiosk is on: Firefox opens the demo at power-on — 2026-09-11

Verified on the Pi, not assumed. Auto-login was already configured, the
installer now writes a Firefox launcher and hooks it into the labwc autostart,
and a screenshot taken on the Pi shows the demo full-screen with no browser
chrome and no first-run dialogs.

`/etc/default/piglo` is the switch for what the server reads. Changing
`PIGLO_SOURCE` and restarting `piglo-server` was tested both ways on
2026-09-11: the browser reconnects on its own and the diagnostics panel follows.
It is back on `--idle`, as it was.

**Not yet confirmed across an actual reboot.** Every piece was verified
individually and the kiosk was launched by hand into the running session. The
one untested link is labwc reading the modified autostart at login, which is
exactly where the seeding trap lives. See `pi-deployment.md`.

## The checked-in training pipeline cannot rebuild the flashed swipe model

Found 2026-09-11, in `Saxion-SSP`. The firmware expects **six** classes and its
bundled model declares them: `cobra, down, left, right, still, up`
(`examples/ble-tinyml-enum/include/swipe_model.h`, `NUM_GESTURES = 6`).

The training side has **five**. `model/training/config.py` lists five gestures
with no cobra, and `model/training/dataset/` holds five folders, also no cobra.
There is no cobra capture anywhere in the repo.

So the flashed model cannot be reproduced from what is committed. Retraining
from this tree yields a five-class model whose output indices no longer line up
with `ModelToCommandMap`, which would silently mislabel every gesture rather
than fail. Cobra is also the play/pause binding, so losing it is visible.

The cobra data presumably exists on whoever trained it. Get it into the repo.

## Latent crash in the BLE bridge's hold timer

`web/glove_ble.py` never initialises `telemetry_seen` in `Bridge.__init__`. It
is set to `True` only when a telemetry packet arrives, and to `False` only when
the telemetry subscription fails.

If a gesture is classified before the first telemetry packet lands, the `clear()`
coroutine in `_schedule_idle` reads an attribute that does not exist. The
`except` clause there catches `CancelledError` only, so the `AttributeError`
escapes into a task nobody awaits: no traceback in the normal path, and the
gesture never clears from the screen.

Narrow window in practice, since telemetry notifies at 20 Hz as soon as a
central connects. One line in the constructor closes it.

## Pending: migration to a Raspberry Pi 5 — 2026-09-11

A Pi 5 (8GB) has been acquired and the demo is to move to it. Nothing has run on
it yet. `web/bootstrap-pi.sh` and `../docs/migrate-to-pi5.md` were written for
this and the bootstrap script is verified on the Pi 4, but the Pi 5 path itself
is untested.

**Keep the Pi 4 imaged and working until after the open day.** It is the only
fallback that exists.

Two things to re-measure rather than inherit, because both are tuned to the Pi
4's GPU and browser and may not hold:

- `PIGLO_MODE=1920x1080@60`. Set because the Pi 4 could not drive the hand at
  1440p. The open-day monitor is 1080p anyway, so keep it for the venue, but the
  Pi 5 may not need the limit.
- The `setTimeout` scheduler in `web/static/index.html`. The 62%-of-a-core cost
  of an idle `requestAnimationFrame` is a quirk of the Pi 4's browser and
  compositor. It may not reproduce, and the comment in the file says to measure
  before changing it.

## Never tested

- **The 6-IMU hand over USB serial on the Pi.** The parser is tested against the
  firmware's exact wire format — split reads, dropped sensors, corrupt records,
  interleaved log lines — but no glove has ever been attached to the Pi over
  serial.
- **The ASL model.** The fingerspell UI is a placeholder rendering whatever is
  POSTed to it. No classifier exists on this side.
- **A real swipe end to end.** The BLE link, telemetry and packet decoding are
  verified with the glove powered on, but no one has performed an actual gesture
  and watched it light the rosette.

## Not ported from `projections.py`

The web UI implements curl extraction, joint-limit clamping and phalange
distribution. It does **not** implement:

- **Inter-finger abduction coupling.** `projections.py` couples each finger's
  splay range to its neighbours' curl; the UI clamps to fixed ranges.
- **The online `q_offset` alignment.** `projections.py` learns each sensor's
  mounting rotation at runtime by slerping toward `q.inverted() @ q_target`.
  Without it, a sensor mounted far from the assumed frame will look wrong.

That second one is why the axis convention could not be settled from the code
alone — the script auto-discovers what the UI has to be told.
