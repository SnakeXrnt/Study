# pi-glo knowledge base

Everything a fresh Claude session needs to be useful on this project without
re-deriving it. Written 2026-09-10, describing state verified 2026-09-06.

**Read `project.md` first.** The rest can be read on demand.

| File | What it covers |
|---|---|
| `project.md` | What is being built, who owns what, how the folders are arranged |
| `hardware.md` | The glove, the Nano, the Pi, and the measured limits of each |
| `protocols.md` | Every wire format: USB serial, BLE command, BLE telemetry |
| `visualiser.md` | The web app — architecture, endpoints, UI, design decisions |
| `pi-deployment.md` | Running on the Pi: access, services, kiosk, performance |
| `open-items.md` | Unfinished work, known bugs, untested paths. **Check this early.** |
| `working-notes.md` | Environment gotchas and how to work effectively here |

## What is authoritative

This folder holds *durable knowledge* — decisions, rationale, measured facts,
and current state. The project's own documentation is the operational reference
and goes into more depth:

- `../README.md` — architecture overview
- `../docs/data-contract.md` — exhaustive protocol detail
- `../docs/pi-deploy.md` — deployment specifics
- `../web/README.md` — running and extending the visualiser

Where they disagree, **the code wins, then the project docs, then this folder.**
These notes are a snapshot; code is live.

## A caution on dates

Every claim here is dated. Anything marked "verified" was actually observed at
that time, not inferred. Before acting on a specific file path, flag or service
name, check it still exists — several months of drift will not announce itself.

As of 2026-09-10 the Pi was **not reachable** to re-verify. See `open-items.md`.
