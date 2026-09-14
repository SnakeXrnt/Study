"""Textual frontend: diagnostics on the left, live sensor values on the right."""

from __future__ import annotations

import asyncio
import csv
import time
from datetime import datetime
from pathlib import Path

from rich.table import Table
from rich.text import Text
from textual.app import App, ComposeResult
from textual.containers import Horizontal, Vertical
from textual.widgets import Footer, Header, RichLog, Static

from .link import DeviceEvent, LogEvent, SampleEvent, SensorLink, State, StateEvent
from .protocol import DATA_CHAR_UUID, SERVICE_UUID, SensorSample, csv_header, csv_row

_LEVEL_STYLE = {"info": "dim", "good": "green", "warn": "yellow", "error": "bold red"}

_STATE_STYLE = {
    State.STREAMING: "bold green",
    State.FOUND: "green",
    State.CONNECTING: "yellow",
    State.DISCOVERING: "yellow",
    State.SUBSCRIBING: "yellow",
    State.SCANNING: "cyan",
    State.DISCONNECTED: "red",
    State.ERROR: "bold red",
    State.IDLE: "dim",
}


class ReceiverApp(App):
    """Live view of one ESP32-C3 BLE sensor peripheral."""

    TITLE = "ESP32-C3 BLE receiver"

    CSS = """
    Screen { layout: vertical; }
    #top { height: 1fr; }
    #left { width: 1fr; }
    #right { width: 1fr; }
    .panel {
        border: round $primary;
        padding: 0 1;
        height: 1fr;
    }
    #log { border: round $accent; height: 12; padding: 0 1; }
    """

    BINDINGS = [
        ("q", "quit", "Quit"),
        ("r", "rescan", "Rescan"),
        ("l", "toggle_log", "CSV log"),
        ("c", "clear", "Clear log"),
    ]

    def __init__(self, link_factory=SensorLink, **link_kwargs) -> None:
        super().__init__()
        self._link_factory = link_factory
        self._link_kwargs = link_kwargs
        # Note: not _task / _name -- Textual's App already uses those names
        # for its message-loop task and DOM node name.
        self._link: SensorLink | None = None
        self._link_task: asyncio.Task | None = None

        self._state = State.IDLE
        self._detail = ""
        self._address = ""
        self._device_name = ""
        self._rssi = 0
        self._devices: dict[str, DeviceEvent] = {}
        self._sample: SensorSample | None = None
        self._last_at = 0.0

        self._csv_path: Path | None = None
        self._csv_file = None
        self._csv_writer = None
        self._csv_rows = 0

    # -- layout ------------------------------------------------------------

    def compose(self) -> ComposeResult:
        yield Header(show_clock=True)
        with Horizontal(id="top"):
            with Vertical(id="left"):
                yield Static(id="status", classes="panel")
                yield Static(id="devices", classes="panel")
            with Vertical(id="right"):
                yield Static(id="values", classes="panel")
                yield Static(id="counters", classes="panel")
        yield RichLog(id="log", markup=False, wrap=True)
        yield Footer()

    def on_mount(self) -> None:
        self.query_one("#log", RichLog).write("press r to rescan, l to log to CSV, q to quit")
        self._start_link()
        self.set_interval(0.1, self._render)

    # -- link plumbing -----------------------------------------------------

    def _start_link(self) -> None:
        if self._link_task and not self._link_task.done():
            self._link_task.cancel()
        if self._link:
            self._link.stop()
        self._devices.clear()
        self._link = self._link_factory(self._on_event, **self._link_kwargs)
        self._link_task = asyncio.create_task(self._link.run())

    def _on_event(self, event: object) -> None:
        # bleak dispatches its callbacks on this same asyncio loop, so the UI
        # can be touched directly.
        self._apply(event)

    def _apply(self, event: object) -> None:
        if isinstance(event, LogEvent):
            stamp = datetime.fromtimestamp(event.at).strftime("%H:%M:%S")
            style = _LEVEL_STYLE.get(event.level, "")
            self.query_one("#log", RichLog).write(
                Text.assemble((f"{stamp} ", "dim"), (event.text, style))
            )
        elif isinstance(event, StateEvent):
            self._state = event.state
            self._detail = event.detail
            if event.state is State.FOUND and event.detail:
                self._address = event.detail
        elif isinstance(event, DeviceEvent):
            self._devices[event.address] = event
            if event.is_target:
                self._address = event.address
                self._device_name = event.name
                self._rssi = event.rssi
        elif isinstance(event, SampleEvent):
            self._sample = event.sample
            self._last_at = event.at
            self._write_csv(event.sample)

    # -- actions -----------------------------------------------------------

    def action_rescan(self) -> None:
        self.query_one("#log", RichLog).write(Text("restarting scan", "cyan"))
        self._start_link()

    def action_clear(self) -> None:
        self.query_one("#log", RichLog).clear()

    def action_toggle_log(self) -> None:
        log = self.query_one("#log", RichLog)
        if self._csv_file is not None:
            self._close_csv()
            log.write(Text(f"CSV closed ({self._csv_rows} rows)", "yellow"))
            return
        self._csv_path = Path(f"sensor-{datetime.now():%Y%m%d-%H%M%S}.csv")
        self._csv_file = self._csv_path.open("w", newline="")
        self._csv_writer = csv.writer(self._csv_file)
        self._csv_writer.writerow(csv_header())
        self._csv_rows = 0
        log.write(Text(f"CSV logging to {self._csv_path}", "green"))

    def _write_csv(self, sample: SensorSample) -> None:
        if self._csv_writer is None:
            return
        self._csv_writer.writerow(csv_row(time.time(), sample))
        self._csv_rows += 1

    def _close_csv(self) -> None:
        if self._csv_file is not None:
            self._csv_file.close()
        self._csv_file = None
        self._csv_writer = None

    async def on_unmount(self) -> None:
        self._close_csv()
        if self._link:
            self._link.stop()
        if self._link_task:
            self._link_task.cancel()

    # -- rendering ---------------------------------------------------------

    def _render(self) -> None:
        self.query_one("#status", Static).update(self._status_panel())
        self.query_one("#devices", Static).update(self._devices_panel())
        self.query_one("#values", Static).update(self._values_panel())
        self.query_one("#counters", Static).update(self._counters_panel())

    def _status_panel(self) -> Table:
        stats = self._link.stats if self._link else None
        table = Table.grid(padding=(0, 2))
        table.add_column(style="dim", justify="right")
        table.add_column()

        table.add_row("", Text("DIAGNOSTICS", "bold"))
        table.add_row(
            "state",
            Text(self._state.value.upper(), _STATE_STYLE.get(self._state, "")),
        )
        if self._detail:
            table.add_row("detail", Text(self._detail, "dim"))
        table.add_row("device", self._device_name or "-")
        table.add_row("address", self._address or "-")
        table.add_row("rssi", f"{self._rssi} dBm" if self._rssi else "-")
        table.add_row("service", SERVICE_UUID)
        table.add_row("characteristic", DATA_CHAR_UUID)
        if stats:
            table.add_row("att mtu", str(stats.mtu) if stats.mtu else "-")
            if stats.connected_at:
                table.add_row("connected", f"{time.time() - stats.connected_at:.0f}s ago")
        return table

    def _devices_panel(self) -> Table:
        table = Table.grid(padding=(0, 2))
        table.add_column(style="dim", justify="right")
        table.add_column()
        table.add_row("", Text(f"SCAN ({len(self._devices)} seen)", "bold"))
        if not self._devices:
            table.add_row("", Text("nothing yet", "dim"))
            return table
        ordered = sorted(self._devices.values(), key=lambda d: (not d.is_target, -d.rssi))
        for device in ordered[:12]:
            marker = Text("-> ", "bold green") if device.is_target else Text("   ", "dim")
            label = Text(device.name, "green" if device.is_target else "")
            table.add_row(f"{device.rssi} dBm", Text.assemble(marker, label, (f"  {device.address}", "dim")))
        return table

    def _values_panel(self) -> Table:
        table = Table.grid(padding=(0, 2))
        table.add_column(style="dim", justify="right")
        table.add_column(justify="right")
        table.add_column(justify="right")
        table.add_column(justify="right")
        table.add_column(justify="right")

        table.add_row("", Text("SENSOR OUTPUT", "bold"), "", "", "")
        sample = self._sample
        if sample is None:
            table.add_row("", Text("waiting for data", "dim"), "", "", "")
            return table

        stale = time.monotonic() - self._last_at > 1.0
        style = "yellow" if stale else "bold white"
        table.add_row("t", Text(f"{sample.t_s:.6f} s", style), "", "", "")
        table.add_row("idx", Text(str(sample.idx), style), "", "", "")
        table.add_row("", "", "", "", "")
        table.add_row("", Text("x", "dim"), Text("y", "dim"), Text("z", "dim"), Text("w", "dim"))
        table.add_row("gyro", *(Text(f"{v:.3f}", style) for v in sample.gyro), "")
        table.add_row("accel", *(Text(f"{v:.3f}", style) for v in sample.accel), "")
        qw, qx, qy, qz = sample.quat
        table.add_row(
            "quat",
            Text(f"{qx:.3f}", style),
            Text(f"{qy:.3f}", style),
            Text(f"{qz:.3f}", style),
            Text(f"{qw:.3f}", style),
        )
        if stale:
            table.add_row("", Text("(stale)", "yellow"), "", "", "")
        return table

    def _counters_panel(self) -> Table:
        table = Table.grid(padding=(0, 2))
        table.add_column(style="dim", justify="right")
        table.add_column()
        table.add_row("", Text("THROUGHPUT", "bold"))
        stats = self._link.stats if self._link else None
        if stats is None:
            return table
        table.add_row("packets", str(stats.received))
        table.add_row("rate", f"{stats.rate_hz:.1f} Hz")
        table.add_row(
            "missed",
            Text(str(stats.missed), "yellow" if stats.missed else "dim"),
        )
        table.add_row("malformed", Text(str(stats.bad), "red" if stats.bad else "dim"))
        if self._csv_file is not None:
            table.add_row("csv", Text(f"{self._csv_path} ({self._csv_rows})", "green"))
        else:
            table.add_row("csv", Text("off (press l)", "dim"))
        return table
