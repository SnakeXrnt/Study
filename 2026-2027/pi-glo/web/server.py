#!/usr/bin/env python3
"""
pi-glo visualiser server.

Reads the glove's USB-serial stream, assembles frames, and republishes them to
the browser over Server-Sent Events. Also serves the static UI, so the whole
demo is one process with no build step.

Wire format produced by examples/sense-6madgwick (main.cpp):

    <id>:<qw>,<qx>,<qy>,<qz>,<lx>,<ly>,<lz>;

One record per sensor, six records per burst, emitted at 20 Hz over 115200 baud.
`id` is 0..5 = palm, thumb, index, middle, ring, pinky. In the firmware's
RELATIVE_ORIENTATION_ONLY mode the palm carries its world orientation and the
fingers carry palm-relative orientation; `loc` is a *constant* knuckle position
per finger, not live data.

Dependencies: pyserial (only for --port; --simulate and --replay are stdlib).

    python3 server.py --simulate            # no hardware needed
    python3 server.py --port /dev/ttyACM0
    python3 server.py --port /dev/ttyACM0 --record capture.jsonl
    python3 server.py --replay capture.jsonl

Prediction overlays (ASL letters, swipe gestures, link state) are not computed
here. Post them in from whatever process owns the model:

    POST /api/asl      {"letter": "A", "confidence": 0.93, "candidates": [...]}
    POST /api/gesture  {"state": "recording", "gesture": "LEFT", "energy": 0.14}
    POST /api/link     {"transport": "ble", "state": "connected", "rssi": -54}

Each merges into the next outgoing frame. See docs/data-contract.md.
"""

from __future__ import annotations

import argparse
import http.server
import json
import math
import os
import queue
import random
import re
import shutil
import socketserver
import subprocess
import sys
import urllib.parse
import threading
import time
from dataclasses import dataclass, field

SENSOR_NAMES = ["palm", "thumb", "index", "middle", "ring", "pinky"]
SENSOR_COUNT = len(SENSOR_NAMES)

# Constant knuckle positions from HandFKModel::finger_ref_locs_ (right hand).
# Only used to place the simulator's output; real frames carry their own.
FINGER_REF_LOCS = {
    "palm":   (0.0, 0.0, 0.0),
    "thumb":  (1.0, 0.0, 0.0),
    "index":  (0.75, 1.0, 0.0),
    "middle": (0.25, 1.0, 0.0),
    "ring":   (-0.25, 1.0, 0.0),
    "pinky":  (-0.75, 1.0, 0.0),
}

STATIC_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "static")

# Music lives OUTSIDE the app directory on purpose. Deploys rsync web/ with
# --delete, so anything dropped inside static/ would be erased on the next one.
DEFAULT_MUSIC_DIR = os.path.join(os.path.expanduser("~"), "pi-glo", "music")
AUDIO_TYPES = {
    ".mp3": "audio/mpeg", ".m4a": "audio/mp4", ".aac": "audio/aac",
    ".ogg": "audio/ogg", ".oga": "audio/ogg", ".opus": "audio/ogg",
    ".wav": "audio/wav", ".flac": "audio/flac",
}

# Gesture vocabulary and BLE identifiers, from examples/ttgo-complete and
# examples/ble-tinyml-enum. Values are the on-wire enum ordinals.
GESTURES = {0: "UNKNOWN", 1: "UP", 2: "DOWN", 3: "LEFT", 4: "RIGHT",
            5: "STILL", 6: "COBRA"}

# Media bindings from ttgo-complete's MODE_MEDIA branch.
MEDIA_ACTIONS = {
    "LEFT": "Previous track", "RIGHT": "Next track",
    "UP": "Volume up", "DOWN": "Volume down",
    "COBRA": "Play / pause", "STILL": "\u2014",
}

BLE_SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
BLE_CHAR_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8"
BLE_DEVICE_NAME = "NanoCmd"

# Energy-gate thresholds the on-device state machine uses to segment a swipe.
ENERGY_START = 0.10
ENERGY_END = 0.06

ALPHABET = [chr(c) for c in range(ord("A"), ord("Z") + 1)]


_ART_CACHE: dict = {}


def _embedded_art(path: str) -> tuple:
    """Pull the front cover out of a FLAC file, or return (None, None).

    FLAC metadata blocks are simple enough to walk directly, so this needs no
    audio library on a machine where every dependency is one more thing to
    install at a venue. Anything that is not a FLAC, or carries no picture,
    simply has no art; nothing is substituted.
    """
    try:
        key = (path, os.path.getmtime(path))
    except OSError:
        return (None, None)
    if key in _ART_CACHE:
        return _ART_CACHE[key]

    found = (None, None)
    try:
        with open(path, "rb") as f:
            if f.read(4) == b"fLaC":
                while True:
                    head = f.read(4)
                    if len(head) < 4:
                        break
                    last, btype = head[0] & 0x80, head[0] & 0x7F
                    length = int.from_bytes(head[1:4], "big")
                    if btype != 6:                       # 6 is PICTURE
                        f.seek(length, os.SEEK_CUR)
                        if last:
                            break
                        continue
                    data = f.read(length)
                    o = 4                                 # skip picture type
                    mlen = int.from_bytes(data[o:o + 4], "big"); o += 4
                    mime = data[o:o + mlen].decode("ascii", "replace"); o += mlen
                    dlen = int.from_bytes(data[o:o + 4], "big"); o += 4 + dlen
                    o += 16                               # w, h, depth, colours
                    blen = int.from_bytes(data[o:o + 4], "big"); o += 4
                    found = (mime, data[o:o + blen])
                    break
                    
    except OSError:
        found = (None, None)

    _ART_CACHE.clear()          # one cover at a time is plenty; covers are large
    _ART_CACHE[key] = found
    return found


