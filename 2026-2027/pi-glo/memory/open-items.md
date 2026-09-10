# Open items

Check this before starting work. Most recent first.

## The Pi is unreachable, and its SSH host key changed — 2026-09-10

`ssh pi-glo` fails with `REMOTE HOST IDENTIFICATION HAS CHANGED`. The key
offered by `192.168.3.121` is now
`SHA256:KjcKy1xS83n6H3BJgsgwsU1mQi7tGM4sTqPPX39KjjU`, which does not match
`~/.ssh/known_hosts:25`.

What was observed:

- `192.168.3.121` responds to ping and answers SSH, with a **different key**.
- `192.168.3.60`, the Pi's other address, is **silent**.

Most likely DHCP reassigned `.121` to a different device on the network, and the
Pi moved or is off. A reimaged Pi would also explain it.

**Do not delete the `known_hosts` entry to make the warning go away.** That is
the one reflex this warning exists to prevent. Establish what is actually at
that address first — check the router's lease table, or read the Pi's address
from its own screen. When the Pi's real address is known, update the `HostName`
in the `pi-glo` block of `~/.ssh/config` rather than trusting whatever answers.

Everything in `pi-deployment.md` describing services and state was true on
2026-09-06 and has not been re-verified since.

## Uncommitted firmware on a shared branch

Three modified files in `~/pi-glo/Saxion-SSP`, branch `openday`, still
uncommitted as of 2026-09-10 (confirmed):

```
M examples/ble-tinyml-enum/src/main.cpp
M lib/ble-enum/libs/BleConnectionEnum.cpp
M lib/ble-enum/libs/BleConnectionEnum.h
```

They are flashed to the Nano and working, but exist **only on Ethan's Mac**. A
lost machine or a stray `git checkout` destroys work the demo depends on.

Two logically separate changes, worth separate commits:

1. **A build-breaking typo fix.** `main.cpp` had `g_ g_calibrating = false;`
   with a stray `g_ ` fragment that fails to compile. This is committed and
   broken on `openday` for the teammate too, not just locally.

2. **The BLE telemetry characteristic** (`...b26a9`) — see `protocols.md`. Also
   captures `max_confidence` in `classify_gesture()`, which the original computed
   and threw away. Costs +232 bytes flash, +16 bytes RAM.

`openday` is shared with a collaborator. Pushing affects their work.

## Open bug: the energy trace does not draw

**Unresolved.** The firmware sends live motion energy, the server carries it, the
browser does not render it.

Confirmed working — do not re-investigate this half:

- `/api/status` and the SSE frames both contain `gesture.energy` as a live float
  (~0.003 idle, >0.10 while moving).
- `gesture.state` transitions `idle -> recording` correctly.
- `confidence` arrives (0.9961 observed).

Confirmed broken: in the page, `energyLive` reads `false` and `eHist` is all
zeros, *even though `latest.gesture.energy` is a number in the same frame*.

The setter is `energyLive = g.energy != null` inside `tick()` in
`web/static/index.html`. Since the data is present in `latest`, the leading
hypothesis is **an exception thrown earlier in `tick()`**, before the gesture
block is reached — `requestAnimationFrame(tick)` is called at the *top* of the
function, so the loop keeps spinning while silently never reaching later code.

**This is a hypothesis, not a finding.** Start by opening devtools on the page
and looking for a thrown error, or wrap the tick body in try/catch and log.

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
