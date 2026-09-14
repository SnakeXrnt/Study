# The visualiser

`~/pi-glo/web/` — one Python process reads the glove, serves the UI, and accepts
predictions over HTTP. No build step, no Node, nothing fetched from the internet
at runtime.

```
web/
├── server.py          sources -> SSE, overlay endpoints, static files
├── glove_ble.py       BLE bridge: Nano -> HTTP overlays
├── install-pi.sh      systemd + kiosk installer
└── static/
    ├── index.html     the entire UI, inline CSS and JS
    └── vendor/        three.js r128 + IBM Plex, vendored for offline use
```

## Running it

```sh
python3 server.py --simulate                 # everything synthetic
python3 server.py --idle                     # no sensor source; BLE swipe only
python3 server.py --port /dev/ttyACM0        # the 6-IMU hand
python3 server.py --port /dev/ttyACM0 --fake-predictions
python3 server.py --port /dev/ttyACM0 --record capture.jsonl
python3 server.py --replay capture.jsonl     # loops
```

`--simulate` and `--replay` are stdlib-only; `--port` needs `pyserial`.

## Architecture decisions worth not relitigating

**Browser over Blender.** WebGL2 maps to GLES 3.0, which the Pi runs in
hardware, dodging the OpenGL 3.1 ceiling that blocks Blender entirely. A hand
skeleton is ~20 segments; it does not need a 200 MB DCC application. It also
makes the box a kiosk with one systemd unit and gives remote viewing free —
anyone can open the Pi's IP on a phone.

**Server-Sent Events, not WebSockets.** The data is one-way at 20 Hz. SSE needs
no dependency beyond the standard library, which matters on a Pi.

**Predictions arrive over HTTP, not by import.** Keeps the models in their own
process and language. Nothing about them has to agree with the visualiser beyond
three JSON shapes.

**Everything vendored.** A demo appliance must not depend on a CDN being
reachable at the venue.

**A heartbeat publishes empty frames at 5 Hz when the source is quiet.**
Overlays only reach the browser when something publishes. With the glove on BLE
there is no sensor stream at all, so without this a classified swipe would reach
the server and never appear on screen. Heartbeat frames are marked `idle` so the
UI leaves the hand alone instead of blanking it.

**Slow clients drop frames rather than queue.** For live telemetry a late frame
is worthless.

## The three modes

**Hand** — live 3D hand, constrained pose by default. *Compare with raw* splits
the view to show unconstrained sensor orientation beside it. Per-finger curl in
degrees with joint-limit clamping flagged.

**Fingerspell** — the predicted letter, large, with confidence, the next three
candidates, an A–Z strip, and accumulating text.

**Swipe** — five gestures as a rosette. The detected one lights with its media
action, alongside recording state and a live motion-energy trace marked with the
firmware's thresholds.

Connection state is always in the top bar. **Diagnostics** at the bottom expands
to link, stream, Bluetooth and model-tuning detail — this is the "is BLE
connected?" panel.

## Visual design

A pale instrument chassis with the 3D viewport inset as a dark screen, the way a
real measuring device sets a display into its housing. Chosen deliberately to
invert the dark-terminal look every other stand would have, while keeping the
hand readable. IBM Plex Sans, with Plex Mono for live numerals only (digits do
not jitter as values change).

**The hand is an artist's wooden mannequin.** The model is inherently segmented,
so rather than fighting that the design leans into a reference where segmentation
is the point. What made it read as a hand rather than sticks on a slab:

- Real proportions — middle finger longest, pinky shortest.
- Knuckles on the palm's leading edge and slightly forward in z, so fingers grow
  *out of* the hand instead of from behind it.
- A fixed anatomical rest orientation per knuckle, so fingers fan slightly.
- The thumb rotated out of the palm plane. **This is the single change that
  stopped it reading as a fifth finger stuck on the side.**

Hand proportions are anatomical, not the firmware's `finger_ref_locs_`. That
field is constant and carries no live data, so nothing is lost by ignoring it.

## Rendering performance

