"""Command line entry point for the receiver."""

from __future__ import annotations

import argparse
import asyncio
import csv
import sys
import time
from datetime import datetime
from pathlib import Path

from .link import DeviceEvent, LogEvent, SampleEvent, SensorLink, StateEvent
from .protocol import DEVICE_NAME, SERVICE_UUID, csv_header, csv_row


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="ble-rx",
        description="Receive sensor packets from the ESP32-C3 BLE peripheral.",
    )
    parser.add_argument("--address", help="connect to this MAC instead of searching by name/UUID")
    parser.add_argument("--name", default=DEVICE_NAME, help="advertised name to match")
    parser.add_argument("--adapter", help="Bluetooth adapter, e.g. hci0")
    parser.add_argument("--scan-timeout", type=float, default=8.0, help="seconds per scan window")
    parser.add_argument("--no-reconnect", action="store_true", help="stop after the first session")
    parser.add_argument("--csv", type=Path, help="append every sample to this CSV file")

    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--plain", action="store_true", help="line-based output instead of the TUI")
    mode.add_argument("--scan", action="store_true", help="list nearby BLE devices and exit")
    mode.add_argument("--demo", action="store_true", help="run the TUI against a fake peripheral")

    parser.add_argument("--every", type=int, default=10, help="plain mode: print 1 of every N samples")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)

    if args.scan:
        return asyncio.run(_scan_only(args))
    if args.plain:
        return asyncio.run(_plain(args))

    from .tui import ReceiverApp

    link_kwargs: dict = {}
    if args.demo:
        from .demo import DemoLink

        link_kwargs["link_factory"] = DemoLink
    else:
        link_kwargs.update(
            address=args.address,
            name=args.name,
            adapter=args.adapter,
            scan_timeout=args.scan_timeout,
            reconnect=not args.no_reconnect,
        )
    ReceiverApp(**link_kwargs).run()
    return 0


async def _scan_only(args) -> int:
    from bleak import BleakScanner

    print(f"scanning {args.scan_timeout:.0f}s ...")
    kwargs = {"bluez": {"adapter": args.adapter}} if args.adapter else {}
    found = await BleakScanner.discover(timeout=args.scan_timeout, return_adv=True, **kwargs)

    if not found:
        print("no BLE devices at all -- check that the adapter is up (bluetoothctl power on)")
        return 1

    rows = sorted(found.values(), key=lambda pair: -pair[1].rssi)
    hit = False
    for device, adv in rows:
        uuids = {u.lower() for u in adv.service_uuids or ()}
        is_target = SERVICE_UUID.lower() in uuids or (adv.local_name or "") == args.name
        hit = hit or is_target
        mark = "->" if is_target else "  "
        print(f"{mark} {device.address}  {adv.rssi:>4} dBm  {adv.local_name or device.name or '(unnamed)'}")

    print()
    print("ESP32 found" if hit else "ESP32 NOT found -- is it powered and advertising?")
    return 0 if hit else 2


async def _plain(args) -> int:
    writer = None
    handle = None
    if args.csv:
        handle = args.csv.open("w", newline="")
        writer = csv.writer(handle)
        writer.writerow(csv_header())

    state = {"printed": 0}

    def emit(event: object) -> None:
        if isinstance(event, LogEvent):
            stamp = datetime.fromtimestamp(event.at).strftime("%H:%M:%S")
            print(f"{stamp} [{event.level}] {event.text}", flush=True)
        elif isinstance(event, StateEvent):
            print(f"         [state] {event.state.value}{' ' + event.detail if event.detail else ''}", flush=True)
        elif isinstance(event, DeviceEvent) and event.is_target:
            print(f"         [scan] {event.address} {event.rssi} dBm {event.name}", flush=True)
        elif isinstance(event, SampleEvent):
            sample = event.sample
            if writer is not None:
                writer.writerow(csv_row(time.time(), sample))
            state["printed"] += 1
            if state["printed"] % max(1, args.every) == 0:
                print(
                    f"t={sample.t_s:10.6f}s idx={sample.idx:<8d} "
                    f"g=({sample.gx:9.3f},{sample.gy:9.3f},{sample.gz:9.3f}) "
                    f"a=({sample.ax:6.3f},{sample.ay:6.3f},{sample.az:6.3f}) "
                    f"q=({sample.qw:6.3f},{sample.qx:6.3f},{sample.qy:6.3f},{sample.qz:6.3f}) "
                    f"{link.stats.rate_hz:5.1f}Hz miss={link.stats.missed}",
                    flush=True,
                )

    link = SensorLink(
        emit,
        address=args.address,
        name=args.name,
        adapter=args.adapter,
        scan_timeout=args.scan_timeout,
        reconnect=not args.no_reconnect,
    )
    try:
        await link.run()
    except KeyboardInterrupt:
        pass
    finally:
        if handle is not None:
            handle.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
