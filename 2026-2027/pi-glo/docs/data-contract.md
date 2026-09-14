# Data contract

What the glove actually puts on the wire, and where host-side code plugs in.

> **Corrected 2026-09-06.** An earlier version of this file assumed 7 IMUs
> emitting raw accelerometer and gyroscope data, with calibration to be applied
> on the host. Reading `examples/sense-6madgwick` disproved all three points.
> The real system is described below.
>
> **Superseded in part, 2026-09-11.** A decision was taken to move fusion onto
> the Pi, which means the Nano will be reflashed to stream raw accelerometer and
> gyroscope data after all. The sensor count stays at six. Nothing has been
> built, the replacement wire format is unspecified, and everything below still
> describes the firmware as flashed. Settle the new format against the firmware
> before writing it down here — that mistake has already been made once.

## What the firmware actually does

`examples/sense-6madgwick/src/main.cpp` runs on an Arduino Nano 33 BLE and does
far more on-device than "emit raw IMU data":

1. Reads 6 IMUs — **not 7**.
2. Applies per-sensor **misalignment, sensitivity and offset** correction
   (`FusionModelInertial`) from either a live calibration pass or the hardcoded
   matrices in `g_gyro_accel_misalignment_matrices`.
3. Tracks and removes **gyro bias** (`FusionBiasUpdate`).
4. Runs **Madgwick sensor fusion** per sensor
   (`FusionAhrsUpdateNoMagnetometer`).
5. Runs a **forward-kinematics model** (`HandFKModel`) in
   `RELATIVE_ORIENTATION_ONLY` mode, which makes finger orientations
   palm-relative via `palm_q.conjugate() * q`.

So the calibration and bias cleanup are already done in C++ before anything
reaches the host. What arrives is a fused, calibrated, palm-relative orientation.

## Sensors

Six, indexed 0–5 in this fixed order (`mdm::manager::SensorName`):

| id | name | part | bus |
|---|---|---|---|
| 0 | palm | BMI270 | I2C (`Wire1`, 400 kHz) |
| 1 | thumb | LSM6DSL | software SPI, CS 10 / MISO 12 |
| 2 | index | LSM6DSL | software SPI, CS 9 / MISO 5 |
| 3 | middle | LSM6DSL | software SPI, CS 7 / MISO 3 |
| 4 | ring | LSM6DSL | software SPI, CS 8 / MISO 4 |
| 5 | pinky | LSM6DSL | software SPI, CS 6 / MISO 2 |

One per finger plus the palm. None have magnetometers, so heading is
unobservable and yaw drift is expected and permanent.

## Wire format

USB serial, **115200 baud**, device `/dev/ttyACM0`. Records are `;`-terminated:

```
<id>:<qw>,<qx>,<qy>,<qz>,<lx>,<ly>,<lz>;
```

Six records per burst, ids 0–5 in order, emitted at **20 Hz** (the firmware
gates on `now - last_print_time > 50000UL`), while the internal fusion loop runs
at 200 Hz. Values are `%.4f`.

Records are newline-separated in practice, and firmware log lines from
`g_logger` share the same stream without `;` termination — a parser must
tolerate both. `web/server.py` resyncs on the last newline in a chunk.

### The `loc` field carries no live information

In `RELATIVE_ORIENTATION_ONLY` mode `HandFKModel::solve` writes a **constant**
per-finger knuckle position from `finger_ref_locs_`, unchanged frame to frame:

| finger | loc (right hand) |
|---|---|
| thumb | `(1.00, 0.00, 0.00)` |
| index | `(0.75, 1.00, 0.00)` |
| middle | `(0.25, 1.00, 0.00)` |
| ring | `(-0.25, 1.00, 0.00)` |
| pinky | `(-0.75, 1.00, 0.00)` |
| palm | `(0, 0, 0)` |

Left-hand builds negate x via `flip_x_sign`. Only `FORWARD_KINEMATIC_SOLUTION`
mode makes `loc` live, by rotating those reference vectors by the palm
quaternion. **Do not read `loc` as a measured fingertip position.**

## Host-side frame

`web/server.py` assembles records into whole-hand frames. A frame closes when a
sensor id repeats or all six arrive, so a dropped record cannot stall the stream.

```json
{
  "t": 20.7516,
  "seq": 388,
  "sensors": {
    "palm":  {"q": [0.987, -0.014, 0.157, -0.002], "loc": [0.0, 0.0, 0.0]},
    "index": {"q": [0.839, -0.540, -0.027, -0.065], "loc": [0.75, 1.0, 0.0]}
  },
  "complete": true
}
```

`sensors` may be incomplete; `complete` says whether all six were present.
Quaternions are `[w, x, y, z]`, palm-relative for fingers, world for the palm.

## Where host-side processing plugs in

