#!/usr/bin/env bash
set -euo pipefail

SCRIPT="${SCRIPT:-$HOME/.config/zsh/scripts/firstmate-up.sh}"

ROOT="$(mktemp -d)"
trap 'rm -rf "$ROOT"' EXIT

STUB="$ROOT/bin"
mkdir -p "$STUB"

cat > "$STUB/gh" <<'STUB'
#!/usr/bin/env bash
exit 0
STUB

cat > "$STUB/git" <<'STUB'
#!/usr/bin/env bash
if [[ -n "${GIT_LOG:-}" ]]; then echo "$*" >> "$GIT_LOG"; fi
if [[ "${1:-}" == "clone" ]]; then
  dest="${!#}"
  mkdir -p "$dest/.opencode/plugins"
  printf 'distro\n' > "$dest/AGENTS.md"
  printf 'plugin\n' > "$dest/.opencode/plugins/x.js"
fi
exit 0
STUB

cat > "$STUB/opencode" <<'STUB'
#!/usr/bin/env bash
echo "$PWD" > "${OPENCODE_CWD:?}"
exit 0
STUB

cat > "$STUB/uname" <<'STUB'
#!/usr/bin/env bash
echo "${FAKE_UNAME:-Darwin}"
STUB

chmod +x "$STUB/gh" "$STUB/git" "$STUB/opencode" "$STUB/uname"

export PATH="$STUB:/usr/bin:/bin"

seed() {
  local fm="$1"
  mkdir -p "$fm/.git" "$fm/.opencode/plugins"
  printf 'distro\n' > "$fm/AGENTS.md"
  printf 'plugin\n' > "$fm/.opencode/plugins/x.js"
}

pass=0
fail=0
st=0

ok()   { echo "ok   - $1"; pass=$((pass + 1)); }
no()   { echo "FAIL - $1"; fail=$((fail + 1)); }

run_script() {
  set +e
  "$SCRIPT" "$@"
  st=$?
  set -e
}

# T1: fresh machine clones the distro and launches opencode inside FM_DIR.
fm="$ROOT/t1/fm"
export FM_DIR="$fm"
export GIT_LOG="$ROOT/t1-git.log" OPENCODE_CWD="$ROOT/t1-cwd"
: > "$GIT_LOG"
run_script
if grep -q "clone" "$GIT_LOG"; then cloned=0; else cloned=1; fi
if [[ $st -eq 0 && -f "$fm/AGENTS.md" && -d "$fm/.opencode/plugins" \
      && "$(<"$OPENCODE_CWD")" == "$fm" && $cloned -eq 0 ]]; then
  ok   "fresh machine: clones distro and launches opencode inside FM_DIR"
else
  no   "fresh machine: clones distro and launches opencode inside FM_DIR (exit $st)"
fi

# T2: existing dir skips the clone and launches opencode inside FM_DIR.
fm="$ROOT/t2/fm"
seed "$fm"
export FM_DIR="$fm"
export GIT_LOG="$ROOT/t2-git.log" OPENCODE_CWD="$ROOT/t2-cwd"
: > "$GIT_LOG"
run_script
if grep -q "clone" "$GIT_LOG"; then cloned=0; else cloned=1; fi
if [[ $st -eq 0 && "$(<"$OPENCODE_CWD")" == "$fm" && $cloned -ne 0 ]]; then
  ok   "existing dir: skips clone and launches opencode inside FM_DIR"
else
  no   "existing dir: skips clone and launches opencode inside FM_DIR (exit $st)"
fi

# T3: --update fast-forwards the existing clone before launch.
fm="$ROOT/t3/fm"
seed "$fm"
export FM_DIR="$fm"
export GIT_LOG="$ROOT/t3-git.log" OPENCODE_CWD="$ROOT/t3-cwd"
: > "$GIT_LOG"
run_script --update
if grep -q "pull --ff-only" "$GIT_LOG"; then updated=0; else updated=1; fi
if [[ $st -eq 0 && $updated -eq 0 ]]; then
  ok   "--update: fast-forwards the existing clone before launch"
else
  no   "--update: fast-forwards the existing clone before launch (exit $st)"
fi

# T4: unsupported OS refuses to run.
export FAKE_UNAME="Plan9"
export FM_DIR="$ROOT/t4/fm"
run_script
if [[ $st -ne 0 ]]; then
  ok   "unsupported OS: script refuses to run"
else
  no   "unsupported OS: script refused to fail (exit $st)"
fi

# T5: existing non-git, non-empty FM_DIR is refused with a clear abort.
unset FAKE_UNAME
fm="$ROOT/t5/fm"
mkdir -p "$fm"
printf 'stale junk\n' > "$fm/whatever.txt"
export FM_DIR="$fm"
export GIT_LOG="$ROOT/t5-git.log" OPENCODE_CWD="$ROOT/t5-cwd"
: > "$GIT_LOG"
run_script
if grep -q "clone" "$GIT_LOG"; then cloned=1; else cloned=0; fi
if [[ $st -ne 0 && ! -s "$OPENCODE_CWD" && $cloned -eq 0 ]]; then
  ok   "non-git dir: refuses to clone into a non-empty, non-git FM_DIR"
else
  no   "non-git dir: refused to fail (exit $st)"
fi

echo "---"
echo "passed: $pass, failed: $fail"
(( fail == 0 ))
