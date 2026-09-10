# Protocols

Every wire format in the system. `../docs/data-contract.md` carries more detail
and the reasoning; this is the working reference.

## Gesture vocabulary

On-wire enum ordinals (`Gesture` in `BleConnectionEnum.h`):

| 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| UNKNOWN | UP | DOWN | LEFT | RIGHT | STILL | COBRA |

**The TFLite model does not output these indices.** It emits six classes in
*alphabetical* order — `cobra, down, left, right, still, up` — and
`ModelToCommandMap` remaps them. Anything consuming raw model output must apply
that remap. This is an easy and silent thing to get wrong.

### Media bindings

From `ttgo-complete`'s `MODE_MEDIA` branch:

| gesture | action |
|---|---|
| LEFT | Previous track |
| RIGHT | Next track |
| UP | Volume up |
| DOWN | Volume down |
| COBRA | Play / pause |

## USB serial — the 6-IMU hand

115200 baud on `/dev/ttyACM0`. Records are `;`-terminated:

```
<id>:<qw>,<qx>,<qy>,<qz>,<lx>,<ly>,<lz>;
```

Six records per burst, ids 0–5 in order, at **20 Hz** (the firmware gates on
`now - last_print_time > 50000UL`) while fusion runs internally at 200 Hz.
Values are `%.4f`. Quaternions are `[w,x,y,z]`, palm-relative for fingers and
world for the palm.

Two parsing hazards, both handled in `web/server.py`:

- Records are newline-separated in practice.
- **Firmware log lines share the stream** and are not `;`-terminated, so they
  arrive glued to the front of the next record and eat it. The parser resyncs on
  the last newline in a chunk.

### `loc` carries no live information

In `RELATIVE_ORIENTATION_ONLY` mode, `HandFKModel::solve` writes a **constant**
per-finger knuckle position that never changes frame to frame:

| finger | loc (right hand) |
|---|---|
| thumb | `(1.00, 0.00, 0.00)` |
| index | `(0.75, 1.00, 0.00)` |
| middle | `(0.25, 1.00, 0.00)` |
| ring | `(-0.25, 1.00, 0.00)` |
| pinky | `(-0.75, 1.00, 0.00)` |
| palm | `(0, 0, 0)` |

Left-hand builds negate x via `flip_x_sign`. Only `FORWARD_KINEMATIC_SOLUTION`
mode makes it live. **Never read `loc` as a measured fingertip position.**

## BLE

| | |
|---|---|
| Service | `4fafc201-1fb5-459e-8fcc-c5c9c331914b` |
| Command characteristic | `beb5483e-36e1-4688-b7f5-ea07361b26a8` |
| Telemetry characteristic | `beb5483e-36e1-4688-b7f5-ea07361b26a9` |
| Advertised name | `NanoCmd` |

The Nano is the GATT **server** and notifies; the Pi is the client.

### Command packet — 6 bytes, little-endian

```
seq    uint8      increments per packet, wraps at 256
ts     uint32     the Nano's millis() at send time
value  uint8
```

`value` is overloaded:

- `<= 6` — a gesture ordinal
- `32..126` — a printable ASCII character (how fingerspelled letters arrive)
- `8` — backspace

Sequence gaps are the only way to detect dropped packets.

### Telemetry packet — 10 bytes, little-endian

**Added by us**, not original to the project. See `open-items.md` — this is
uncommitted.

```
state       uint8    0 idle, 1 recording, 2 cooldown
energy      float32  smoothed motion energy
confidence  float32  last classification score, 0 if none yet
gesture     uint8    last classified ordinal, 0 if none yet
```

Notified at **20 Hz** whenever a central is connected. Sampling runs at 100 Hz
but notifying that fast floods the connection interval for no visible gain.

Deliberately a **second characteristic** rather than an extension of the command
packet, so the existing TTGO client — which reads fixed offsets from the first
six bytes — keeps working untouched.

## Prediction overlays — the UI's HTTP contract

The visualiser computes nothing. Models POST results in; each merges into the
next outgoing frame. All fields optional — post only what changed.

```
POST /api/asl      {"letter","confidence","candidates":[[letter,p],...],"text"}
POST /api/gesture  {"state","gesture","confidence","energy","scores","action"}
POST /api/link     {"transport","state","device","address","rssi","seq","dropped"}
```

`state` for a gesture is `idle`, `recording` or `cooldown`. Anything not updated
for **3 seconds** is marked `stale`, and the UI falls back to its waiting state
rather than showing a frozen prediction.

This is the whole integration surface. A model can be in any language, in any
process, on any machine that can reach the Pi.

## Axis convention — unresolved

`projections.py` reads a finger's forward direction as local **+Z**
(`forward = q @ Vector((0,0,1))`) and measures curl as `-atan2(fwd.y, fwd.z)`.
The firmware's knuckle layout instead spreads fingers in X at `y=1.0`, which
reads as forward **+Y**.

These are reconcilable only against the actual Blender scene, which is not in the
repo. The UI exposes a forward-axis selector under Diagnostics rather than
guessing, defaulting to +Y. **If the fingers point the wrong way on real
hardware, that selector is the first thing to try.**

Joint limits from `projections.py`: thumb curl -90°..0°, other fingers
-180°..+45°. **Closing the hand is negative curl.**
