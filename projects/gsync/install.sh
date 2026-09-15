#!/usr/bin/env bash
# Install (or uninstall) gsync for the current user.
#   Arch/systemd: user timer + shutdown service, system sleep unit (sudo)
#   macOS:        launchd agent + sleepwatcher hook
#
# Usage: ./install.sh [--no-sudo] [--uninstall]

set -e

DIR=$(cd "$(dirname "$0")" && pwd)
BIN=$HOME/.local/bin
CONF_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/gsync
STATE_DIR=${XDG_STATE_HOME:-$HOME/.local/state}/gsync
UNIT_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user
SLEEP_UNIT=/etc/systemd/system/gsync-sleep.service
PLIST=$HOME/Library/LaunchAgents/com.gsync.agent.plist
SLEEP_HOOK_LINE="\"$BIN/gsync\" --fast # gsync"

NO_SUDO=
UNINSTALL=
for arg in "$@"; do
	case $arg in
	--no-sudo) NO_SUDO=1 ;;
	--uninstall) UNINSTALL=1 ;;
	-h | --help)
		sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'
		exit 0
		;;
	*)
		echo "unknown option: $arg" >&2
		exit 2
		;;
	esac
done

say() { printf '==> %s\n' "$*"; }
warn() { printf 'warning: %s\n' "$*" >&2; }

subst() {
	sed -e "s|@HOME@|$HOME|g" -e "s|@USER@|$(id -un)|g" -e "s|@UID@|$(id -u)|g" "$1"
}

install_common() {
	mkdir -p "$BIN" "$CONF_DIR" "$STATE_DIR"
	chmod +x "$DIR/gsync"
	ln -sf "$DIR/gsync" "$BIN/gsync"
	say "linked $BIN/gsync"

	for dep in git jq cline; do
		command -v "$dep" >/dev/null 2>&1 || warn "$dep not found (cline/jq missing = fallback commit messages)"
	done

	if [ -f "$CONF_DIR/config" ]; then
		say "keeping existing $CONF_DIR/config"
	else
		{
			cat "$DIR/config.example"
			printf '\n# Captured by install.sh so timers and services find git, jq and cline.\n'
			printf 'export PATH=%q\n' "$PATH"
			case $SSH_AUTH_SOCK in
			"$XDG_RUNTIME_DIR"/*) printf 'export SSH_AUTH_SOCK=%q\n' "$SSH_AUTH_SOCK" ;;
			esac
		} >"$CONF_DIR/config"
		say "wrote $CONF_DIR/config (edit REPOS there)"
	fi
}

install_linux() {
	mkdir -p "$UNIT_DIR"
	cp "$DIR/linux/gsync.service" "$DIR/linux/gsync.timer" "$DIR/linux/gsync-shutdown.service" "$UNIT_DIR/"
	systemctl --user daemon-reload
	systemctl --user enable --now gsync.timer gsync-shutdown.service
	say "enabled gsync.timer and gsync-shutdown.service"

	if [ -n "$NO_SUDO" ]; then
		warn "skipping suspend hook (--no-sudo)"
		return
	fi
	subst "$DIR/linux/gsync-sleep.service.in" | sudo tee "$SLEEP_UNIT" >/dev/null
	sudo systemctl daemon-reload
	sudo systemctl enable gsync-sleep.service
	say "enabled $SLEEP_UNIT"
}

uninstall_linux() {
	systemctl --user disable --now gsync.timer 2>/dev/null || true
	# Stopping the shutdown service would run a sync; remove it quietly.
	systemctl --user disable gsync-shutdown.service 2>/dev/null || true
	rm -f "$UNIT_DIR/gsync.service" "$UNIT_DIR/gsync.timer" "$UNIT_DIR/gsync-shutdown.service"
	systemctl --user daemon-reload
	if [ -z "$NO_SUDO" ] && [ -f "$SLEEP_UNIT" ]; then
		sudo systemctl disable gsync-sleep.service || true
		sudo rm -f "$SLEEP_UNIT"
		sudo systemctl daemon-reload
	fi
}

install_macos() {
	mkdir -p "$(dirname "$PLIST")"
	subst "$DIR/macos/com.gsync.agent.plist.in" >"$PLIST"
	launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true
	launchctl bootstrap "gui/$(id -u)" "$PLIST"
	say "loaded launchd agent $PLIST"

	if ! command -v sleepwatcher >/dev/null 2>&1; then
		warn "sleepwatcher not installed: run 'brew install sleepwatcher' and re-run ./install.sh for the sleep hook"
		return
	fi
	touch "$HOME/.sleep"
	grep -qF "# gsync" "$HOME/.sleep" || printf '%s\n' "$SLEEP_HOOK_LINE" >>"$HOME/.sleep"
	chmod +x "$HOME/.sleep"
	brew services restart sleepwatcher >/dev/null
	say "sleepwatcher runs gsync before sleep (~/.sleep)"
}

uninstall_macos() {
	launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true
	rm -f "$PLIST"
	if [ -f "$HOME/.sleep" ]; then
		grep -vF "# gsync" "$HOME/.sleep" >"$HOME/.sleep.tmp" || true
		mv "$HOME/.sleep.tmp" "$HOME/.sleep"
		chmod +x "$HOME/.sleep"
	fi
}

case $(uname -s) in
Darwin) OS=macos ;;
Linux) OS=linux ;;
*)
	echo "unsupported OS: $(uname -s)" >&2
	exit 1
	;;
esac

if [ -n "$UNINSTALL" ]; then
	"uninstall_$OS"
	rm -f "$BIN/gsync"
	say "uninstalled (config kept in $CONF_DIR)"
	exit 0
fi

install_common
"install_$OS"
say "done. Try: gsync --dry-run"