def _split_track_name(stem: str) -> tuple:
    """Turn a filename into something worth putting on a screen.

    Ripped files arrive as "09-the_weeknd-blinding_lights". Shown raw that is
    ugly on a projector, so drop the track number, split artist from title on
    the first dash, and tidy the separators. Nothing is invented: if the name
    carries no artist, the artist comes back empty rather than guessed.
    """
    name = re.sub(r"^\s*\d+\s*[-._ ]+", "", stem)
    artist = ""
    if "-" in name:
        left, _, right = name.partition("-")
        if left.strip() and right.strip():
            artist, name = left, right
    tidy = lambda t: re.sub(r"\s+", " ", t.replace("_", " ")).strip()
    cap = lambda t: " ".join(w if w.isupper() else w.capitalize() for w in tidy(t).split())
    return cap(name) or stem, cap(artist)


# --------------------------------------------------------------------------
# Frame assembly
# --------------------------------------------------------------------------

@dataclass
class Stats:
    bytes_in: int = 0
    records_ok: int = 0
    records_bad: int = 0
    frames: int = 0
    rate_hz: float = 0.0
    _rate_window: list = field(default_factory=list)

    def note_frame(self, now: float) -> None:
        self.frames += 1
        self._rate_window.append(now)
        cutoff = now - 2.0
        while self._rate_window and self._rate_window[0] < cutoff:
            self._rate_window.pop(0)
        if len(self._rate_window) > 1:
            span = self._rate_window[-1] - self._rate_window[0]
            self.rate_hz = (len(self._rate_window) - 1) / span if span > 0 else 0.0

    def snapshot(self) -> dict:
        total = self.records_ok + self.records_bad
        return {
            "bytes_in": self.bytes_in,
            "records_ok": self.records_ok,
            "records_bad": self.records_bad,
            "frames": self.frames,
            "rate_hz": round(self.rate_hz, 2),
            "error_pct": round(100.0 * self.records_bad / total, 2) if total else 0.0,
        }


class FrameAssembler:
    """Turns a byte stream of ';'-delimited records into whole-hand frames.

    The firmware emits sensors 0..5 in order. A frame is complete when a sensor
    id repeats or id 5 arrives, which tolerates dropped records without stalling.
    """

    MAX_BUFFER = 8192

    def __init__(self, stats: Stats) -> None:
        self._buf = bytearray()
        self._pending: dict[str, dict] = {}
        self._stats = stats
        self._seq = 0

    def feed(self, data: bytes) -> list[dict]:
        self._stats.bytes_in += len(data)
        self._buf.extend(data)

        if len(self._buf) > self.MAX_BUFFER:
            # Runaway buffer means we are not finding delimiters; drop it rather
            # than grow without bound, and resync on the next ';'.
            del self._buf[:-1024]

        frames = []
        while True:
            idx = self._buf.find(b";")
            if idx == -1:
                break
            chunk = bytes(self._buf[:idx]).strip()
            del self._buf[: idx + 1]
            if not chunk:
                continue
            frame = self._on_record(chunk)
            if frame is not None:
                frames.append(frame)
        return frames

    def _on_record(self, chunk: bytes) -> dict | None:
        parsed = self._parse(chunk)
        if parsed is None:
            self._stats.records_bad += 1
            return None
        self._stats.records_ok += 1

        name, entry = parsed
        frame = None
        # A repeat means the previous burst is as complete as it will get.
        if name in self._pending:
            frame = self._emit()
        self._pending[name] = entry
        if len(self._pending) == SENSOR_COUNT:
            frame = self._emit()
        return frame

    def _parse(self, chunk: bytes) -> tuple[str, dict] | None:
        # Firmware log lines (g_logger->info/error) share the stream and are not
        # ';'-terminated, so they arrive glued to the front of the next record.
        # Resync on the last newline rather than losing that record.
        if b"\n" in chunk:
            chunk = chunk.rsplit(b"\n", 1)[1].strip()
        if b":" not in chunk:
            return None
        raw_id, _, raw_vals = chunk.partition(b":")
        try:
            sid = int(raw_id)
        except ValueError:
            return None
        if not 0 <= sid < SENSOR_COUNT:
            return None
        try:
            vals = [float(v) for v in raw_vals.split(b",")]
        except ValueError:
            return None
        if len(vals) != 7:
            return None
        if not all(math.isfinite(v) for v in vals):
            return None
        return SENSOR_NAMES[sid], {"q": vals[:4], "loc": vals[4:]}

    def _emit(self) -> dict:
        self._seq += 1
        now = time.monotonic()
        self._stats.note_frame(now)
        frame = {
            "t": round(now, 4),
            "seq": self._seq,
            "sensors": self._pending,
            "complete": len(self._pending) == SENSOR_COUNT,
        }
        self._pending = {}
        return frame


