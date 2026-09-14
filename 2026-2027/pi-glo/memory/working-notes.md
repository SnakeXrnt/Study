# Working notes

Environment gotchas and lessons that cost time once already.

## Password prompts do not work through Claude Code

Commands that prompt interactively (`ssh-copy-id`, `ssh` with password auth,
`sudo` without NOPASSWD) fail through the Bash tool **and** through the user's
`!` prefix. Neither gets a TTY, so the command receives empty input and burns
every retry attempt instantly.

This looks **exactly** like a wrong password. It sent an early debugging session
down the wrong path entirely — the user was asked to check their keyboard layout
when the real problem was the missing terminal.

**If a credential command fails instantly on the first attempt, suspect the
missing TTY before suspecting the credential.** Ask the user to run it in a real
terminal, or find a non-interactive route — appending a public key to
`~/.ssh/authorized_keys` directly on the target, for instance.

## Verify on the real hardware

A browser on a laptop pointed at the Pi tests the *laptop's* GPU. The frame-rate
problem was invisible that way and only appeared in a `grim` screenshot taken on
the Pi itself. Same principle throughout: the Pi is the target, so measure there.

Two follow-ons learned the hard way on 2026-09-11:

**Measure the thing you are actually changing.** Antialiasing and the drawing
buffer were both ruled out by watching CPU, which was the wrong metric: the cost
was per-frame presentation, and it only showed up once frame *time* was measured.
Both were later confirmed irrelevant anyway, but for a while the wrong metric
pointed at the wrong conclusion.

**Instantaneous `top` samples are too noisy to compare against.** Differences of
15 points between samples were routine. Accumulating CPU time over a fixed window
made the real differences obvious and the false ones disappear.

## Read the code before designing around it

Three assumptions carried into early design work were all wrong, and reading
`sense-6madgwick` disproved them:

- Seven IMUs (actually six).
- Raw accel/gyro on the wire (actually fused, calibrated quaternions).
- `loc` as measured position (actually a per-finger constant).

A data contract had already been written on those assumptions and had to be
rewritten. **Read the firmware before specifying anything that talks to it.**

## Small things that cost time

- `pkill`, `grep` and similar return non-zero when they match nothing, which
  reads as a failed command in a chain. Not always an error.
- String replacement in patch scripts fails **silently** if the anchor does not
  match. One patch was written with `—` where the file held a literal em
  dash, so it never applied and the old code shipped. **Assert the anchor exists.**
- SSE clients receive the last published frame first, which may predate a POST
  you just made. Skip the first frame when testing overlay delivery, or it looks
  like the overlay never arrived.
- **A browser will serve a stale page after a redeploy.** `server.py` sent no
  cache headers, only a Last-Modified date, so Firefox applied heuristic
  freshness and kept an old `index.html`. That silently invalidated a whole round
  of performance measurements: the page under test was not the page deployed. It
  now sends `no-store` on everything.
- Blender's `-o` must precede `-f` or the output path is silently ignored.

## Conventions in this project

**Do not invent data.** Where a value is genuinely absent, say so. The UI shows
"not sent by this firmware" rather than a plausible-looking zero. A demo that
fabricates numbers is worse than one that admits gaps.

**Keep the collaborator's repo clean.** Ethan's work lives outside
`Saxion-SSP/`. Edits inside it land on a shared branch; make them deliberately
and tell him so he can commit them.

**Prefer stdlib on the Pi.** Every dependency is one more thing to install on a
machine that has to work at a venue. SSE instead of websockets, apt instead of
pip, vendored assets instead of a CDN.

**Date every claim, and separate measured from assumed.** Several notes here
exist because an earlier guess was recorded as if it were a fact.
