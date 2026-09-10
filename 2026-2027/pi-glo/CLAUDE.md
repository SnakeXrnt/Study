# pi-glo

A sensor glove that drives a computer, for a Saxion open-day showcase. Runs
self-contained on one Raspberry Pi.

## Read this first

**`memory/` is the knowledge base for this project.** Start with
`memory/README.md`, then `memory/open-items.md` before doing any work — it lists
known bugs, untested paths and unfinished business that will otherwise waste
your time.

Load the rest on demand: `project.md`, `hardware.md`, `protocols.md`,
`visualiser.md`, `pi-deployment.md`, `working-notes.md`.

## Things to know immediately

**`Saxion-SSP/` is a separate git repository**, cloned inside this folder, on the
shared branch `openday`. This folder itself is not a repo. Edits inside
`Saxion-SSP/` land on a branch a teammate also works on — make them deliberately
and say so.

**Password prompts do not work through the Bash tool or the `!` prefix.** No TTY,
so they fail instantly with empty input, which looks exactly like a wrong
password. Hand such commands to the user's own terminal.

**The Pi is the target, so measure on the Pi.** Testing the UI in a laptop
browser tests the laptop's GPU and hides real performance problems.

**Do not invent data.** Where a value is genuinely absent, the UI says so rather
than showing a plausible zero. Preserve that.

## Layout

```
docs/      protocol and deployment reference (more depth than memory/)
memory/    durable knowledge: decisions, measured facts, current state
web/       the visualiser — server.py, glove_ble.py, static/
Saxion-SSP/  the team repo (separate checkout)
```

Where sources disagree, the code wins, then `docs/`, then `memory/`.
