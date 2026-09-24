#!/bin/bash
set -u

SKETCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export CONFIG_DIR="$SKETCHY_DIR"
source "$SKETCHY_DIR/plugins/dock_badge.sh"

pass=0
fail=0

assert_parse() {
  local desc="$1" expected="$2" raw="$3"
  local got
  got=$(dock_badge_parse "$raw")
  if [ "$got" = "$expected" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $desc -- expected '$expected', got '$got'"
  fi
}

assert_parse "real unread count" "3" "3"
assert_parse "no badge (AppleScript's missing value)" "" "missing value"
assert_parse "app not running / not in dock" "" "System Events got an error: Can't get UI element 1 of list 1 of process \"Dock\" whose name = \"Foo\". Invalid index. (-1719)"
assert_parse "empty output" "" ""

echo ""
echo "passed: $pass, failed: $fail"
[ "$fail" -eq 0 ]
