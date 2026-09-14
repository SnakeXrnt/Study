"""The BLE side of the receiver: scan, connect, subscribe, stream.

Everything this module learns is pushed out as an event so that the TUI and the
plain-text frontend can share one implementation.
"""

from __future__ import annotations

import asyncio
import time
import warnings
from collections import deque
from dataclasses import dataclass, field
from enum import Enum
from typing import Callable

from bleak import BleakClient, BleakScanner
from bleak.backends.device import BLEDevice
from bleak.backends.scanner import AdvertisementData

from .protocol import (
    DATA_CHAR_UUID,
    DEVICE_NAME,
    PACKET_SIZE,
    SERVICE_UUID,
    PacketError,
    SensorSample,
    decode,
)


class State(str, Enum):
    IDLE = "idle"
    SCANNING = "scanning"
    FOUND = "found"
    CONNECTING = "connecting"
    DISCOVERING = "discovering services"
    SUBSCRIBING = "subscribing"
    STREAMING = "streaming"
    DISCONNECTED = "disconnected"
    ERROR = "error"


@dataclass(slots=True)
class LogEvent:
    level: str  # info | good | warn | error
    text: str
    at: float = field(default_factory=time.time)


@dataclass(slots=True)
class StateEvent:
    state: State
    detail: str = ""


@dataclass(slots=True)
class DeviceEvent:
    """One device seen while scanning. is_target marks our ESP32."""

    address: str
    name: str
    rssi: int
    is_target: bool


@dataclass(slots=True)
class SampleEvent:
    sample: SensorSample
    at: float


@dataclass(slots=True)
class Stats:
    received: int = 0
    bad: int = 0
    missed: int = 0
    first_idx: int | None = None
    last_idx: int | None = None
    mtu: int = 0
    connected_at: float | None = None
    _times: deque[float] = field(default_factory=lambda: deque(maxlen=64))

    def note(self, sample: SensorSample, at: float) -> None:
        self.received += 1
        self._times.append(at)
        if self.first_idx is None:
            self.first_idx = sample.idx
        elif self.last_idx is not None:
            gap = sample.idx - self.last_idx - 1
            if gap > 0:
                self.missed += gap
        self.last_idx = sample.idx

    @property
    def rate_hz(self) -> float:
        if len(self._times) < 2:
            return 0.0
        span = self._times[-1] - self._times[0]
        return (len(self._times) - 1) / span if span > 0 else 0.0

    def reset(self) -> None:
        self.received = 0
        self.bad = 0
        self.missed = 0
        self.first_idx = None
        self.last_idx = None
        self.mtu = 0
        self.connected_at = None
        self._times.clear()


Emit = Callable[[object], None]


