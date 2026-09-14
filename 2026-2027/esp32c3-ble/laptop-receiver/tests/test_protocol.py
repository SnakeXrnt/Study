import struct

import pytest

from ble_rx.link import Stats
from ble_rx.protocol import PACKET_SIZE, PacketError, SensorSample, decode, encode


def make_sample(idx: int = 7) -> SensorSample:
    # Values chosen to be exactly representable as float32 so round-trip
    # comparisons are exact. Precision loss gets its own test below.
    return SensorSample(
        t_us=123_456_789,
        idx=idx,
        gx=0.5 * idx,
        gy=0.25 * idx,
        gz=0.125 * idx,
        ax=0.0,
        ay=0.0,
        az=1.0,
        qw=1.0,
        qx=0.0,
        qy=0.0,
        qz=0.0,
    )


def test_packet_is_48_bytes():
    # Must match the static_assert in esp32-client/include/sensor_packet.h.
    assert PACKET_SIZE == 48
    assert len(encode(make_sample())) == 48


def test_round_trip():
    sample = make_sample()
    assert decode(encode(sample)) == sample


def test_field_offsets_match_the_c_struct():
    """Byte-for-byte check against a hand-built little-endian packed layout."""
    payload = (
        struct.pack("<I", 123_456_789)
        + struct.pack("<I", 7)
        + struct.pack("<3f", 0.5, 1.5, 2.5)
        + struct.pack("<3f", 0.0, 0.0, 1.0)
        + struct.pack("<4f", 1.0, 0.0, 0.0, 0.0)
    )
    sample = decode(payload)
    assert sample.t_us == 123_456_789
    assert sample.idx == 7
    assert sample.gyro == (0.5, 1.5, 2.5)
    assert sample.accel == (0.0, 0.0, 1.0)
    assert sample.quat == (1.0, 0.0, 0.0, 0.0)


def test_float32_precision_is_lossy():
    """The wire carries float32, so the firmware's 0.1*idx never round-trips exact."""
    sample = SensorSample(
        t_us=0, idx=7,
        gx=0.1 * 7, gy=0.2 * 7, gz=0.3 * 7,
        ax=0.0, ay=0.0, az=1.0,
        qw=1.0, qx=0.0, qy=0.0, qz=0.0,
    )
    decoded = decode(encode(sample))
    assert decoded.gx != sample.gx
    assert decoded.gx == pytest.approx(sample.gx, rel=1e-6)


def test_t_s_converts_microseconds():
    assert decode(encode(make_sample())).t_s == pytest.approx(123.456789)


def test_short_payload_is_rejected():
    with pytest.raises(PacketError):
        decode(b"\x00" * 47)


def test_20_byte_payload_hints_at_the_mtu():
    with pytest.raises(PacketError, match="MTU"):
        decode(b"\x00" * 20)


def test_stats_counts_gaps_and_rate():
    stats = Stats()
    for i, idx in enumerate([0, 1, 2, 5, 6]):
        stats.note(make_sample(idx), at=i * 0.02)
    assert stats.received == 5
    assert stats.missed == 2  # 3 and 4 never arrived
    assert stats.rate_hz == pytest.approx(50.0)


def test_stats_reset_clears_history():
    stats = Stats()
    stats.note(make_sample(0), at=0.0)
    stats.reset()
    assert stats.received == 0
    assert stats.first_idx is None
    assert stats.rate_hz == 0.0
