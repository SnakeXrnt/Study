# pi-glo

Real-time hand visualization for a 7-IMU sensor glove, running self-contained on a
Raspberry Pi 4 as a demo appliance.

**Status:** planning / scaffolding. No implementation yet. Glove firmware and the
calibration script are owned by a collaborator and not yet in this repo.

## The system

A glove carries **6 IMUs** — one per finger plus one on the palm. The firmware
(`Saxion-SSP/examples/sense-6madgwick`) already runs calibration, bias tracking and
Madgwick fusion on-device, and emits **fused, palm-relative quaternions** over USB
serial at 20 Hz. The demo shows **before and after** side by side: the fused sensor
orientation against the anatomically constrained hand pose.

The whole thing has to run in one box on a Pi 4, with a display, for a showcase.

```
  glove ──USB serial──► Python reader ──► SSE ──► Chromium kiosk
   (fused quaternions)     (web/server.py)          Three.js, two hands
```

The browser receives one quaternion set per frame and renders it twice: applied
rigidly on the left, anatomically constrained on the right.

**Implemented and deployed to the Pi** — see `web/` and `docs/pi-deploy.md`.
Runs against a simulator, a recorded capture, the real serial device, or with no
sensor source at all for BLE-only swipe demos. Swipe gestures arrive over BLE via
`web/glove_ble.py`. Not yet tested with the glove powered on.

## Architecture decision: Three.js in Chromium, not Blender

Blender was the original plan. It is the wrong tool, for two independent reasons.

**1. It cannot use the GPU on this hardware.** The Pi 4's VideoCore VI caps at
**OpenGL 3.1**; Blender 3.4 requires **3.3**. That is a hardware ceiling, not a driver
gap — no update fixes it. Blender only runs here under `llvmpipe` software rendering,
so every frame is drawn on the CPU. (Zink, which routes desktop GL over the Pi's
Vulkan 1.2 driver, was tested and fails — V3DV reports `Max core profile version: 0.0`.)

**2. It is a content-creation app, not a realtime runtime.** Driving it from live
sensor data means `bpy` scripting on Blender's main thread, competing with its own UI
for every frame.

Against that: a hand skeleton is roughly **20 segments, a few hundred triangles**.
It does not need a 200 MB DCC application.

**WebGL2 maps to GLES 3.0, and the V3D does GLES 3.1 natively** — so the browser path
is hardware accelerated, comfortably under the ceiling that blocks Blender. It also
keeps the calibration in plain Python, makes the box a kiosk with a single systemd
unit, and gives remote viewing free: anyone can open the Pi's IP on a phone, which is
useful when people crowd one screen at a showcase.

### Alternatives considered

| Option | Verdict |
|---|---|
| **Three.js + Chromium kiosk** | **Chosen.** GPU accelerated, fast to build, remote viewing free. |
| Godot 4 (Compatibility/GLES3) | Viable if a rigged, skinned mesh is wanted. Heavier setup, fussier on Pi 4. |
| Python + moderngl / pyglet | Leanest, no browser overhead, but all UI is hand-built. |
| Rerun (rerun.io) | Excellent for *debugging* the calibration — run it on a laptop, not in the box. Viewer is wgpu-based and heavy for a Pi 4. |
| Blender | Offline/pre-rendered only. Not viable live. |

## The hard part is not rendering

**IMUs measure orientation, not position.** Two consequences shape the whole design.

Poses must be computed by forward kinematics from assumed fixed bone lengths, and must
be expressed **palm-relative** (roughly `q_palm⁻¹ · q_finger`). Otherwise the hand
swings bodily whenever the wrist moves instead of the fingers curling.

More significantly: **one IMU per finger cannot determine that finger's three joints.**
A finger has MCP, PIP and DIP; a single orientation is one constraint against three
unknowns. The standard fix is to assume coupled flexion — PIP and DIP moving together
at a fixed ratio, commonly around 2:3. This looks convincing for open/close gestures
but cannot reproduce an isolated bent fingertip. That ratio is the main thing
separating a hand that reads as real from one that reads as puppet-like, so it should
be chosen deliberately rather than defaulted into.

Also note the IMUs are **6-axis with no magnetometer**, so heading is unobservable and
yaw will drift. Handling that is the calibration's job; the visualization should not
paper over it, since making the drift visible is part of showing what the calibration
achieves.

## Layout

```
web/                    The visualiser — server.py, glove_ble.py, static/
docs/pi-deploy.md       Running on the Pi: services, kiosk, performance
docs/data-contract.md   What the glove puts on the wire, verified against firmware
docs/pi-setup.md        Pi access, GPU findings, what is installed
Saxion-SSP/             The team repo (separate git checkout)
```

## Open questions

1. **Axis convention.** `projections.py` reads forward as local +Z; the firmware's
   knuckle layout reads as +Y. Reconciling them needs the Blender scene or real
   hardware. The UI exposes a selector rather than guessing.
2. **Sustained sample rate** across 6 sensors on real hardware.
3. **Which calibration path is live** — `CAL_DISABLE_FUNCTIONAL` is currently set,
   so baked misalignment matrices are used instead of the functional calibration.
4. **BLE transport** exists in the firmware but is out of scope for now.
