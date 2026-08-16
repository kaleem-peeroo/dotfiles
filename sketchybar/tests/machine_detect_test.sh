#!/bin/bash
set -u

SKETCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$SKETCHY_DIR/machines/detect.sh"

pass=0
fail=0

assert_machine() {
  local desc="$1" expected="$2" name="$3"
  local got
  got=$(detect_machine "$name")
  if [ "$got" = "$expected" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $desc -- expected '$expected', got '$got'"
  fi
}

assert_machine "MacBook Air" macbook "MacBook Air"
assert_machine "Kaleem's MacBook Pro" macbook "Kaleem's MacBook Pro"
assert_machine "Kaleem's Mac mini" macmini "Kaleem's Mac mini"
assert_machine "unknown host defaults to macmini" macmini "file-server-01"

echo ""
echo "passed: $pass, failed: $fail"
[ "$fail" -eq 0 ]
