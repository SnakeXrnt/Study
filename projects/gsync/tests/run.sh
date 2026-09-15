#!/usr/bin/env bash
# gsync test suite: throwaway repos, local bare remotes and a fake AI.
# Usage: tests/run.sh

ROOT=$(cd "$(dirname "$0")/.." && pwd)
GSYNC=$ROOT/gsync
T=$(mktemp -d "${TMPDIR:-/tmp}/gsync-test.XXXXXX")
trap 'rm -rf "$T"' EXIT

export GIT_CONFIG_GLOBAL=$T/gitconfig GIT_CONFIG_NOSYSTEM=1
git config --global user.name "gsync test"
git config --global user.email test@example.com
git config --global init.defaultBranch main
git config --global protocol.file.allow always
git config --global advice.detachedHead false
export GSYNC_CONFIG=$T/config GSYNC_STATE_DIR=$T/state GSYNC_NO_NOTIFY=1

cat >"$T/fake-ai" <<'EOF'
#!/usr/bin/env bash
[ -n "$FAKE_AI_ARGS" ] && printf '%s\n' "$@" >"$FAKE_AI_ARGS"
echo '{"type":"agent_event"}'
echo 'not json at all'
case ${FAKE_AI:-good} in
good) echo '{"type":"run_result","text":"feat(app): add greeting module\n\n- print hello on start"}' ;;
fenced) echo '{"type":"run_result","text":"```\nfix(app): handle empty input\n```"}' ;;
bad) echo '{"type":"run_result","text":"Here is your commit message: Added stuff."}' ;;
long) echo '{"type":"run_result","text":"feat(app): this summary line is far too long to be accepted by the validator ok"}' ;;
fail) exit 1 ;;
slow) sleep 30 ;;
esac
EOF
chmod +x "$T/fake-ai"

PASS=0
FAIL=0
CURRENT=

pass() { PASS=$((PASS + 1)); }
fail() {
	FAIL=$((FAIL + 1))
	printf '  FAIL [%s] %s\n' "$CURRENT" "$*"
}
check() { # check DESCRIPTION CMD...
	local d=$1
	shift
	if "$@"; then pass; else fail "$d"; fi
}
eq() { [ "$1" = "$2" ] || { printf '    expected: %s\n    actual:   %s\n' "$2" "$1"; return 1; }; }

write_config() {
	cat >"$GSYNC_CONFIG" <<EOF
REPOS="$T/clone"
IDLE_MINUTES=10
AI_CMD="$T/fake-ai"
AI_TIMEOUT=3
EOF
}

# Fresh remote, a working clone and a second "device" clone.
setup() {
	CURRENT=$1
	cd "$T" || exit 1
	rm -rf "$T/remote.git" "$T/clone" "$T/other" "$T/state"
	git init -q --bare "$T/remote.git"
	git clone -q "$T/remote.git" "$T/clone" 2>/dev/null
	(cd "$T/clone" && echo seed >README.md && git add README.md &&
		git commit -qm "init" && git push -q origin main 2>/dev/null)
	git clone -q "$T/remote.git" "$T/other"
	write_config
	unset FAKE_AI FAKE_AI_ARGS
	cd "$T/clone" || exit 1
}

old() { touch -t 202001010000 "$@"; }
gs() { "$GSYNC" "$@" >/dev/null 2>&1; }
remote_head() { git --git-dir="$T/remote.git" rev-parse main; }
remote_subject() { git --git-dir="$T/remote.git" log -1 --format=%s main; }
count_commits() { git rev-list --count HEAD; }
is_clean() { [ -z "$(git status --porcelain)" ]; }

# ---------------------------------------------------------------------------

setup "AI message is used and pushed"
mkdir app && echo 'print("hi")' >app/greet.py
gs
check "exit code" [ $? -eq 0 ] 2>/dev/null
check "subject" eq "$(remote_subject)" "feat(app): add greeting module"
check "body kept" eq "$(git log -1 --format=%b | sed -n 1p)" "- print hello on start"
check "device trailer" eq "$(git log -1 --format=%b | grep '^Device:')" "Device: $(uname -n | sed 's/\..*//')"
check "pushed" eq "$(remote_head)" "$(git rev-parse HEAD)"
check "tree clean" is_clean

