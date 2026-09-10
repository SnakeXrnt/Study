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

Two changes took the Pi from **13 fps to 22 fps** at 2560x1440:

- **Render on demand.** Redraw only when something changes — new sensor data, a
  camera move, a control change. Previously it redrew 60x/second regardless. The
  Render readout shows `idle` when nothing moves; **that is correct, not a
  stall.**
- **Drawing buffer capped** at 1400px wide (`MAX_BUFFER_W`), upscaled by CSS.

22 fps is now the ceiling imposed by the *data*, not the GPU: the firmware emits
at 20 Hz, so there are only ~20 new poses per second to draw.

For more headroom: turn off *Compare with raw* (halves the work) or lower
`MAX_BUFFER_W`.

## Endpoints

| | |
|---|---|
| `GET /` | the UI |
| `GET /stream` | SSE — `event: frame` per frame, `event: status` each second |
| `GET /api/status` | source, counters, gesture vocabulary, BLE UUIDs, thresholds |
| `POST /api/asl` · `/api/gesture` · `/api/link` | prediction overlays |

## What is honest about absent data

Stock `ble-tinyml-enum` transmits only the classified result. Where a field is
genuinely not on the wire the UI says so — the energy graph reads "not sent by
this firmware" and confidence shows "no score" — rather than displaying a fake
0%. Preserve that when extending it. A demo that invents numbers is worse than
one that admits gaps.