The anatomical projection — curl/splay extraction, joint-limit clamping,
inter-finger abduction coupling, the online `q_offset` alignment — lives in
`examples/sense-6madgwick/src/projections.py` and is currently Blender-bound
(it stores state on `bpy` objects).

To reuse it outside Blender it needs the `bpy` dependency lifted: state moves
onto a plain class, and `mathutils.Quaternion`/`Vector` are replaced with numpy
or an equivalent. The maths carries over unchanged. The web UI implements a
partial port in JS — curl extraction, clamping and phalange distribution — but
**not** the abduction coupling or `q_offset` alignment.

## Axis convention — unresolved

`projections.py` treats the finger's forward direction as local **+Z**
(`forward = q @ Vector((0,0,1))`), then measures curl as `-atan2(fwd.y, fwd.z)`.
The FK knuckle layout instead spreads fingers in X at `y=1.0`, which reads as
forward **+Y**.

These are reconcilable only against the actual Blender scene, which is not in
this repo. The web UI therefore exposes a forward-axis selector rather than
guessing, defaulting to +Y because it matches the knuckle geometry. Settle this
against real hardware and hardcode it.

Joint limits, from `projections.py`:

| | curl min | curl max |
|---|---|---|
| thumb | -90° | 0° |
| others | -180° | +45° |

Closing the hand is **negative** curl.

## Modes, gestures and the BLE link

Sourced from `examples/ttgo-complete/src/main.cpp` and
`examples/ble-tinyml-enum/src/main.cpp`, where an ESP32 TTGO previously played
the role the Pi now takes.

### Gesture vocabulary

On-wire enum ordinals (`Gesture` in `BleConnection.h`):

| 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| UNKNOWN | UP | DOWN | LEFT | RIGHT | STILL | COBRA |

The TFLite swipe model outputs six classes in **alphabetical** order —
`cobra, down, left, right, still, up` — and `ModelToCommandMap` remaps them to
the enum. Anything consuming raw model output must apply that remap; the indices
are not the enum values.

### Media bindings

From the `MODE_MEDIA` branch:

| gesture | action |
|---|---|
| LEFT | Previous track |
| RIGHT | Next track |
| UP | Volume up |
| DOWN | Volume down |
| COBRA | Play / pause |

### Swipe segmentation

The device does not classify continuously. It runs `IDLE -> RECORDING ->
COOLDOWN` gated on smoothed accelerometer energy:

| | |
|---|---|
| Sample rate | 100 Hz, accelerometer only |
| Start threshold | 0.10 |
| End threshold | 0.06 |
| Energy window | 20 samples |
| Pre-buffer | 300 ms retained before motion is detected |
| Max window | 300 samples (3 s) |
| Cooldown | 0.3 s |

The pre-buffer matters: the classified window begins *before* the energy gate
trips, so the start of the movement is not clipped.

### BLE

| | |
|---|---|
| Service | `4fafc201-1fb5-459e-8fcc-c5c9c331914b` |
| Characteristic | `beb5483e-36e1-4688-b7f5-ea07361b26a8` |
| Advertised name | `NanoCmd` |
| Packet | 6 bytes: `seq` u8, `ts` u32 little-endian, `value` u8 |

`value` is overloaded: `<= 6` is a gesture ordinal, `32..126` is a printable
ASCII character (how fingerspelled letters arrive), and `8` is backspace. The
Nano is the GATT server and notifies; the host is the client.

## Prediction overlays — the UI contract

`web/server.py` computes no predictions. Whatever owns the ASL and swipe models
posts results to it, and they merge into the next outgoing frame:

```
POST /api/asl      {"letter","confidence","candidates":[[letter,p],...],"text"}
POST /api/gesture  {"state","gesture","confidence","energy","scores","action"}
POST /api/link     {"transport","state","device","address","rssi","seq","dropped"}
```

All fields optional — post only what changed. `state` for a gesture is `idle`,
`recording` or `cooldown`. Anything not updated for 3 s is marked `stale` and the
UI returns to its waiting state rather than showing a frozen prediction.

This keeps the models in their own process and language. Nothing about them has
to agree with the visualiser beyond these three shapes.

## Open questions

1. **Axis convention** — +Y or +Z forward (above).
2. **Sustained sample rate** with all 6 sensors on real hardware. The firmware
   targets 20 Hz output; software SPI across 5 devices may not keep up.
3. **Which calibration path is live.** `CAL_DISABLE_FUNCTIONAL` is currently
   defined, so the hardcoded misalignment matrices are used and the functional
   calibration stages are disabled. Whether the demo runs calibrated-at-boot or
   with baked constants changes what "before" means.
4. ~~**BLE mode** — host-side client not written.~~ Resolved: `web/glove_ble.py`
   is the client, and a telemetry characteristic was added on 2026-09-11. See
   `memory/protocols.md`.
5. **Who drives the ASL model.** The 26-letter classifier is not in this repo;
   only its output shape is agreed.
