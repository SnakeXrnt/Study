"""Wire format shared with the ESP32 firmware.

Mirror of esp32-client/include/sensor_packet.h. If one side changes, change
both -- the receiver validates the length but cannot detect a reordered field.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass

SERVICE_UUID = "cb187d50-b25c-4984-a9f7-70a65d837cfe"
DATA_CHAR_UUID = "cb187d51-b25c-4984-a9f7-70a65d837cfe"
DEVICE_NAME = "ESP32C3-SENSOR"

# uint32 t_us, uint32 idx, then ten little-endian IEEE-754 floats.
_FORMAT = "<II10f"
PACKET_SIZE = struct.calcsize(_FORMAT)  # 48
_PACKER = struct.Struct(_FORMAT)

FIELDS = ("gx", "gy", "gz", "ax", "ay", "az", "qw", "qx", "qy", "qz")


class PacketError(ValueError):
    """Raised when a notification does not look like a SensorPacket."""


@dataclass(frozen=True, slots=True)
class SensorSample:
    t_us: int
    idx: int
    gx: float
    gy: float
    gz: float
    ax: float
    ay: float
    az: float
    qw: float
    qx: float
    qy: float
    qz: float

    @property
    def t_s(self) -> float:
        """Device uptime in seconds at the moment the sample was taken."""
        return self.t_us / 1_000_000.0

    @property
    def gyro(self) -> tuple[float, float, float]:
        return (self.gx, self.gy, self.gz)

    @property
    def accel(self) -> tuple[float, float, float]:
        return (self.ax, self.ay, self.az)

    @property
    def quat(self) -> tuple[float, float, float, float]:
        return (self.qw, self.qx, self.qy, self.qz)


def decode(payload: bytes) -> SensorSample:
    """Turn one BLE notification into a sample."""
    if len(payload) != PACKET_SIZE:
        raise PacketError(
            f"expected {PACKET_SIZE} bytes, got {len(payload)}"
            + (" -- ATT MTU is probably still 23" if len(payload) == 20 else "")
        )
    return SensorSample(*_PACKER.unpack(payload))


def encode(sample: SensorSample) -> bytes:
    """Inverse of decode. Used by the tests and by --demo."""
    return _PACKER.pack(
        sample.t_us,
        sample.idx,
        sample.gx,
        sample.gy,
        sample.gz,
        sample.ax,
        sample.ay,
        sample.az,
        sample.qw,
        sample.qx,
        sample.qy,
        sample.qz,
    )


def csv_header() -> list[str]:
    return ["host_time", "t_us", "idx", *FIELDS]


def csv_row(host_time: float, sample: SensorSample) -> list[str]:
    return [
        f"{host_time:.6f}",
        str(sample.t_us),
        str(sample.idx),
        *(f"{getattr(sample, name):.6f}" for name in FIELDS),
    ]
