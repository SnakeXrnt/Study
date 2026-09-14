"""A fake peripheral so the receiver can be exercised without hardware.

It produces exactly the byte stream the ESP32 would send, so the decode path,
the counters and the TUI are all the real ones.
"""

from __future__ import annotations

import asyncio
import time

from .link import DeviceEvent, SensorLink, State
from .protocol import SensorSample, encode


class DemoLink(SensorLink):
    """Drop-in replacement for SensorLink that never touches the radio."""

    def __init__(self, emit, *, rate_hz: float = 50.0, **_ignored) -> None:
        super().__init__(emit)
        self._rate_hz = rate_hz

    async def run(self) -> None:
        self._state(State.SCANNING)
        self._log("info", "demo mode: no radio, generating packets locally")
        await asyncio.sleep(0.4)

        self._emit(
            DeviceEvent(address="AA:BB:CC:DD:EE:FF", name="ESP32C3-SENSOR (demo)", rssi=-48, is_target=True)
        )
        self._state(State.FOUND, "AA:BB:CC:DD:EE:FF")
        self._state(State.CONNECTING, "AA:BB:CC:DD:EE:FF")
        await asyncio.sleep(0.3)

        self.stats.reset()
        self.stats.mtu = 247
        self.stats.connected_at = time.time()
        self._log("good", "connected (demo)")
        self._state(State.STREAMING, "AA:BB:CC:DD:EE:FF")

        idx = 0
        period = 1.0 / self._rate_hz
        start = time.monotonic()
        while not self._stop.is_set():
            now_us = int((time.monotonic() - start) * 1_000_000)
            sample = SensorSample(
                t_us=now_us,
                idx=idx,
                gx=0.1 * idx,
                gy=0.2 * idx,
                gz=0.3 * idx,
                ax=0.0,
                ay=0.0,
                az=1.0,
                qw=1.0,
                qx=0.0,
                qy=0.0,
                qz=0.0,
            )
            # Round-trip through the wire format on purpose.
            self._on_notify(None, bytearray(encode(sample)))
            idx += 1
            await asyncio.sleep(period)
