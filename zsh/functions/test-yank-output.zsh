# Tests for yank-output.zsh pure logic (no zle needed).
#
# Run: zsh ~/.config/zsh/functions/test-yank-output.zsh

ZSH_YANK_TEST_DIR=${0:A:h}
source "$ZSH_YANK_TEST_DIR/yank-output.zsh"

pass=0
fail=0

assert_eq() {
  local desc=$1 got=$2 want=$3
  if [[ "$got" == "$want" ]]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    print -r -- "FAIL: $desc: got '$got', want '$want'"
  fi
}

assert_ok() {
  local rc=$?
  local desc=$1
  if [[ $rc -eq 0 ]]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    print -r -- "FAIL: $desc: expected success"
  fi
}

assert_fail() {
  local rc=$?
  local desc=$1
  if [[ $rc -ne 0 ]]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    print -r -- "FAIL: $desc: expected failure"
  fi
}

# --- _zsh_yank_is_blocked ---

_zsh_yank_is_blocked "rm -rf build/";   assert_ok "blocks rm"
_zsh_yank_is_blocked "sudo rm -rf /";   assert_ok "blocks sudo"
_zsh_yank_is_blocked "git push origin"; assert_ok "blocks git push"
_zsh_yank_is_blocked "vim README.md";   assert_ok "blocks vim"
_zsh_yank_is_blocked "ifconfig";        assert_fail "allows ifconfig"
_zsh_yank_is_blocked "ls -la";          assert_fail "allows ls"
_zsh_yank_is_blocked "ip addr show";    assert_fail "allows ip"
_zsh_yank_is_blocked "";                assert_fail "allows empty"

# --- _zsh_yank_capture ---

assert_eq "_zsh_yank_capture echo" \
  "$(_zsh_yank_capture "echo hello world")" "hello world"
assert_eq "_zsh_yank_capture ignores stderr" \
  "$(_zsh_yank_capture "echo out; echo err >&2")" "out"
assert_fail "_zsh_yank_capture exits nonzero" \
  "$(_zsh_yank_capture "false")" 2>/dev/null

# --- _zsh_yank_pick (with fake fzf) ---

fzf() { cat; }
assert_eq "_zsh_yank_pick echoes items through fzf" \
  "$(_zsh_yank_pick alpha beta gamma | tr '\n' '|')" "alpha|beta|gamma|"
fzf() { sed -n '2p'; }
assert_eq "_zsh_yank_pick forwards selection" \
  "$(_zsh_yank_pick alpha beta gamma)" "beta"
unset -f fzf

# --- _zsh_yank_select_word (full two-stage flow, fake fzf) ---

rm -f /tmp/fzf-stage
fzf() {
  if [[ ! -e /tmp/fzf-stage ]]; then
    echo 1 > /tmp/fzf-stage
    sed -n '2p'     # stage 1: pick 2nd line
  else
    sed -n '2p'     # stage 2: pick 2nd word
  fi
}
assert_eq "two-stage selects 2nd word of 2nd line" \
  "$(_zsh_yank_select_word "printf 'inet 192.168.1.24 netmask\ninet6 fe80::1 prefixlen\n'")" "fe80::1"

rm -f /tmp/fzf-stage
fzf() { sed -n '1p'; }   # always first line/word
assert_eq "two-stage picks first line first word" \
  "$(_zsh_yank_select_word "printf 'inet 192.168.1.24 netmask\ninet6 fe80::1\n'")" "inet"

rm -f /tmp/fzf-stage
assert_eq "blocked command yields nothing" \
  "$(_zsh_yank_select_word "rm -rf build/")" ""

assert_eq "empty command yields nothing" \
  "$(_zsh_yank_select_word "")" ""
unset -f fzf

print -r -- ""
print -r -- "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