class SensorLink:
    """Owns one connection attempt loop against the ESP32 peripheral."""

    def __init__(
        self,
        emit: Emit,
        *,
        address: str | None = None,
        name: str = DEVICE_NAME,
        adapter: str | None = None,
        scan_timeout: float = 8.0,
        reconnect: bool = True,
    ) -> None:
        self._emit = emit
        self._address = address.upper() if address else None
        self._name = name
        self._adapter = adapter
        self._scan_timeout = scan_timeout
        self._reconnect = reconnect
        self.stats = Stats()
        self._last_address: str | None = None
        self._disconnected = asyncio.Event()
        self._stop = asyncio.Event()

    # -- public ------------------------------------------------------------

    def stop(self) -> None:
        self._stop.set()
        self._disconnected.set()

    async def run(self) -> None:
        while not self._stop.is_set():
            try:
                target = await self._acquire_target()
                if target is None:
                    self._log("warn", "ESP32 not found in this scan window")
                    self._log(
                        "info",
                        "if it was streaming a moment ago, the adapter may still hold "
                        "the link: bluetoothctl disconnect <mac>",
                    )
                    self._state(State.IDLE, "not found")
                    if not self._reconnect:
                        return
                    await self._sleep(2.0)
                    continue
                await self._session(target)
            except asyncio.CancelledError:
                raise
            except Exception as exc:  # noqa: BLE001 - surfaced to the user
                self._log("error", f"{type(exc).__name__}: {exc}")
                self._state(State.ERROR, str(exc))
                if not self._reconnect:
                    return
                await self._sleep(3.0)
            else:
                if not self._reconnect:
                    return
                await self._sleep(1.5)

    # -- steps -------------------------------------------------------------

    async def _acquire_target(self) -> BLEDevice | str | None:
        """Pick something to connect to.

        A fixed address is used directly: BlueZ can connect to a device it
        already knows even when that device is not currently advertising, which
        a scan would never see.
        """
        if self._address:
            self._log("info", f"connecting directly to {self._address} (no scan)")
            return self._address

        device = await self._scan()
        if device is not None:
            return device

        # We have talked to it before this run, so try the address anyway.
        if self._last_address:
            self._log("info", f"scan empty, retrying {self._last_address} directly")
            return self._last_address
        return None

    async def _scan(self) -> BLEDevice | None:
        self._state(State.SCANNING)
        target_hint = self._address or f"name {self._name!r} / service {SERVICE_UUID[:8]}..."
        self._log("info", f"scanning {self._scan_timeout:.0f}s for {target_hint}")

        found: asyncio.Future[BLEDevice] = asyncio.get_running_loop().create_future()
        seen: set[str] = set()

        def on_detect(device: BLEDevice, adv: AdvertisementData) -> None:
            is_target = self._matches(device, adv)
            if device.address not in seen:
                seen.add(device.address)
                self._emit(
                    DeviceEvent(
                        address=device.address,
                        name=adv.local_name or device.name or "(unnamed)",
                        rssi=adv.rssi if adv.rssi is not None else 0,
                        is_target=is_target,
                    )
                )
            if is_target and not found.done():
                found.set_result(device)

        # bleak 3.x takes backend options in a per-backend dict rather than a
        # bare adapter= keyword.
        kwargs: dict = {"bluez": {"adapter": self._adapter}} if self._adapter else {}

        async with BleakScanner(on_detect, **kwargs):
            try:
                device = await asyncio.wait_for(found, timeout=self._scan_timeout)
            except asyncio.TimeoutError:
                self._log("info", f"scan finished, {len(seen)} BLE device(s) in range")
                return None

        self._state(State.FOUND, device.address)
        self._log("good", f"found {device.name or self._name} at {device.address}")
        return device

    def _matches(self, device: BLEDevice, adv: AdvertisementData) -> bool:
        if self._address:
            return device.address.upper() == self._address
        uuids = {u.lower() for u in adv.service_uuids or ()}
        if SERVICE_UUID.lower() in uuids:
            return True
        candidate = adv.local_name or device.name or ""
        return candidate == self._name

    async def _session(self, device: BLEDevice | str) -> None:
        address = device if isinstance(device, str) else device.address
        self._disconnected.clear()
        self.stats.reset()

        # BlueZ can fire the disconnect callback for its own internal retries
        # while connect() is still running. Honouring those would end the
        # session before it began, so callbacks only count once we are live.
        live = False

        def on_disconnect(_client: BleakClient) -> None:
            if not live:
                return
            self._log("warn", "peripheral disconnected")
            self._disconnected.set()

        self._state(State.CONNECTING, address)
        client_kwargs: dict = {"bluez": {"adapter": self._adapter}} if self._adapter else {}
        client = BleakClient(device, disconnected_callback=on_disconnect, **client_kwargs)

        await client.connect()
        try:
            live = True
            self._disconnected.clear()
            self.stats.connected_at = time.time()
            self._last_address = address
            self._log("good", f"connected to {address}")

            self._state(State.DISCOVERING)
            service = client.services.get_service(SERVICE_UUID)
            if service is None:
                available = ", ".join(s.uuid for s in client.services) or "none"
                raise RuntimeError(f"sensor service missing; device exposes: {available}")

            char = service.get_characteristic(DATA_CHAR_UUID)
            if char is None:
                raise RuntimeError("sensor service found but the data characteristic is missing")
            if "notify" not in char.properties:
                raise RuntimeError(f"characteristic cannot notify (props: {char.properties})")

            mtu = await self._negotiated_mtu(client)
            self.stats.mtu = mtu or 0
            if mtu is None:
                self._log("info", "ATT MTU not reported by BlueZ; checking packet lengths instead")
            else:
                self._log("info", f"ATT MTU {mtu} ({mtu - 3} byte payload)")
                if mtu - 3 < PACKET_SIZE:
                    self._log("warn", f"MTU leaves less than {PACKET_SIZE} bytes, expect truncation")

            self._state(State.SUBSCRIBING)
            await client.start_notify(char, self._on_notify)
            self._state(State.STREAMING, address)
            self._log("good", "subscribed, streaming")

            # Poll alongside the callback: if a disconnect event is ever
            # dropped, is_connected still gets us out.
            while not self._disconnected.is_set() and not self._stop.is_set():
                if not client.is_connected:
                    self._log("warn", "link dropped")
                    break
                try:
                    await asyncio.wait_for(self._disconnected.wait(), timeout=1.0)
                except asyncio.TimeoutError:
                    pass
        finally:
            live = False
            self._state(State.DISCONNECTED)
            try:
                await client.disconnect()
            except Exception:  # noqa: BLE001 - already going down
                pass

    @staticmethod
    async def _negotiated_mtu(client: BleakClient) -> int | None:
        """Best-effort MTU read.

        The BlueZ backend hardcodes 23 until an attribute has been acquired, so
        ask it to acquire one first. Returns None when the value is unknowable.
        """
        backend = getattr(client, "_backend", None)
        acquire = getattr(backend, "_acquire_mtu", None)
        if acquire is not None:
            try:
                await acquire()
            except Exception:  # noqa: BLE001 - diagnostics only, never fatal
                return None
        if getattr(backend, "_mtu_size", False) is None:
            return None
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            return client.mtu_size

    def _on_notify(self, _char, payload: bytearray) -> None:
        at = time.monotonic()
        try:
            sample = decode(bytes(payload))
        except PacketError as exc:
            self.stats.bad += 1
            self._log("error", f"bad packet: {exc}")
            return
        self.stats.note(sample, at)
        self._emit(SampleEvent(sample=sample, at=at))

    # -- helpers -----------------------------------------------------------

    async def _sleep(self, seconds: float) -> None:
        try:
            await asyncio.wait_for(self._stop.wait(), timeout=seconds)
        except asyncio.TimeoutError:
            pass

    def _log(self, level: str, text: str) -> None:
        self._emit(LogEvent(level=level, text=text))

    def _state(self, state: State, detail: str = "") -> None:
        self._emit(StateEvent(state=state, detail=detail))
