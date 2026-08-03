# Tests for tab-accept.zsh pure logic (no zle needed).
#
# Run: zsh ~/.config/zsh/functions/test-tab-accept.zsh

source "${0:A:h}/tab-accept.zsh"

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

# --- _zsh_tab_accept_action (pure predicate) ---

BUFFER="cd ~/.conf"; POSTDISPLAY="ig"; CURSOR=$#BUFFER
_zsh_tab_accept_action; assert_ok "accepts when suggestion visible and cursor at end"

BUFFER="cd ~/.conf"; POSTDISPLAY=""; CURSOR=$#BUFFER
_zsh_tab_accept_action; assert_fail "completes when no suggestion"

BUFFER="cd ~/.conf"; POSTDISPLAY="ig"; CURSOR=1
_zsh_tab_accept_action; assert_fail "completes when cursor not at end"

BUFFER=""; POSTDISPLAY=""; CURSOR=0
_zsh_tab_accept_action; assert_fail "completes when empty buffer and no suggestion"

# --- _zsh_tab_accept (stubbed zle) ---

typeset -ga zle_calls
zle() { zle_calls+=("$@"); }

BUFFER="git st"; POSTDISPLAY="atus"; CURSOR=$#BUFFER
zle_calls=()
_zsh_tab_accept
assert_eq "widget accepts suggestion" "${zle_calls[*]}" "autosuggest-accept"

BUFFER="git st"; POSTDISPLAY=""; CURSOR=$#BUFFER
zle_calls=()
_zsh_tab_accept
assert_eq "widget falls back to fzf-tab-complete" "${zle_calls[*]}" "fzf-tab-complete"

BUFFER="git st"; POSTDISPLAY="atus"; CURSOR=1
zle_calls=()
_zsh_tab_accept
assert_eq "widget completes when cursor not at end" "${zle_calls[*]}" "fzf-tab-complete"

unset -f zle

print -r -- ""
print -r -- "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