# --------------------------------------------------------------------------
# Sources
# --------------------------------------------------------------------------

class Overlays:
    """Prediction state pushed in over HTTP by whatever owns the models.

    Kept separate from sensor frames because it arrives on its own schedule —
    a swipe classifies once per gesture, not once per sample.
    """

    STALE_AFTER = 3.0  # seconds before a prediction stops being shown as current

    def __init__(self) -> None:
        self._lock = threading.Lock()
        self.asl: dict = {}
        self.gesture: dict = {}
        self.link: dict = {"transport": None, "state": "unknown"}

    def update(self, kind: str, payload: dict) -> dict:
        now = time.monotonic()
        with self._lock:
            target = getattr(self, kind)
            merged = {**target, **payload, "updated": now}
            setattr(self, kind, merged)
            return merged

    def snapshot(self) -> dict:
        now = time.monotonic()
        with self._lock:
            def age(d):
                if not d or "updated" not in d:
                    return None
                out = dict(d)
                out["age"] = round(now - d["updated"], 3)
                out["stale"] = out["age"] > self.STALE_AFTER
                return out
            return {"asl": age(self.asl), "gesture": age(self.gesture),
                    "link": age(self.link) or self.link}


class Broadcaster:
    """Fan-out to SSE clients. Slow clients drop frames rather than block."""

    def __init__(self, overlays: "Overlays | None" = None) -> None:
        self._clients: set[queue.Queue] = set()
        self._lock = threading.Lock()
        self.latest: dict | None = None
        self.overlays = overlays
        self.last_publish = 0.0

    def subscribe(self) -> queue.Queue:
        q: queue.Queue = queue.Queue(maxsize=8)
        with self._lock:
            self._clients.add(q)
        return q

    def unsubscribe(self, q: queue.Queue) -> None:
        with self._lock:
            self._clients.discard(q)

    def publish(self, frame: dict) -> None:
        if self.overlays is not None:
            frame = {**frame, **self.overlays.snapshot()}
        self.latest = frame
        self.last_publish = time.monotonic()
        with self._lock:
            targets = list(self._clients)
        for q in targets:
            try:
                q.put_nowait(frame)
            except queue.Full:
                pass  # Viewer is behind; skipping is correct for live telemetry.

    @property
    def client_count(self) -> int:
        with self._lock:
            return len(self._clients)


def run_serial(port: str, baud: int, bus: Broadcaster, stats: Stats,
               recorder, stop: threading.Event) -> None:
    try:
        import serial  # type: ignore
    except ImportError:
        sys.exit("pyserial is required for --port. Install with: pip install pyserial")

    while not stop.is_set():
        try:
            with serial.Serial(port, baud, timeout=0.1) as ser:
                print(f"[serial] connected {port} @ {baud}", flush=True)
                asm = FrameAssembler(stats)
                while not stop.is_set():
                    data = ser.read(max(1, ser.in_waiting))
                    if not data:
                        continue
                    for frame in asm.feed(data):
                        bus.publish(frame)
                        if recorder:
                            recorder.write(json.dumps(frame) + "\n")
                            recorder.flush()
        except Exception as exc:  # noqa: BLE001 - surface and retry
            if stop.is_set():
                return
            print(f"[serial] {exc}; retrying in 2s", flush=True)
            stop.wait(2.0)


def run_replay(path: str, bus: Broadcaster, stats: Stats,
               stop: threading.Event, loop: bool = True) -> None:
    while not stop.is_set():
        with open(path) as fh:
            prev_t = None
            for line in fh:
                if stop.is_set():
                    return
                line = line.strip()
                if not line:
                    continue
                try:
                    frame = json.loads(line)
                except json.JSONDecodeError:
                    stats.records_bad += 1
                    continue
                # Honour the original inter-frame timing.
                t = frame.get("t")
                if prev_t is not None and isinstance(t, (int, float)):
                    stop.wait(max(0.0, min(0.5, t - prev_t)))
                prev_t = t
                stats.note_frame(time.monotonic())
                bus.publish(frame)
        if not loop:
            return


def _quat_axis_angle(ax, ay, az, angle):
    h = angle / 2.0
    s = math.sin(h)
    return [math.cos(h), ax * s, ay * s, az * s]


def _quat_mul(a, b):
    aw, ax, ay, az = a
    bw, bx, by, bz = b
    return [
        aw * bw - ax * bx - ay * by - az * bz,
        aw * bx + ax * bw + ay * bz - az * by,
        aw * by - ax * bz + ay * bw + az * bx,
        aw * bz + ax * by - ay * bx + az * bw,
    ]