**Superseded 2026-09-11.** This section previously claimed 22 fps at 2560x1440
from render-on-demand and a capped drawing buffer. Re-measured on the Pi, the
drawing-buffer cap makes no measurable difference, and the real figures are very
different. The full set of measurements, the three things that actually mattered
and the several that did not, are in `pi-deployment.md` under *Performance*.

Short version: the kiosk runs Chromium, not Firefox, and that one choice was
worth three times the frame rate. At 1920x1080 with the hand at full width it
renders at 34 fps. The model's triangle count is irrelevant: cutting the hand
from 5588 triangles to 72 bought 16%.

Two traps worth carrying here:

- **The browser is the biggest lever, by far.** Chromium over Firefox was worth
  3x. Check which one is running before investigating anything else.
- **`requestAnimationFrame` is expensive when nothing is being drawn.** The page
  schedules ordinary updates with `setTimeout` and uses rAF only while the hand
  is actually moving. Do not "fix" this back without measuring on the Pi.
- **Render on demand is still right**, and the Render readout showing `idle` when
  nothing moves is still correct rather than a stall.

## The media player

The swipe demo really plays music, so a gesture does something you can hear.
Added 2026-09-11.

Audio lives **in the page**, not in the operating system: no media daemon, no
D-Bus, nothing extra to fail at a venue, and it works with the network unplugged.
The gesture vocabulary drives it exactly as the firmware's media bindings
describe, so what the rosette says is what happens.

**Tracks live outside the app directory**, at `~/pi-glo/music`, set by
`PIGLO_MUSIC`. This is not arbitrary: deploys rsync `web/` with `--delete`, so
anything put inside `static/` is erased on the next deploy.

Album art is read straight out of FLAC picture blocks by `server.py`, walking the
metadata blocks by hand so the Pi needs no audio library. A file with no artwork
gets the placeholder drawing, never a substituted image. Track names are tidied
from the filename: a leading track number is dropped and artist is split from
title on the first dash, so `09-the_weeknd-blinding_lights` shows as *Blinding
Lights* by *The Weeknd*.

`/music/` responses are the one exception to the server's no-store rule. They are
large and immutable, and re-fetching a 3MB cover on every track change would be
daft.

The swipe view is **two columns**: the player on the left, the gesture readout on
the right. It was one centred column, which crowded the middle and wasted the
sides.

## The settings tab

Added 2026-09-11. Sensor source, audio output and volume, display layout size
and panel rotation, plus a live read-out of the glove link.

**It answers on the loopback address only.** The visualiser deliberately listens
on every interface so visitors can watch from a phone; changing the machine's
configuration is a different thing, so `/api/settings` returns 403 to anything
that is not the device itself. The demo page stays public.

**The server never gets general root.** `/usr/local/bin/piglo-config` is the
entire privileged surface, reached through a sudo rule naming that one command.
It accepts a fixed list of keys, validates every value against a pattern, and
refuses everything else. Verified against shell-metacharacter injection on the
values and against unknown keys. Add a key only with a pattern that cannot
express a metacharacter.

Audio is PipeWire, driven with `pactl` and `wpctl`. A system service does not
join the user's session automatically, so `XDG_RUNTIME_DIR` is set explicitly.
**The Pi 5 has no headphone jack**, so HDMI is the only built-in output; a USB
adapter or a Bluetooth speaker is what adds another.

### WiFi

Scan, pick a network, type the password on the Pi's own screen. Reading the list
is unprivileged; joining goes through the helper.

**The password never becomes a command argument.** It is sent to `nmcli --ask`
on standard input, so it does not appear in the process list, in the helper's
arguments, or in any log. Verified by grepping `ps` while a connection attempt
was running. The endpoint is loopback-only, so it is typed on the device rather
than sent across the network.

### The on-screen keyboard is ours, on purpose

