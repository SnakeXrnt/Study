"""Headless check that the TUI wires up and renders real decoded samples."""

import asyncio

from ble_rx.demo import DemoLink
from ble_rx.link import State
from ble_rx.tui import ReceiverApp


def _render(app: ReceiverApp, widget_id: str) -> str:
    from rich.console import Console

    console = Console(width=100, no_color=True)
    with console.capture() as capture:
        console.print(getattr(app, f"_{widget_id}_panel")())
    return capture.get()


async def _drive() -> tuple[str, str, str]:
    # A slow demo rate keeps Textual's message pump idle enough to settle.
    app = ReceiverApp(link_factory=DemoLink, rate_hz=5.0)
    async with app.run_test() as pilot:
        del pilot
        # Demo link needs ~0.7s of scripted delay before it starts streaming.
        for _ in range(60):
            await asyncio.sleep(0.05)
            if app._sample is not None and app._sample.idx > 3:
                break
        assert app._sample is not None, "no sample reached the app"
        assert app._state is State.STREAMING, f"state stuck at {app._state}"
        return _render(app, "status"), _render(app, "values"), _render(app, "counters")


def test_tui_renders_live_values():
    status, values, counters = asyncio.run(_drive())

    assert "STREAMING" in status
    assert "AA:BB:CC:DD:EE:FF" in status
    assert "247" in status  # MTU row

    assert "SENSOR OUTPUT" in values
    assert "idx" in values
    assert "1.000" in values  # az and qw

    assert "THROUGHPUT" in counters
    assert "Hz" in counters
