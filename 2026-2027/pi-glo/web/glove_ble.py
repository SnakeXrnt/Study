#!/usr/bin/env python3
"""
Bridge the glove's BLE link into the pi-glo visualiser.

The Nano 33 BLE running examples/ble-tinyml-enum acts as a GATT server: it
classifies a swipe on-device and notifies a 6-byte packet. This connects as the
client, decodes those packets, and POSTs them to the visualiser's overlay API.
The TTGO used to play this role; the Pi now does.

Packet layout (BleConnectionEnum::packGesture), 6 bytes:

    seq   uint8       increments per packet, wraps at 256
    ts    uint32 LE   the Nano's millis() at send time
    value uint8       <=6 gesture ordinal, 32..126 ASCII char, 8 backspace

No firmware change is needed. Note the firmware transmits *only* the classified
result — there is no confidence, no energy trace and no recording-state signal
on the wire, so those stay unavailable rather than being invented here.

    sudo apt install python3-bleak
    python3 glove_ble.py --server http://localhost:8080
"""

from __future__ import annotations

import argparse
import asyncio
import json
import queue
import struct
import sys
import threading
import urllib.error
import urllib.request

SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
CHAR_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8"
TELEMETRY_CHAR_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a9"
DEVICE_NAME = "NanoCmd"

GESTURES = {0: "UNKNOWN", 1: "UP", 2: "DOWN", 3: "LEFT",
            4: "RIGHT", 5: "STILL", 6: "COBRA"}
MEDIA_ACTIONS = {
    "LEFT": "Previous track", "RIGHT": "Next track",
    "UP": "Volume up", "DOWN": "Volume down", "COBRA": "Play / pause",
}

# How long a classified gesture stays lit before the UI falls back to idle.
HOLD_SECONDS = 1.2


class Poster:
    """POSTs on a worker thread so the BLE event loop never waits on HTTP.

    Events that must arrive (a classified gesture) are queued. Telemetry, which
    streams at 20Hz, is coalesced: only the newest value per endpoint is sent,
    because a stale energy reading has no value once a newer one exists.
    """

    def __init__(self, base: str, verbose: bool = False) -> None:
        self.base = base.rstrip("/")
        self.verbose = verbose
        self._warned = False
        self._q: queue.Queue = queue.Queue(maxsize=64)
        self._latest: dict[str, dict] = {}
        self._lock = threading.Lock()
        threading.Thread(target=self._worker, daemon=True).start()

    def post(self, path: str, payload: dict) -> None:
        """Queue an event that must be delivered."""
        try:
            self._q.put_nowait((path, payload))
        except queue.Full:
            pass

    def post_latest(self, path: str, payload: dict) -> None:
        """Replace any unsent payload for this endpoint. Newest wins."""
        with self._lock:
            self._latest[path] = payload

    def link(self, **kw) -> None:
        self.post("/api/link", {"transport": "ble", **kw})

    def _worker(self) -> None:
        while True:
            try:
                path, payload = self._q.get(timeout=0.05)
                self._send(path, payload)
            except queue.Empty:
                pass
            with self._lock:
                pending = list(self._latest.items())
                self._latest.clear()
            for path, payload in pending:
                self._send(path, payload)

    def _send(self, path: str, payload: dict) -> None:
        body = json.dumps(payload).encode()
        req = urllib.request.Request(
            self.base + path, data=body,
            headers={"Content-Type": "application/json"}, method="POST")
        try:
            urllib.request.urlopen(req, timeout=1.5).read()
            self._warned = False
        except (urllib.error.URLError, OSError) as exc:
            if not self._warned:
                print(f"[bridge] visualiser unreachable at {self.base}: {exc}", flush=True)
                self._warned = True


class Bridge:
    def __init__(self, poster: Poster, args) -> None:
        self.p = poster
        self.args = args
        self.last_seq: int | None = None
        self.dropped = 0
        self.text = ""
        self.hold_task: asyncio.Task | None = None

    TELEMETRY_STATES = {0: "idle", 1: "recording", 2: "cooldown"}

    def on_telemetry(self, _handle, data: bytearray) -> None:
        """10-byte packet: state u8, energy f32, confidence f32, gesture u8."""
        if len(data) < 10:
            return
        state, energy, confidence, _last = struct.unpack_from("<BffB", data, 0)
        self.telemetry_seen = True
        # Deliberately does not carry `gesture`: the command characteristic owns
        # that, and the hold timer clears it. Telemetry only owns live state.
        self.p.post_latest("/api/gesture", {
            "state": self.TELEMETRY_STATES.get(state, "idle"),
            "energy": round(energy, 4),
            "confidence": round(confidence, 4) if confidence > 0 else None,
        })

    def on_packet(self, _handle, data: bytearray) -> None:
        if len(data) < 6:
            print(f"[bridge] short packet ({len(data)} bytes), ignored", flush=True)
            return
        seq, ts, value = struct.unpack_from("<BIB", data, 0)

        if self.last_seq is not None:
            gap = (seq - self.last_seq - 1) % 256
            if gap:
                self.dropped += gap
        self.last_seq = seq

        if value in GESTURES:
            name = GESTURES[value]
            print(f"[bridge] seq={seq} ts={ts} gesture={name}", flush=True)
            # The firmware sends nothing during recording, so a packet means the
            # gesture is already classified and the device is cooling down.
            self.p.post("/api/gesture", {
                "state": "cooldown", "gesture": name,
                "action": MEDIA_ACTIONS.get(name, ""),
                "scores": None, "device_ts": ts,
            })
            self._schedule_idle()
        elif value == 8:
            self.text = self.text[:-1]
            self.p.post("/api/asl", {"letter": None, "text": self.text})
        elif 32 <= value <= 126:
            ch = chr(value)
            self.text = (self.text + ch)[-32:]
            print(f"[bridge] seq={seq} char={ch!r}", flush=True)
            self.p.post("/api/asl", {"letter": ch, "confidence": None,
                                     "candidates": None, "text": self.text})
        else:
            print(f"[bridge] seq={seq} unrecognised value {value}", flush=True)

        self.p.link(state="connected", device=getattr(self, "friendly", self.args.name),
                    address=self.address, seq=seq, dropped=self.dropped)

    def _schedule_idle(self) -> None:
        if self.hold_task and not self.hold_task.done():
            self.hold_task.cancel()

        async def clear():
            try:
                await asyncio.sleep(HOLD_SECONDS)
                # With telemetry present the firmware owns `state`; only clear
                # the gesture. Without it, clear both or the UI stays lit.
                payload = {"gesture": None, "action": None}
                if not self.telemetry_seen:
                    payload["state"] = "idle"
                self.p.post("/api/gesture", payload)
            except asyncio.CancelledError:
                pass

        self.hold_task = asyncio.ensure_future(clear())

    address = "—"


