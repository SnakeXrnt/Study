# ESP32-C3 SuperMini over BLE

An ESP32-C3 SuperMini streams a sensor packet over Bluetooth Low Energy, and a
terminal app on the laptop finds the board, connects, and shows the numbers
live.

- `esp32-client/` is the PlatformIO firmware that produces and sends the data.
- `laptop-receiver/` is the Python receiver with a TUI.

Both sides are verified working against real hardware: 48-byte packets at a
steady 50 Hz with a negotiated 247-byte MTU.

## How BLE actually works

BLE is not a serial cable. Nothing is "sent to a laptop". A BLE device publishes
a small structured database, and whoever connects reads from it or asks to be
told when a value changes. Five ideas cover everything this project does.

**Advertising.** An idle peripheral shouts a tiny packet a few times a second on
three dedicated channels. The packet carries a name, a few flags, and a short
list of service identifiers. Nothing is connected yet. This is why a device that
is already connected to something else becomes invisible to everyone: it stops
advertising.

**Central and peripheral.** The one that advertises is the peripheral. The one
that scans and initiates is the central. Here the ESP32 is the peripheral and
the laptop is the central.

**Server and client.** Separately from that, whoever owns the data is the GATT
server and whoever reads it is the GATT client. The ESP32 owns the sensor
values, so the ESP32 is the server and the laptop is the client. This is the
opposite of the web, where the small device is usually the client. The folder is
called `esp32-client` because that is how the board was described, but in BLE
terms it is the peripheral and the server.

**Services and characteristics.** The server's database is a flat list of
attributes grouped into services. A service is a folder, a characteristic is a
file with a value plus a set of permissions such as read, write, or notify.
Every service and characteristic is named by a UUID. Standardised things like
heart rate get short 16-bit UUIDs from the Bluetooth SIG. Anything custom must
use a random 128-bit UUID, which is what this project does.

**Notifications.** Polling a characteristic wastes a round trip per sample. A
characteristic marked notify lets the client subscribe once, after which the
server pushes a new value whenever it wants. Subscribing works by writing to a
small descriptor attached to the characteristic, the Client Characteristic
Configuration Descriptor. The firmware only starts sending once that bit is set.
Notifications are unacknowledged, which is what makes them fast and what makes a
dropped-sample counter worth having.

Two numbers decide whether the stream keeps up.

The **ATT MTU** is the largest attribute payload in one exchange. It starts at
23 bytes, of which 3 are header, leaving 20 bytes of usable payload. Our packet
is 48 bytes, so the firmware asks for a larger MTU during connection setup. Once
it is raised to 247, one packet fits in one notification.

The **connection interval** is how often the two radios wake up to talk, from
7.5 ms to 4 s. Several notifications can ride in one of those windows, but
nothing at all moves between them. The firmware asks for 15 to 30 ms, which
carries 50 Hz comfortably.

## What gets sent

One characteristic, notify only, carrying a packed little-endian struct of
exactly 48 bytes.

| offset | type | field |
|---|---|---|
| 0 | uint32 | `t_us`, the value of `micros()` at sample time |
| 4 | uint32 | `idx`, a sample counter used to detect drops |
| 8 | 3x float32 | `gx gy gz` |
| 20 | 3x float32 | `ax ay az` |
| 32 | 4x float32 | `qw qx qy qz` |

The layout lives in `esp32-client/include/sensor_packet.h` and is mirrored in
`laptop-receiver/ble_rx/protocol.py`. Change one and you must change the other.
The floats are 32-bit on the wire, so a value the firmware computes as `0.1 *
idx` arrives very slightly off. That is the format, not a bug.

The UUIDs are random and belong to this project:

```
service         cb187d50-b25c-4984-a9f7-70a65d837cfe
characteristic  cb187d51-b25c-4984-a9f7-70a65d837cfe
advertised name ESP32C3-SENSOR
```

## Running the firmware

```
cd esp32-client
pio run -t upload
pio device monitor
```

The board prints its MAC and then a status line every second. It blinks slowly
while waiting and goes solid once a client subscribes.

## Running the TUI

One-time setup:

```
cd laptop-receiver
uv venv .venv
uv pip install --python .venv/bin/python -e ".[dev]"
```

Then, with the board powered:

```
.venv/bin/python -m ble_rx
```

That is the whole thing. It scans, connects, subscribes, and starts drawing.
Four panels and a log:

- top left is diagnostics: state, which device, signal strength, negotiated MTU
- bottom left is every BLE device the scan saw, with the ESP32 marked by an arrow
- top right is the live sensor output
- bottom right is throughput: packets, rate in Hz, missed, malformed

Keys are shown in the footer. `r` rescans, `l` starts and stops writing a CSV
file, `c` clears the log, `q` quits.

To show someone the interface without a board, `--demo` generates the same
packets locally and everything else behaves identically:

```
.venv/bin/python -m ble_rx --demo
```

Other modes:

```
.venv/bin/python -m ble_rx --scan                 # list nearby devices and exit
.venv/bin/python -m ble_rx --plain                # line output instead of the TUI
.venv/bin/python -m ble_rx --plain --csv out.csv  # log while printing
.venv/bin/python -m ble_rx --address AA:BB:...    # skip the scan, connect directly
```

`--plain` is the one to use when something is wrong, because every step prints
with a timestamp.

## When it does not connect

**The scan finds nothing at all.** The adapter is probably off. `bluetoothctl
power on` fixes it. `--scan` lists everything in range, so an empty list points
at the laptop and a long list without the ESP32 points at the board.

**The scan finds other devices but not the ESP32.** Most often the board is
still connected to something, so it has stopped advertising. This happens if a
previous receiver was killed rather than quit. Check with `bluetoothctl info
<mac>` and clear it with `bluetoothctl disconnect <mac>`. The firmware also
drops any client that connects without subscribing for 15 seconds, so the board
recovers on its own.

**Malformed packets, 20 bytes received.** The MTU never got raised, so
notifications are being truncated. The receiver reports this explicitly rather
than showing garbage.

**Missed packets climbing.** The connection interval is too slow for the sample
rate, or the link is weak. A couple of missed samples right after subscribing is
normal while the connection parameters settle.

## Tests

```
cd laptop-receiver
.venv/bin/python -m pytest
```

Ten tests cover the packet layout byte by byte against the C struct, the float32
precision loss, the drop and rate counters, and a headless run of the TUI driven
by the demo source.
