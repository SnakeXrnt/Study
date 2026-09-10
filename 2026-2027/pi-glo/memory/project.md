# The project

A sensor glove that drives a computer, built for a Saxion open-day showcase.
Everything has to run self-contained on one Raspberry Pi so it can sit on a
table as a single box.

## Two demo modes

**Fingerspelling** — the glove recognises the 26 ASL letters and types them.
**Swipe gestures** — five gestures (up, down, left, right, cobra) control media
playback.

A third view shows the hand itself in 3D from live IMU data. That one is the
engineering view; the other two are what visitors see.

## Who owns what

Ethan owns the **swipe model** side. A collaborator owns the **ASL model** and
the hand's calibration/projection maths. The team repo is
`github.com/KirilStrezikozin/Saxion-SSP`.

Practically: the visualiser computes **no predictions of its own**. Models push
results into it over HTTP. That boundary was chosen so the two sides can work
independently, in different languages, without coordinating on anything but
three JSON shapes. See `protocols.md`.

## Folder layout — this trips people up

```
~/pi-glo/                 Ethan's own work. NOT a git repo.
├── README.md             architecture overview
├── docs/                 protocol and deployment reference
├── memory/               this knowledge base
├── web/                  the visualiser (server, BLE bridge, UI)
└── Saxion-SSP/           the TEAM repo, a separate git checkout, branch `openday`
```

`Saxion-SSP` is cloned **inside** `~/pi-glo`. Ethan's files sit deliberately
outside it, so nothing here pollutes the shared repo. Two consequences:

- Running `git` commands in `~/pi-glo` does nothing useful; you must be inside
  `Saxion-SSP`.
- Anything written to `Saxion-SSP` lands on a **shared branch** that a teammate
  also works on. Treat edits there as affecting someone else's work.

## Where the ESP32 went

An ESP32 TTGO used to be the hub: it received gestures over BLE, drove a small
TFT, exposed a web dashboard, and acted as a Bluetooth HID keyboard. The Pi has
taken that role so the demo is one box instead of two.

`Saxion-SSP/examples/ttgo-complete/src/main.cpp` is still the best reference for
intended behaviour — mode switching, the media bindings, the on-screen keyboard
grid. Read it as a specification, not as live code.

## Blender is not the visualiser

The original plan was to drive a rigged hand in Blender over serial. That was
abandoned for two independent reasons: Blender 3.4 needs OpenGL 3.3 and the Pi 4
tops out at 3.1, and Blender is a content-creation tool rather than a realtime
runtime. See `hardware.md` for the measured GL ceilings.

Blender is still installed on the Pi for offline asset work. The live path is a
browser.
