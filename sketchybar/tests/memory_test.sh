#!/bin/bash
set -u

SKETCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export CONFIG_DIR="$SKETCHY_DIR"
source "$SKETCHY_DIR/plugins/memory.sh"

pass=0
fail=0

VMSTAT_HEADER="Mach Virtual Memory Statistics: (page size of 16384 bytes)"

assert_read() {
  local desc="$1" expected="$2" total="$3" vmstat="$4"
  local got
  got=$(printf '%s' "$vmstat" | memory_read "$total")
  if [ "$got" = "$expected" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $desc -- expected '$expected', got '$got'"
  fi
}

SAMPLE="$(printf '%s\n' \
  "$VMSTAT_HEADER" \
  "Anonymous pages:                              210074." \
  "Pages purgeable:                                6052." \
  "Pages wired down:                             127923." \
  "Pages occupied by compressor:                  21205.")"

assert_read "real-world sample on 16 GiB machine" "6 34" "17179869184" "$SAMPLE"

ZERO="$(printf '%s\n' \
  "$VMSTAT_HEADER" \
  "Anonymous pages:                                   0." \
  "Pages purgeable:                                   0." \
  "Pages wired down:                                  0." \
  "Pages occupied by compressor:                      0.")"

assert_read "no usage at all" "0 0" "17179869184" "$ZERO"

FULL="$(printf '%s\n' \
  "$VMSTAT_HEADER" \
  "Anonymous pages:                             1048576." \
  "Pages purgeable:                                   0." \
  "Pages wired down:                                  0." \
  "Pages occupied by compressor:                      0.")"

assert_read "all 16 GiB in use (decimal GB)" "17 100" "17179869184" "$FULL"

assert_render() {
  local desc="$1" readout="$2" expected="$3"
  local got
  got=$(memory_render "$readout")
  if [ "$got" = "$expected" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $desc -- expected '$expected', got '$got'"
  fi
}

assert_render "normal usage" "6 34" "6 GB 􀫦 34%"
assert_render "zero usage" "0 0" "0 GB 􀫦 0%"

echo ""
echo "passed: $pass, failed: $fail"
[ "$fail" -eq 0 ]