def run_simulator(bus: Broadcaster, stats: Stats, stop: threading.Event,
                  rate_hz: float = 20.0, noise: float = 0.01) -> None:
    """Synthesise a plausible stream so the UI can be developed without hardware.

    Fingers curl in a staggered wave; the palm sways. Deliberately includes a
    little noise and occasional dropped sensors, because the real stream has both.
    """
    period = 1.0 / rate_hz
    seq = 0
    t0 = time.monotonic()
    while not stop.is_set():
        now = time.monotonic()
        t = now - t0
        seq += 1

        sensors = {}
        # Palm sways gently around X and Y.
        palm_q = _quat_mul(
            _quat_axis_angle(1, 0, 0, 0.25 * math.sin(t * 0.6)),
            _quat_axis_angle(0, 1, 0, 0.35 * math.sin(t * 0.4)),
        )
        sensors["palm"] = {"q": palm_q, "loc": list(FINGER_REF_LOCS["palm"])}

        for i, name in enumerate(SENSOR_NAMES[1:]):
            # Staggered curl wave, thumb shallower than the fingers.
            phase = t * 1.1 - i * 0.35
            amp = 0.6 if name == "thumb" else 1.25
            curl = -amp * (0.5 - 0.5 * math.cos(phase))
            splay = 0.12 * math.sin(t * 0.5 + i)
            q = _quat_mul(
                _quat_axis_angle(1, 0, 0, curl),
                _quat_axis_angle(0, 0, 1, splay),
            )
            q = [c + random.gauss(0, noise) for c in q]
            n = math.sqrt(sum(c * c for c in q)) or 1.0
            q = [c / n for c in q]

            # Occasionally drop a sensor, as a flaky SPI read would.
            if random.random() < 0.005:
                continue
            sensors[name] = {"q": q, "loc": list(FINGER_REF_LOCS[name])}

        stats.records_ok += len(sensors)
        stats.note_frame(now)
        bus.publish({
            "t": round(t, 4),
            "seq": seq,
            "sensors": sensors,
            "complete": len(sensors) == SENSOR_COUNT,
            "simulated": True,
        })
        stop.wait(period)


def run_prediction_simulator(ov: "Overlays", stop: threading.Event) -> None:
    """Stand in for the ASL and swipe models so the UI can be built and shown.

    Mirrors the real shapes: the swipe model walks idle -> recording -> cooldown
    with an energy trace crossing the firmware's thresholds, and fingerspelling
    emits a letter with a candidate distribution.
    """
    word = list("SAXION")
    wi = 0
    text = ""
    t0 = time.monotonic()

    ov.update("link", {
        "transport": "ble", "state": "scanning", "device": None,
        "service_uuid": BLE_SERVICE_UUID, "char_uuid": BLE_CHAR_UUID,
    })
    stop.wait(1.5)
    ov.update("link", {
        "transport": "ble", "state": "connected", "device": BLE_DEVICE_NAME,
        "address": "e8:9f:6d:12:af:03", "rssi": -54, "seq": 0, "dropped": 0,
    })

    seq = 0
    while not stop.is_set():
        # --- a fingerspelled letter -------------------------------------
        letter = word[wi % len(word)]
        wi += 1
        conf = random.uniform(0.78, 0.98)
        others = random.sample([c for c in ALPHABET if c != letter], 3)
        cands = [[letter, round(conf, 3)]]
        rest = 1.0 - conf
        for i, c in enumerate(others):
            share = rest * (0.6 if i == 0 else 0.25 if i == 1 else 0.15)
            cands.append([c, round(share, 3)])
        text = (text + letter)[-24:]
        seq += 1
        ov.update("asl", {"letter": letter, "confidence": round(conf, 3),
                          "candidates": cands, "text": text})
        ov.update("link", {"seq": seq, "rssi": -50 - random.randint(0, 12)})
        stop.wait(1.4)
        if stop.is_set():
            break

        # --- a swipe, walked through the real state machine --------------
        g = random.choice(["LEFT", "RIGHT", "UP", "DOWN", "COBRA"])
        for step in range(9):
            if stop.is_set():
                return
            frac = step / 8
            energy = ENERGY_START + 0.09 * math.sin(math.pi * frac) + random.uniform(0, .01)
            ov.update("gesture", {"state": "recording", "gesture": None,
                                  "energy": round(energy, 4), "scores": None})
            stop.wait(0.05)

        scores = {k.lower(): round(random.uniform(0.0, 0.06), 3)
                  for k in ["COBRA", "DOWN", "LEFT", "RIGHT", "STILL", "UP"]}
        gconf = round(random.uniform(0.82, 0.99), 3)
        scores[g.lower()] = gconf
        ov.update("gesture", {
            "state": "cooldown", "gesture": g, "confidence": gconf,
            "energy": round(ENERGY_END - 0.01, 4), "scores": scores,
            "action": MEDIA_ACTIONS.get(g, ""),
        })
        stop.wait(0.4)
        ov.update("gesture", {"state": "idle", "energy": 0.01})
        stop.wait(0.9)


