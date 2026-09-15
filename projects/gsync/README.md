# gsync

Never forget to push again. `gsync` commits and pushes your git repos
automatically, with professional [Conventional Commit](https://www.conventionalcommits.org/)
messages written by an AI ([Cline CLI](https://cline.bot), free DeepSeek model).

```
feat(esp32c3-ble): add idle client timeout check

- Add link module with IDLE_TIMEOUT_S constant (15s)
- Disconnect clients idle longer than the timeout via check_idle

Device: 1770np
```

## How it works

For every repo in your config:

1. **Commit**: changes are grouped by folder (`projects/esp32c3-ble`,
   `2026-2027/calculus-a`, ...) and each group gets its own commit. Cline writes
   the message from the diff; if Cline is missing, slow, or answers nonsense, a
   fallback like `chore(calculus-a): sync 2026-09-15 14:02 from 1770np` is used.
2. **Rebase** onto the remote so work from your other devices comes in.
3. **Push**. Offline? Commits stay local and go out on the next run.

It runs:

| When | Arch Linux | macOS |
|---|---|---|
| Every 15 min, if files untouched for 10 min | systemd user timer | launchd agent |
| Before suspend / sleep | system sleep unit | sleepwatcher |
| On shutdown / logout | user service | not available |
| Whenever you want | `gsync` | `gsync` |

It never force-pushes, never touches submodules, and stops with a desktop
notification if there is a conflict it can't solve.

## Install

Requirements: `git`, `jq`, and optionally `cline` (logged in).

```sh
cd ~/study/projects/gsync
./install.sh            # asks for sudo once on Linux for the suspend hook
gsync --dry-run         # see what it would do
```

macOS extras:

```sh
brew install jq sleepwatcher
npm install -g cline    # then log in once by running: cline
./install.sh
```

Uninstall with `./install.sh --uninstall` (your config is kept).

## Usage

```
gsync            commit + rebase + push everything now
gsync --idle     only commit repos untouched for IDLE_MINUTES (timer uses this)
gsync --fast     cap the AI at 20 s (suspend/shutdown use this)
gsync -n         dry run
```

Logs: `~/.local/state/gsync/gsync.log`

## Config

`~/.config/gsync/config` (created by `install.sh` from `config.example`):

```sh
REPOS="$HOME/study $HOME/study/work"
IDLE_MINUTES=10
AI_CMD="cline"       # "" = never use AI
AI_TIMEOUT=60
```

## Multiple devices (and Syncthing)

Let git do the syncing. **Remove repos managed by gsync from Syncthing**: Syncthing
copying `.git/` while git writes to it is what causes the conflicts. Clone the repo
on each device instead and run `./install.sh` there; every device pulls and pushes
on its own.

Avoid editing the same lines on two devices between syncs. If it happens, gsync
keeps your local commits, notifies you, and you fix it with `git pull --rebase`.

## Troubleshooting

- **Push fails from the timer but works in the terminal**: the service has no
  SSH agent. Use a key without passphrase for GitHub, or add
  `export SSH_AUTH_SOCK=...` to the config (macOS: add `UseKeychain yes` and
  `AddKeysToAgent yes` to `~/.ssh/config`).
- **Always fallback messages**: check `cline` and `jq` are on the `PATH` line in the
  config, and that `cline "hi"` works.
- **Privacy**: diffs are sent to the AI provider. Set `AI_CMD=""` for repos you
  don't want to share, or run a separate config via `GSYNC_CONFIG`.

## Development

```sh
tests/run.sh
```

Design: [docs/spec.md](docs/spec.md)