async def run(args) -> None:
    try:
        from bleak import BleakClient, BleakScanner
    except ImportError:
        sys.exit("bleak is required.  sudo apt install python3-bleak")

    poster = Poster(args.server, args.verbose)
    bridge = Bridge(poster, args)

    while True:
        poster.link(state="scanning", device=None, address=None, rssi=None,
                    seq=None, service_uuid=SERVICE_UUID, char_uuid=CHAR_UUID)
        print(f"[bridge] scanning for {args.name!r} / {SERVICE_UUID}", flush=True)

        device = None
        seen_rssi: dict[str, int] = {}
        try:
            if args.address:
                device = await BleakScanner.find_device_by_address(
                    args.address, timeout=args.scan_timeout)
            else:
                def match(d, adv):
                    # Take RSSI from the advertisement; BLEDevice.rssi is deprecated.
                    if adv.rssi is not None:
                        seen_rssi[d.address] = adv.rssi
                    if d.name == args.name:
                        return True
                    uuids = [u.lower() for u in (adv.service_uuids or [])]
                    return SERVICE_UUID in uuids
                device = await BleakScanner.find_device_by_filter(
                    match, timeout=args.scan_timeout)
        except Exception as exc:                      # noqa: BLE001
            print(f"[bridge] scan failed: {exc}", flush=True)

        if device is None:
            print("[bridge] not found, retrying", flush=True)
            poster.link(state="disconnected", device=None, address=None, rssi=None)
            await asyncio.sleep(2.0)
            continue

        bridge.address = getattr(device, "address", None)
        rssi = seen_rssi.get(bridge.address)
        raw_name = device.name or ""
        # A MAC-derived placeholder is not a name; fall back to the configured one.
        friendly = raw_name if raw_name and raw_name.replace("-", "") \
            != bridge.address.replace(":", "").upper() else args.name
        bridge.friendly = friendly
        print(f"[bridge] found {friendly} @ {bridge.address} (advertised {raw_name!r})",
              flush=True)
        poster.link(state="connecting", device=friendly, address=bridge.address,
                    rssi=rssi)

        try:
            async with BleakClient(device, timeout=args.connect_timeout) as client:
                await client.start_notify(CHAR_UUID, bridge.on_packet)
                try:
                    await client.start_notify(TELEMETRY_CHAR_UUID, bridge.on_telemetry)
                    print("[bridge] telemetry characteristic subscribed", flush=True)
                except Exception:                     # noqa: BLE001
                    # Firmware predating the telemetry characteristic. Gestures
                    # still work; the energy trace stays unavailable.
                    bridge.telemetry_seen = False
                    print("[bridge] no telemetry characteristic (older firmware)", flush=True)
                bridge.last_seq = None
                poster.link(state="connected", device=friendly,
                            address=bridge.address, rssi=rssi,
                            dropped=bridge.dropped,
                            service_uuid=SERVICE_UUID, char_uuid=CHAR_UUID)
                print("[bridge] subscribed; waiting for gestures", flush=True)
                while client.is_connected:
                    await asyncio.sleep(0.5)
        except Exception as exc:                      # noqa: BLE001
            print(f"[bridge] link error: {exc}", flush=True)

        print("[bridge] disconnected", flush=True)
        poster.link(state="disconnected", device=None, address=None, rssi=None)
        poster.post("/api/gesture", {"state": "idle", "gesture": None})
        await asyncio.sleep(1.5)


def main() -> None:
    ap = argparse.ArgumentParser(description="BLE bridge for the pi-glo visualiser")
    ap.add_argument("--server", default="http://localhost:8080",
                    help="visualiser base URL (default: %(default)s)")
    ap.add_argument("--name", default=DEVICE_NAME,
                    help="advertised device name (default: %(default)s)")
    ap.add_argument("--address", help="connect straight to a MAC, skipping the name match")
    ap.add_argument("--scan-timeout", type=float, default=8.0)
    ap.add_argument("--connect-timeout", type=float, default=20.0)
    ap.add_argument("-v", "--verbose", action="store_true")
    args = ap.parse_args()

    try:
        asyncio.run(run(args))
    except KeyboardInterrupt:
        print("\n[bridge] stopped", flush=True)


if __name__ == "__main__":
    main()