def run_heartbeat(bus: Broadcaster, stop: threading.Event, period: float = 0.2) -> None:
    """Publish an empty frame whenever the sensor source has gone quiet.

    Marked `idle` so the UI leaves the hand alone instead of blanking it.
    """
    seq = 0
    while not stop.is_set():
        if time.monotonic() - bus.last_publish >= period:
            seq += 1
            bus.publish({"t": round(time.monotonic(), 4), "seq": seq,
                         "sensors": {}, "complete": False, "idle": True})
        stop.wait(period / 2)


# --------------------------------------------------------------------------
# Settings
# --------------------------------------------------------------------------

CONFIG_TOOL = "/usr/local/bin/piglo-config"

# Audio lives in the user's PipeWire session, which a system service does not
# join automatically, so its socket has to be pointed at explicitly.
def _user_env() -> dict:
    env = dict(os.environ)
    env.setdefault("XDG_RUNTIME_DIR", f"/run/user/{os.getuid()}")
    return env


def _run(cmd: list, timeout: float = 5.0) -> tuple:
    """Run a command, returning (ok, output). Never raises."""
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           timeout=timeout, env=_user_env())
        return r.returncode == 0, (r.stdout or r.stderr).strip()
    except (OSError, subprocess.SubprocessError) as exc:
        return False, str(exc)


def read_config() -> dict:
    ok, out = _run(["sudo", "-n", CONFIG_TOOL, "get"])
    cfg = {}
    if ok:
        for line in out.splitlines():
            k, _, v = line.partition("=")
            if k.startswith("PIGLO_"):
                cfg[k] = v
    return cfg


def audio_outputs() -> dict:
    """The PipeWire sinks, and which one is currently default."""
    ok, out = _run(["pactl", "list", "short", "sinks"])
    sinks = []
    if ok:
        for line in out.splitlines():
            parts = line.split("\t")
            if len(parts) >= 2:
                sinks.append({"id": parts[1], "name": _friendly_sink(parts[1])})
    ok2, cur = _run(["pactl", "get-default-sink"])
    return {"sinks": sinks, "default": cur if ok2 else None}


def _friendly_sink(sink: str) -> str:
    """A sink name a person can read, without inventing detail."""
    s = sink.lower()
    if "hdmi" in s:
        return "HDMI"
    if "bluez" in s or "bluetooth" in s:
        return "Bluetooth speaker"
    if "usb" in s:
        return "USB audio"
    if "headphone" in s or "analog" in s:
        return "Headphone jack"
    return sink


def wifi_state() -> dict:
    """Current network and what is in range. Reading only; joining is a POST."""
    ok, out = _run(["sudo", "-n", CONFIG_TOOL, "wifi-status"])
    status = {}
    if ok:
        for line in out.splitlines():
            k, _, v = line.partition("=")
            if k:
                status[k] = v

    ok2, out2 = _run(["sudo", "-n", CONFIG_TOOL, "wifi-list"], timeout=20.0)
    nets = []
    if ok2:
        for line in out2.splitlines():
            parts = line.split("|")
            if len(parts) < 4 or not parts[1]:
                continue
            try:
                signal = int(parts[2])
            except ValueError:
                signal = None
            nets.append({"ssid": parts[1], "signal": signal,
                         "secure": bool(parts[3].strip()),
                         "current": parts[0].strip() == "*"})
    return {"status": status, "networks": nets, "available": ok or ok2}


def bluetooth_audio(scan_seconds: int = 0) -> dict:
    """Audio devices the adapter can see, and which one is in use.

    The adapter is shared with the glove's BLE link. Scanning was measured on
    2026-09-11 not to disturb it; streaming is the case that needs watching.
    """
    args = ["sudo", "-n", CONFIG_TOOL, "bt-scan", str(int(scan_seconds))]
    ok, out = _run(args, timeout=max(20.0, scan_seconds + 15))
    devices = []
    if ok:
        for line in out.splitlines():
            parts = line.split("|")
            if len(parts) >= 4:
                devices.append({"mac": parts[0], "name": parts[1],
                                "paired": parts[2] == "yes",
                                "connected": parts[3] == "yes"})
    return {"devices": devices}


def serial_ports() -> list:
    try:
        return sorted("/dev/" + n for n in os.listdir("/dev")
                      if n.startswith(("ttyACM", "ttyUSB")))
    except OSError:
        return []


# --------------------------------------------------------------------------
# HTTP
# --------------------------------------------------------------------------

