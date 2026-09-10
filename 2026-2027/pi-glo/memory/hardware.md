# Hardware

All figures below were measured on the actual devices on 2026-09-06, not looked
up from datasheets.

## The glove

Two firmwares exist for two different jobs. They are not interchangeable.

### Hand tracking — `examples/sense-6madgwick`

An **Arduino Nano 33 BLE**, six IMUs, over **USB serial**:

| id | name | part | bus |
|---|---|---|---|
| 0 | palm | BMI270 | I2C (`Wire1`, 400 kHz) |
| 1 | thumb | LSM6DSL | software SPI, CS 10 / MISO 12 |
| 2 | index | LSM6DSL | software SPI, CS 9 / MISO 5 |
| 3 | middle | LSM6DSL | software SPI, CS 7 / MISO 3 |
| 4 | ring | LSM6DSL | software SPI, CS 8 / MISO 4 |
| 5 | pinky | LSM6DSL | software SPI, CS 6 / MISO 2 |

**Six sensors, not seven** — one per finger plus the palm. An early assumption
of seven (two on the thumb) was wrong.

**It does not emit raw accelerometer and gyroscope data.** On-device it applies
misalignment/sensitivity/offset correction, tracks and removes gyro bias, runs
Madgwick fusion, and runs a forward-kinematics pass. What reaches the host is a
fused, calibrated, palm-relative **quaternion**. Calibration is already done in
C++ before anything leaves the board.

No magnetometers are configured, so **heading is unobservable and yaw drifts**.
That is inherent, not a bug to fix.

### Swipe gestures — `examples/ble-tinyml-enum`

The same Nano 33 BLE, accelerometer only, running a TFLite Micro classifier and
notifying results over **BLE**. This is what was flashed and working as of
2026-09-06.

| | |
|---|---|
| Advertised name | `NanoCmd` |
| BLE address | `69:E3:F3:02:DB:8B` |
| USB serial number | `000000000000000084DB69E3F302DB8B` (tail matches the BLE address) |
| USB IDs | vendor `0x2341`; product `0x805A` running, `0x005A` in bootloader |

Detector parameters, from the source:

| | |
|---|---|
| Sample rate | 100 Hz, accelerometer only |
| Start / end energy threshold | 0.10 / 0.06 |
| Energy window | 20 samples |
| Pre-buffer | 300 ms retained *before* motion is detected |
| Max record window | 300 samples (3 s) |
| Cooldown | 0.3 s |
| Build cost | RAM 55.4%, flash 67.2% |

The pre-buffer matters: the classified window starts *before* the energy gate
trips, so the beginning of a movement is not clipped.

**The `COOLDOWN` enum value is never entered.** The state machine returns to
`IDLE` and gates on `g_cooldown_until_us` instead. Anything reporting state must
derive "cooling down" from that timestamp, not from `g_state`.

## The Raspberry Pi

| | |
|---|---|
| Board | Raspberry Pi 4 Model B Rev 1.5 |
| Hostname | `1770np-pi` |
| OS | Debian 12 bookworm, aarch64 |
| Desktop | **labwc (Wayland)** + lightdm + wf-panel-pi |
| RAM | 3.7 GB |
| Storage | 29 GB SD card, ~21 GB free |
| GPU | VideoCore VI — V3D 4.2.14.0, Mesa 24.2.8 |
| Bluetooth | `hci0`, UART bus, working (discovered 19 devices in an 8 s scan) |

### Graphics ceiling — the decisive constraint

| Renderer | Desktop GL | GLES | Vulkan |
|---|---|---|---|
| **V3D (hardware)** | **3.1** (GLSL 1.40) | **3.1** | 1.2.289 (V3DV) |
| Zink (GL-over-Vulkan) | **broken** — reports `0.0` | — | — |
| llvmpipe (software) | 4.5 (GLSL 4.50) | 3.2 | 1.3.289 (lavapipe) |

**OpenGL 3.1 is a hardware limit.** VideoCore VI predates 3.2, so no driver
update raises it. That rules out geometry shaders (3.2), tessellation (4.0),
desktop compute shaders (4.3) — and Blender 3.4, which needs 3.3.

Zink should in principle bridge the gap by running desktop GL over the Pi's
Vulkan driver. It is installed and loads, but V3DV does not expose what it needs
and it reports `Max core profile version: 0.0`. **Not a workaround.** Worth
retesting after a Mesa bump, since that one is software.

What remains usable: **GLES 3.1 and Vulkan 1.2 run on real hardware**, and GLES
3.1 includes compute shaders. WebGL2 maps to GLES 3.0, which is why the browser
rendering path is hardware-accelerated and Blender is not.

Rule of thumb: running existing desktop-GL software means software rendering and
CPU speed; writing your own means targeting GLES 3.1 or Vulkan 1.2 for real
acceleration.

### Blender, if it is ever needed again

Installed but off the critical path.

- `/usr/local/bin/blender` is a wrapper forcing `LIBGL_ALWAYS_SOFTWARE=1`.
  Without it the GUI refuses to start. Delete that file to revert.
- Headless renders need `xvfb-run -a`; plain `blender -b` aborts on a libepoxy
  GL-context assertion despite `-b` meaning background.
- `-o` must precede `-f` or the output path is silently ignored.
- Reference: default cube, 1920x1080, 64 samples, ~59 s on CPU.
