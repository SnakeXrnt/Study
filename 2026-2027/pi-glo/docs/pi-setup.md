# Raspberry Pi setup notes

State of the demo box as of 2026-09-06, and the graphics findings that drove the
architecture choice.

## Access

```
ssh pi-glo
```

Configured in `~/.ssh/config` on Ethan's Mac — `glo@192.168.3.121`, dedicated key
`~/.ssh/id_pi_glo`, kept separate from the GitHub key. Passwordless sudo already
shipped on the image (`/etc/sudoers.d/010_pi-nopasswd`).

Note: interactive password prompts do not work through Claude Code's shell (no TTY),
so anything needing a typed password must be run in a normal terminal.

## Hardware

| | |
|---|---|
| Board | Raspberry Pi 4 Model B Rev 1.5 |
| OS | Debian 12 bookworm, aarch64 |
| RAM | 3.7 GB |
| Storage | 29 GB SD card, ~21 GB free |
| GPU | VideoCore VI — V3D 4.2.14.0, Mesa 24.2.8 |

## Graphics ceiling — the reason we are not using Blender

Measured on the board, not looked up:

| Renderer | Desktop GL | GLES | Vulkan |
|---|---|---|---|
| **V3D (hardware)** | **3.1** (GLSL 1.40) | **3.1** | 1.2.289 (V3DV) |
| Zink (GL-over-Vulkan) | **broken** — reports `0.0` | — | — |
| llvmpipe (software) | 4.5 (GLSL 4.50) | 3.2 | 1.3.289 (lavapipe) |

**OpenGL 3.1 is a hardware limit.** VideoCore VI predates 3.2, so no driver update
raises it. This rules out on-GPU: geometry shaders (3.2), tessellation (4.0), desktop
compute shaders (4.3) — and Blender 3.4, which requires 3.3.

Zink should in principle bridge the gap by running desktop GL over the Pi's Vulkan
driver, giving hardware-accelerated GL 4.x. It is installed and loads, but V3DV does
not expose what it needs and Blender fails identically under it. Worth retesting after
a future Mesa bump — that one is a software limitation, not hardware.

**What this leaves usable:** GLES 3.1 and Vulkan 1.2 both run on real hardware. GLES
3.1 includes compute shaders. WebGL2 maps to GLES 3.0, so **the browser rendering path
is fully accelerated** — which is what the architecture depends on.

## Installed

- **Blender 3.4.1** — installed before the approach changed. Kept for offline/asset
  work; not part of the live pipeline.
  - `/usr/local/bin/blender` is a wrapper forcing `LIBGL_ALWAYS_SOFTWARE=1`, without
    which it refuses to start at all. Delete the file to revert.
  - Headless renders additionally need `xvfb-run -a` — plain `blender -b` aborts on a
    libepoxy GL-context assertion despite `-b` meaning background. Note `-o` must come
    *before* `-f` or the output path is silently ignored.
  - Reference: default cube, 1920x1080, 64 samples, ~59 s on CPU.
- **xvfb**, **mesa-utils** — installed while diagnosing the above.
- **Chromium 152.0.7977.75**, **Python 3.11.2**. No Node.js.

## Not yet done

- **GPIO I2C is not enabled.** Only `/dev/i2c-20` and `/dev/i2c-21` exist, which are
  the HDMI DDC buses, not usable for sensors. Irrelevant while the glove is on USB
  serial, but needed if it is ever wired directly.
- Chromium's GPU acceleration has **not been confirmed on the real display** —
  `chrome://gpu` should be checked before committing to the browser path. The
  Raspberry Pi OS build normally ships it enabled.
- No kiosk autostart unit yet.