class Handler(http.server.SimpleHTTPRequestHandler):
    bus: Broadcaster
    stats: Stats
    overlays: Overlays
    source_label: str
    music_dir: str

    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=STATIC_DIR, **kwargs)

    def log_message(self, fmt, *args):  # quieter console
        if "/stream" not in (self.path or ""):
            super().log_message(fmt, *args)

    def end_headers(self):
        """Never let a browser cache anything we serve.

        Without this the UI is served with only a Last-Modified date, so Firefox
        applies heuristic freshness and can keep showing a stale index.html after
        a redeploy. On the Pi that silently invalidated a round of performance
        measurements: the page under test was not the page that had been
        deployed. Nothing here is big enough for caching to be worth that.
        """
        if not self._cache_header_sent:
            # The app itself must never be cached, or a redeploy silently serves
            # the old page. Audio and artwork are the opposite: large, immutable
            # for the life of a file, and re-fetching a 3MB cover on every track
            # change would be daft.
            if (self.path or "").startswith("/music/"):
                self.send_header("Cache-Control", "public, max-age=3600")
            else:
                self.send_header("Cache-Control", "no-store, must-revalidate")
            self._cache_header_sent = True
        super().end_headers()

    def send_response(self, *args, **kwargs):
        self._cache_header_sent = False
        super().send_response(*args, **kwargs)

    _cache_header_sent = False

    ACCEPTS = {"/api/asl": "asl", "/api/gesture": "gesture", "/api/link": "link"}

    def _music_files(self) -> list:
        """Audio files in the music directory, newest naming order aside, sorted."""
        try:
            names = sorted(os.listdir(self.music_dir))
        except OSError:
            return []
        out = []
        for n in names:
            ext = os.path.splitext(n)[1].lower()
            if ext not in AUDIO_TYPES:
                continue
            full = os.path.join(self.music_dir, n)
            if not os.path.isfile(full):
                continue
            title, artist = _split_track_name(os.path.splitext(n)[0])
            out.append({"name": title, "artist": artist,
                        "art": ext == ".flac",
                        "file": n, "type": AUDIO_TYPES[ext],
                        "bytes": os.path.getsize(full)})
        return out

    def _serve_music(self, rel: str) -> None:
        """Serve one audio file, refusing anything that escapes the directory."""
        rel = urllib.parse.unquote(rel)
        full = os.path.normpath(os.path.join(self.music_dir, rel))
        root = os.path.normpath(self.music_dir)
        if not full.startswith(root + os.sep) or not os.path.isfile(full):
            self.send_error(404, "no such track")
            return
        ctype = AUDIO_TYPES.get(os.path.splitext(full)[1].lower())
        if ctype is None:
            self.send_error(404, "not an audio file")
            return
        try:
            fh = open(full, "rb")
        except OSError:
            self.send_error(404, "cannot read track")
            return
        with fh:
            size = os.fstat(fh.fileno()).st_size
            self.send_response(200)
            self.send_header("Content-Type", ctype)
            self.send_header("Content-Length", str(size))
            self.send_header("Accept-Ranges", "none")
            self.end_headers()
            try:
                shutil.copyfileobj(fh, self.wfile)
            except (BrokenPipeError, ConnectionResetError):
                pass

    def _serve_art(self, rel: str) -> None:
        rel = urllib.parse.unquote(rel)
        full = os.path.normpath(os.path.join(self.music_dir, rel))
        root = os.path.normpath(self.music_dir)
        if not full.startswith(root + os.sep) or not os.path.isfile(full):
            self.send_error(404, "no such track")
            return
        mime, blob = _embedded_art(full)
        if not blob:
            self.send_error(404, "no embedded artwork")
            return
        self.send_response(200)
        self.send_header("Content-Type", mime or "image/jpeg")
        self.send_header("Content-Length", str(len(blob)))
        self.end_headers()
        try:
            self.wfile.write(blob)
        except (BrokenPipeError, ConnectionResetError):
            pass

    def do_GET(self):  # noqa: N802
        if self.path.startswith("/stream"):
            return self._sse()
        if self.path.startswith("/api/settings"):
            if not self._local_only():
                return
            return self._json({
                "config": read_config(),
                "audio": audio_outputs(),
                "serial_ports": serial_ports(),
                "source": self.source_label,
            })
        if self.path.startswith("/api/bluetooth"):
            if not self._local_only():
                return
            q = urllib.parse.urlparse(self.path).query
            secs = 0
            try:
                secs = int(urllib.parse.parse_qs(q).get("scan", ["0"])[0])
            except ValueError:
                secs = 0
            return self._json(bluetooth_audio(max(0, min(20, secs))))
        if self.path.startswith("/api/wifi"):
            if not self._local_only():
                return
            return self._json(wifi_state())
        if self.path.startswith("/api/music"):
            return self._json({"dir": self.music_dir, "tracks": self._music_files()})
        if self.path.startswith("/music/art/"):
            return self._serve_art(self.path[len("/music/art/"):].split("?", 1)[0])
        if self.path.startswith("/music/"):
            return self._serve_music(self.path[len("/music/"):].split("?", 1)[0])
        if self.path.startswith("/api/status"):
            return self._json({
                "source": self.source_label,
                "clients": self.bus.client_count,
                "stats": self.stats.snapshot(),
                "sensors": SENSOR_NAMES,
                "gestures": list(GESTURES.values()),
                "media_actions": MEDIA_ACTIONS,
                "ble": {"service": BLE_SERVICE_UUID, "characteristic": BLE_CHAR_UUID,
                        "device": BLE_DEVICE_NAME},
                "energy_thresholds": {"start": ENERGY_START, "end": ENERGY_END},
                **self.overlays.snapshot(),
            })
        return super().do_GET()

    def do_POST(self):  # noqa: N802
        path = self.path.split("?", 1)[0].rstrip("/")
        if path == "/api/settings":
            return self._post_settings()
        if path == "/api/wifi":
            return self._post_wifi()
        if path == "/api/bluetooth":
            return self._post_bluetooth()
        kind = self.ACCEPTS.get(path)
        if kind is None:
            self.send_error(404, "unknown endpoint")
            return
        try:
            length = int(self.headers.get("Content-Length") or 0)
        except ValueError:
            length = 0
        if length <= 0 or length > 64 * 1024:
            self.send_error(400, "expected a JSON body")
            return
        try:
            payload = json.loads(self.rfile.read(length))
        except (json.JSONDecodeError, UnicodeDecodeError) as exc:
            self.send_error(400, f"invalid JSON: {exc}")
            return
        if not isinstance(payload, dict):
            self.send_error(400, "body must be a JSON object")
            return
        self._json({"ok": True, kind: self.overlays.update(kind, payload)})

    def _local_only(self) -> bool:
        """Settings are for whoever is at the machine, not the whole network.

        The visualiser deliberately listens on every interface so visitors can
        watch from a phone. Changing the demo's configuration is a different
        thing entirely, so those endpoints answer the loopback address only.
        """
        host = self.client_address[0]
        if host in ("127.0.0.1", "::1", "::ffff:127.0.0.1"):
            return True
        self.send_error(403, "settings are only available on the device itself")
        return False

    def _post_settings(self) -> None:
        if not self._local_only():
            return
        payload = self._read_json()
        if payload is None:
            return

        results, errors = {}, {}

        # Everything privileged goes through the helper, which has its own
        # whitelist. Nothing here constructs a shell command from user input.
        for key, value in (payload.get("config") or {}).items():
            key, value = str(key), str(value)
            # The helper enforces this too. Both layers check it on purpose: the
            # config file is read by systemd as an EnvironmentFile, so a value
            # carrying a newline would append a second key to it.
            if any(c in value for c in "\r\n\x00") or not value.isprintable():
                errors[key] = "control characters are not allowed"
                continue
            ok, out = _run(["sudo", "-n", CONFIG_TOOL, "set", key, value])
            (results if ok else errors)[key] = out

        sink = payload.get("audio_sink")
        if sink:
            ok, out = _run(["pactl", "set-default-sink", str(sink)])
            (results if ok else errors)["audio_sink"] = out or sink

        vol = payload.get("audio_volume")
        if vol is not None:
            try:
                v = max(0.0, min(1.0, float(vol)))
                ok, out = _run(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", f"{v:.2f}"])
                (results if ok else errors)["audio_volume"] = out or f"{v:.2f}"
            except (TypeError, ValueError):
                errors["audio_volume"] = "not a number"

        restarted = False
        if payload.get("restart"):
            ok, out = _run(["sudo", "-n", CONFIG_TOOL, "restart"], timeout=10.0)
            restarted = ok
            if not ok:
                errors["restart"] = out

        self._json({"ok": not errors, "applied": results, "errors": errors,
                    "restarted": restarted, "config": read_config(),
                    "audio": audio_outputs()})

    def _post_wifi(self) -> None:
        """Join a network. The password reaches nmcli on standard input.

        It is never an argument to anything, so it does not appear in the
        process list or in any log, and it is not written to disk here. The
        endpoint answers the loopback address only, so the password is typed on
        the machine's own screen rather than sent across the network.
        """
        if not self._local_only():
            return
        payload = self._read_json()
        if payload is None:
            return

        ssid = str(payload.get("ssid") or "")
        if not ssid or any(c in ssid for c in "\r\n\x00"):
            self._json({"ok": False, "error": "no usable network name"})
            return

        if payload.get("forget"):
            ok, out = _run(["sudo", "-n", CONFIG_TOOL, "wifi-forget", ssid], timeout=20.0)
            self._json({"ok": ok, "message": out, **wifi_state()})
            return

        password = str(payload.get("password") or "")
        try:
            r = subprocess.run(
                ["sudo", "-n", CONFIG_TOOL, "wifi-connect", ssid],
                input=password + "\n", capture_output=True, text=True,
                timeout=45.0, env=_user_env())
            ok = r.returncode == 0
            msg = (r.stdout or r.stderr).strip()
        except (OSError, subprocess.SubprocessError) as exc:
            ok, msg = False, str(exc)
        del password

        self._json({"ok": ok, "message": msg, **wifi_state()})

    def _post_bluetooth(self) -> None:
        if not self._local_only():
            return
        payload = self._read_json()
        if payload is None:
            return
        mac = str(payload.get("mac") or "")
        action = str(payload.get("action") or "connect")
        if action not in ("connect", "disconnect", "forget"):
            self._json({"ok": False, "message": "unknown action"})
            return
        ok, out = _run(["sudo", "-n", CONFIG_TOOL, "bt-" + action, mac], timeout=60.0)
        # PipeWire takes a moment to publish a new sink after a speaker joins.
        if ok and action == "connect":
            time.sleep(2.0)
        self._json({"ok": ok, "message": out,
                    **bluetooth_audio(0), "audio": audio_outputs()})

    def _read_json(self):
        try:
            length = int(self.headers.get("Content-Length") or 0)
        except ValueError:
            length = 0
        if length <= 0 or length > 64 * 1024:
            self.send_error(400, "expected a JSON body")
            return None
        try:
            payload = json.loads(self.rfile.read(length))
        except (json.JSONDecodeError, UnicodeDecodeError) as exc:
            self.send_error(400, f"invalid JSON: {exc}")
            return None
        if not isinstance(payload, dict):
            self.send_error(400, "body must be a JSON object")
            return None
        return payload

    def _json(self, payload: dict) -> None:
        body = json.dumps(payload).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def _sse(self) -> None:
        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream")
        self.send_header("Connection", "keep-alive")
        self.send_header("X-Accel-Buffering", "no")
        self.end_headers()

        q = self.bus.subscribe()
        last_status = 0.0
        try:
            if self.bus.latest:
                self._send_event("frame", self.bus.latest)
            while True:
                try:
                    frame = q.get(timeout=1.0)
                    self._send_event("frame", frame)
                except queue.Empty:
                    self.wfile.write(b": keepalive\n\n")
                    self.wfile.flush()
                now = time.monotonic()
                if now - last_status > 1.0:
                    last_status = now
                    self._send_event("status", {
                        "source": self.source_label,
                        "stats": self.stats.snapshot(),
                    })
        except (BrokenPipeError, ConnectionResetError):
            pass
        finally:
            self.bus.unsubscribe(q)

    def _send_event(self, name: str, payload: dict) -> None:
        self.wfile.write(f"event: {name}\ndata: {json.dumps(payload)}\n\n".encode())
        self.wfile.flush()


class ThreadedHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True


# --------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser(description="pi-glo glove visualiser")
    src = ap.add_mutually_exclusive_group(required=True)
    src.add_argument("--port", help="serial device, e.g. /dev/ttyACM0")
    src.add_argument("--simulate", action="store_true", help="synthetic data, no hardware")
    src.add_argument("--replay", metavar="FILE", help="replay a .jsonl capture")
    src.add_argument("--idle", action="store_true",
                     help="serve the UI with no sensor source (BLE-only demos)")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--http-port", type=int, default=8080)
    ap.add_argument("--host", default="0.0.0.0")
    ap.add_argument("--record", metavar="FILE", help="append frames as JSON lines")
    ap.add_argument("--music", metavar="DIR", default=DEFAULT_MUSIC_DIR,
                    help="folder of audio files for the swipe demo "
                         "(default: %(default)s)")
    ap.add_argument("--fake-predictions", action="store_true",
                    help="synthesise ASL/swipe/link overlays alongside real sensor data")
    args = ap.parse_args()

    overlays = Overlays()
    bus = Broadcaster(overlays)
    stats = Stats()
    stop = threading.Event()
    recorder = open(args.record, "a") if args.record else None

    if args.idle:
        label = "idle"
        target = None
    elif args.simulate:
        label = "simulator"
        target = lambda: run_simulator(bus, stats, stop)  # noqa: E731
    elif args.replay:
        label = f"replay:{os.path.basename(args.replay)}"
        target = lambda: run_replay(args.replay, bus, stats, stop)  # noqa: E731
    else:
        label = f"serial:{args.port}"
        target = lambda: run_serial(args.port, args.baud, bus, stats, recorder, stop)  # noqa: E731

    if target is not None:
        threading.Thread(target=target, daemon=True).start()
    threading.Thread(target=lambda: run_heartbeat(bus, stop), daemon=True).start()
    if args.simulate or args.fake_predictions:
        threading.Thread(target=lambda: run_prediction_simulator(overlays, stop),
                         daemon=True).start()

    Handler.bus = bus
    Handler.stats = stats
    Handler.overlays = overlays
    Handler.source_label = label
    Handler.music_dir = os.path.abspath(os.path.expanduser(args.music))

    httpd = ThreadedHTTPServer((args.host, args.http_port), Handler)
    print(f"[pi-glo] source={label}", flush=True)
    n = len(Handler._music_files(Handler)) if os.path.isdir(Handler.music_dir) else 0
    print(f"[pi-glo] music={Handler.music_dir} ({n} tracks)", flush=True)
    print(f"[pi-glo] http://localhost:{args.http_port}/  (Ctrl-C to stop)", flush=True)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n[pi-glo] shutting down", flush=True)
    finally:
        stop.set()
        httpd.shutdown()
        if recorder:
            recorder.close()


if __name__ == "__main__":
    main()