The kiosk has a touchscreen and no physical keyboard, and nothing on the system
provides a virtual one. Tried and rejected on 2026-09-11: `squeekboard` is
installed and starts cleanly, and labwc does implement `zwp_input_method_v2`,
`zwp_text_input_v3` and `zwp_virtual_keyboard_v1`. But Chromium never raised it,
even with `--enable-wayland-ime` and a field focused on load. Three uncertain
links between a visitor and a password field is too many the week of an open day.

So the keyboard lives in the page: `#kbd` in `static/index.html`. QWERTY with a
number row, a symbol layer, sticky-once shift, backspace, and a masked preview
with a reveal toggle for typing a long password on a touchscreen. It needs no
packages and cannot be broken by a compositor update.

Two details that were not obvious:

- **Keys use `pointerdown` with `preventDefault`**, or the field loses focus the
  moment a key is touched.
- **The field must be scrolled clear of the keys.** `scrollIntoView` is no good
  here: it centres within the scroll container, and on a 540px-tall layout the
  container's own centre is behind the keyboard. It scrolls by the measured
  overlap instead.

**A markup ordering trap, worth remembering.** The keyboard's HTML was first
added after the closing `</script>`, so at script time the elements did not
exist, `getElementById` returned null, and the whole script threw partway
through. Everything declared after that point stayed in the temporal dead zone,
and tapping a tab then failed with "Cannot access 'rafId' before initialization".
A late-throwing script fails in a way that looks nothing like its cause.

### A validation bypass worth remembering

The helper's first version checked values with `grep -Eq "$PAT"`. grep works a
line at a time, so a value like `yes\nPIGLO_OTHER=x` matched the pattern on its
first line and was then written whole, **appending a second key** to a file
systemd reads as an EnvironmentFile. That is arbitrary environment injection into
the service, reachable from the local settings endpoint. Found by review on
2026-09-11 and confirmed exploitable before it was fixed.

The fix rejects control characters before matching. The first attempt at *that*
was also wrong: it used `$(... | tr -d '[:print:]')`, and command substitution
strips trailing newlines, so a value ending in one looked empty and passed. It
now compares byte counts instead. The web layer refuses control characters too,
independently, which is what caught the case the shell missed.

**Two lessons.** Validate on the byte string, not line by line. And keep the
check in both layers: the duplication is what made the gap visible.

### Bluetooth audio, and the radio it shares

Built 2026-09-11. Search, connect, disconnect and forget a speaker, from the
settings tab. Addresses are validated against a strict pattern before reaching
`bluetoothctl`; anything else is refused.

**Scanning does not disturb the glove.** Measured with the glove connected and
streaming telemetry:

| | link connected | samples carrying fresh telemetry |
|---|---|---|
| idle | 15 of 15 | 15 of 15 |
| during a 25s classic scan | 22 of 22 | 21 of 22 |

**Streaming has not been tested**, because the only audio device in range
belongs to someone else and pairing with it would be wrong. That test still
needs doing with a speaker that belongs to the project: connect it, play a
track, and watch whether the link stays up and telemetry keeps arriving. Audio
streaming is far more demanding of the radio than discovery is, so the scan
result above does not settle it.

`bt-scan 0` lists what is already known without putting the radio to work, which
is what the page uses on load.

Still to test: the Bluetooth speaker under load. It shares one radio with the glove's BLE
link, so test whether the link survives audio streaming before relying on it.

## Endpoints

| | |
|---|---|
| `GET /` | the UI |
| `GET /stream` | SSE — `event: frame` per frame, `event: status` each second |
| `GET /api/status` | source, counters, gesture vocabulary, BLE UUIDs, thresholds |
| `POST /api/asl` · `/api/gesture` · `/api/link` | prediction overlays |
| `GET /api/music` | the playlist, with tidied names and whether art exists |
| `GET /music/<file>` · `/music/art/<file>` | a track, and its embedded cover |

## What is honest about absent data

Stock `ble-tinyml-enum` transmits only the classified result. Where a field is
genuinely not on the wire the UI says so — the energy graph reads "not sent by
this firmware" and confidence shows "no score" — rather than displaying a fake
0%. Preserve that when extending it. A demo that invents numbers is worse than
one that admits gaps.
