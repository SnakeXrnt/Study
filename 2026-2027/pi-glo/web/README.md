# pi-glo web visualiser

The demo front-end for the glove. One Python process reads the glove, serves the
UI, and accepts predictions pushed in over HTTP. No build step, no Node, and
nothing fetched from the internet at runtime.

## Run

```sh
python3 server.py --simulate                 # everything synthetic, no hardware
python3 server.py --port /dev/ttyACM0        # real glove, real sensors
python3 server.py --port /dev/ttyACM0 --fake-predictions   # real hand, fake ASL/swipe
python3 server.py --port /dev/ttyACM0 --record capture.jsonl
python3 server.py --replay capture.jsonl     # replay a capture, loops
```

Open <http://localhost:8080/>. On the Pi it is reachable from any phone or
laptop on the network at `http://<pi-ip>:8080/` — useful when a crowd is around
one screen.

`--simulate` and `--replay` are stdlib-only. `--port` needs `pyserial`.

## The three modes

**Hand** — the live 3D hand. Shows the constrained pose by default; *Compare with
raw* splits the view so the unconstrained sensor orientation sits beside it.
Per-finger curl in degrees, with joint-limit clamping flagged.

**Fingerspell** — the predicted ASL letter, large, with its confidence, the next
three candidates, and the accumulating text. The A–Z strip marks the active
letter.

**Swipe** — the five gestures as a rosette (up / down / left / right / cobra).
The detected one lights up with the media action it maps to, alongside the
recording state and a live motion-energy trace marked with the firmware's start
(0.10) and end (0.06) thresholds.

Connection state sits in the top bar at all times; **Diagnostics** at the bottom
expands to link, stream, Bluetooth and model-tuning detail.

## Pushing predictions in

The server computes no predictions. The ASL and swipe models push results in
over HTTP, so they can live in any process or language:

```sh
curl -X POST localhost:8080/api/asl -d '{
  "letter": "A", "confidence": 0.93,
  "candidates": [["A",0.93],["S",0.04],["T",0.02]],
  "text": "HELLO"
}'

curl -X POST localhost:8080/api/gesture -d '{
  "state": "cooldown", "gesture": "LEFT", "confidence": 0.88,
  "energy": 0.14, "action": "Previous track",
  "scores": {"cobra":0.02,"down":0.01,"left":0.88,"right":0.03,"still":0.05,"up":0.01}
}'

curl -X POST localhost:8080/api/link -d '{
  "transport": "ble", "state": "connected",
  "device": "NanoCmd", "address": "e8:9f:...", "rssi": -54, "seq": 12
}'
```

Each merges into the next outgoing frame. Fields are optional — post only what
changed. Anything not updated for 3 seconds is marked `stale` and the UI drops
back to its waiting state rather than showing a frozen prediction.

`gesture.state` is one of `idle`, `recording`, `cooldown`, mirroring the
on-device state machine in `examples/ble-tinyml-enum`. `gesture.gesture` uses the
firmware's vocabulary: `UP DOWN LEFT RIGHT STILL COBRA`.

## Layout

```
server.py             serial/simulate/replay -> SSE, overlay endpoints, static files
static/index.html     the whole UI (inline CSS/JS)
static/vendor/        three.js r128 and IBM Plex, vendored for offline use
```

Everything is vendored deliberately: a demo appliance should not depend on a CDN
being reachable at the venue.

## Endpoints

| | |
|---|---|
| `GET /` | the UI |
| `GET /stream` | SSE — `event: frame` per hand frame, `event: status` each second |
| `GET /api/status` | source, counters, gesture vocabulary, BLE UUIDs, thresholds |
| `POST /api/asl` · `/api/gesture` · `/api/link` | prediction overlays |

Frames are dropped for slow clients rather than queued — for live telemetry a
late frame is worthless.

## Status

Deployed and running on the Pi as a kiosk. The serial parser is tested against
the exact wire format the firmware emits, including split reads, dropped
sensors, corrupt records and interleaved log lines.

Performance was measured on the Pi on 2026-09-11. The kiosk runs **Chromium**,
which is worth three times the frame rate of Firefox here: 34 fps against 11 at
1920x1080 with the hand full width. `requestAnimationFrame` is used only while
the hand is moving, because an idle rAF loop cost most of a core. The hand's
5588 triangles are not worth reducing; that was measured too. See
`../memory/pi-deployment.md` before changing any of it.

**The six-sensor hand has still not been tested against real hardware** over
serial. The Bluetooth swipe path has run with the glove connected.

Known gaps:

- ASL and swipe predictions are placeholders. Nothing here classifies anything;
  the UI renders whatever is posted to it.
- The inter-finger abduction coupling from `projections.py` is not ported —
  splay uses fixed per-finger ranges instead of ranges that depend on
  neighbouring fingers' curl.
- The online `q_offset` alignment `projections.py` learns is not implemented, so
  a sensor whose mounting rotation is far from the assumed frame will look wrong.
  The forward-axis selector under Diagnostics is the first thing to try if the
  fingers point the wrong way.
- Hand proportions are anatomical, not the firmware's `finger_ref_locs_`. That
  field is constant in `RELATIVE_ORIENTATION_ONLY` mode and carries no live data,
  so nothing is lost by ignoring it.