setup "exit code on success"
echo x >file.txt
"$GSYNC" >/dev/null 2>&1
check "exit 0" eq "$?" "0"

setup "changes are grouped by scope"
mkdir -p projects/a/src projects/b notes
echo 1 >projects/a/src/main.c
echo 2 >projects/a/Makefile
echo 3 >projects/b/x.py
echo 4 >notes/n.md
echo 5 >top.txt
FAKE_AI=fail gs
check "4 new commits" eq "$(count_commits)" "5"
subjects=$(git log --format=%s -4 | sed 's/ sync .*//' | LC_ALL=C sort | tr '\n' ' ')
check "scopes" eq "$subjects" "chore(a): chore(b): chore(notes): chore: "
check "a/ grouped together" eq "$(git show --name-only --format= HEAD~4 HEAD~3 HEAD~2 HEAD~1 HEAD | grep -c projects/a)" "2"

setup "--idle skips fresh changes"
echo fresh >fresh.txt
gs --idle
check "no commit" eq "$(count_commits)" "1"
old fresh.txt
gs --idle
check "committed when idle" eq "$(count_commits)" "2"

setup "--idle waits if any changed file is fresh"
echo a >a.txt
echo b >b.txt
old a.txt
gs --idle
check "no commit" eq "$(count_commits)" "1"

setup "invalid AI message falls back"
echo x >file.txt
FAKE_AI=bad gs
check "fallback subject" eq "$(git log -1 --format=%s | grep -Ec '^chore: sync [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2} from ')" "1"

setup "too long AI summary falls back"
mkdir app && echo x >app/f
FAKE_AI=long gs
check "fallback" eq "$(git log -1 --format=%s | grep -c '^chore(app): sync ')" "1"

setup "code fences are stripped"
mkdir app && echo x >app/f
FAKE_AI=fenced gs
check "subject" eq "$(git log -1 --format=%s)" "fix(app): handle empty input"

setup "AI failure falls back"
echo x >file.txt
FAKE_AI=fail gs
check "fallback" eq "$(git log -1 --format=%s | grep -c '^chore: sync ')" "1"

setup "AI disabled falls back"
echo 'AI_CMD=""' >>"$GSYNC_CONFIG"
echo x >file.txt
gs
check "fallback" eq "$(git log -1 --format=%s | grep -c '^chore: sync ')" "1"

setup "slow AI times out"
echo x >file.txt
start=$(date +%s)
FAKE_AI=slow gs
check "finished quickly" [ $(($(date +%s) - start)) -lt 15 ]
check "fallback" eq "$(git log -1 --format=%s | grep -c '^chore: sync ')" "1"

setup "AI receives scope and diff"
mkdir -p projects/esp32 && echo 'int main(void) {}' >projects/esp32/main.c
FAKE_AI_ARGS=$T/args gs
check "scope in input" grep -q 'Suggested scope: esp32' "$T/args"
check "diff in input" grep -q '+int main(void) {}' "$T/args"
check "no auto approve" grep -qx 'false' "$T/args"

setup "remote changes are rebased in"
(cd "$T/other" && echo remote >remote.txt && git add . && git commit -qm "remote" && git push -q 2>/dev/null)
echo local >local.txt
FAKE_AI=fail gs
check "has remote file" [ -f remote.txt ]
check "pushed on top" eq "$(remote_head)" "$(git rev-parse HEAD)"
check "linear" eq "$(git rev-list --merges --count HEAD)" "0"

setup "pull when nothing to commit"
(cd "$T/other" && echo remote >remote.txt && git add . && git commit -qm "remote" && git push -q 2>/dev/null)
gs
check "has remote file" [ -f remote.txt ]

setup "rebase conflict aborts cleanly"
(cd "$T/other" && echo theirs >README.md && git commit -qam "theirs" && git push -q 2>/dev/null)
echo mine >README.md
FAKE_AI=fail "$GSYNC" >/dev/null 2>&1
rc=$?
check "non-zero exit" [ "$rc" -ne 0 ]
check "no rebase in progress" [ ! -d .git/rebase-merge ]
check "local commit kept" eq "$(cat README.md)" "mine"
check "committed locally" eq "$(count_commits)" "2"
check "remote untouched" eq "$(remote_subject)" "theirs"
check "notified" grep -q 'NOTIFY: clone: conflict' "$T/state/gsync.log"

setup "offline push keeps commits and retries"
mv "$T/remote.git" "$T/remote.bak"
echo x >file.txt
FAKE_AI=fail "$GSYNC" >/dev/null 2>&1
check "exit 0 when offline" eq "$?" "0"
check "committed" eq "$(count_commits)" "2"
mv "$T/remote.bak" "$T/remote.git"
gs
check "pushed later" eq "$(remote_head)" "$(git rev-parse HEAD)"

setup "dry run changes nothing"
echo x >file.txt
out=$("$GSYNC" -n 2>/dev/null)
check "no commit" eq "$(count_commits)" "1"
check "still dirty" [ -n "$(git status --porcelain)" ]
check "prints plan" eq "$(printf '%s\n' "$out" | sed -n 1p)" "clone: would commit [root]"

setup "deletions and renames"
mkdir -p d && echo 1 >d/a && echo 2 >d/b && echo 3 >d/c
git add . && git commit -qm "files"
git mv d/a d/a2
git rm -q d/b
rm d/c
FAKE_AI=fail gs
check "tree clean" is_clean
check "files gone" eq "$(git ls-files d | tr '\n' ' ')" "d/a2 "

setup "pre-staged files of other groups are committed in their own group"
mkdir x y && echo 1 >x/f && echo 2 >y/f
git add x/f
FAKE_AI=fail gs
check "two commits" eq "$(count_commits)" "3"
check "x alone" eq "$(git show --name-only --format= HEAD~1)" "x/f"

setup "submodules and nested repos are left alone"
git init -q --bare "$T/sub.git"
git clone -q "$T/sub.git" "$T/subwork" 2>/dev/null
(cd "$T/subwork" && echo s >s && git add s && git commit -qm s && git push -q origin main 2>/dev/null)
git submodule -q add "$T/sub.git" lib/sub 2>/dev/null
git commit -qm "add submodule"
(cd lib/sub && echo change >s && git commit -qam change)
echo dirty >lib/sub/untracked
mkdir nested && (cd nested && git init -q && echo n >n)
FAKE_AI=fail gs
check "no commit" eq "$(count_commits)" "2"
check "submodule still modified" [ -n "$(git status --porcelain lib/sub)" ]
check "nested not added" eq "$(git ls-files nested)" ""
rm -rf "$T/sub.git" "$T/subwork"

setup "new branch without upstream is pushed"
git checkout -qb feature
echo x >file.txt
FAKE_AI=fail gs
check "remote branch exists" git --git-dir="$T/remote.git" rev-parse -q --verify feature
check "upstream set" eq "$(git rev-parse --abbrev-ref '@{u}')" "origin/feature"

setup "detached HEAD is skipped"
git checkout -q --detach
echo x >file.txt
FAKE_AI=fail "$GSYNC" >/dev/null 2>&1
check "non-zero exit" [ $? -ne 0 ]
check "no commit" eq "$(count_commits)" "1"

setup "held lock skips repo"
mkdir .git/gsync.lock
echo x >file.txt
FAKE_AI=fail gs
check "no commit" eq "$(count_commits)" "1"
check "lock untouched" [ -d .git/gsync.lock ]

setup "lock is released"
echo x >file.txt
FAKE_AI=fail gs
check "no lock left" [ ! -d .git/gsync.lock ]

setup "missing repo is skipped"
echo "REPOS=\"$T/does-not-exist $T/clone\"" >>"$GSYNC_CONFIG"
echo x >file.txt
FAKE_AI=fail "$GSYNC" >/dev/null 2>&1
check "exit 0" eq "$?" "0"
check "other repo synced" eq "$(count_commits)" "2"

setup "paths with spaces and glob characters"
mkdir "my dir" && echo 1 >"my dir/[a].txt" && echo 2 >"my dir/a.txt"
FAKE_AI=fail gs
check "tree clean" is_clean

printf '\n%d passed, %d failed\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ]
