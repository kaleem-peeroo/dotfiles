#!/bin/bash
set -u

SKETCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export CONFIG_DIR="$SKETCHY_DIR"
source "$SKETCHY_DIR/plugins/herdr_agents.sh"

pass=0
fail=0

assert_counts() {
  local desc="$1" expected="$2" json="$3"
  local got
  got=$(printf '%s' "$json" | herdr_agents_counts)
  if [ "$got" = "$expected" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $desc -- expected '$expected', got '$got'"
  fi
}

assert_counts "three working agents" "3 0 0" '{"result":{"agents":[
  {"agent_status":"working"},
  {"agent_status":"working"},
  {"agent_status":"working"}
]}}'

assert_counts "working/blocked/idle/done/unknown all present" "1 2 1" '{"result":{"agents":[
  {"agent_status":"working"},
  {"agent_status":"blocked"},
  {"agent_status":"idle"},
  {"agent_status":"done"},
  {"agent_status":"unknown"}
]}}'

assert_counts "done only" "0 0 1" '{"result":{"agents":[{"agent_status":"done"}]}}'

assert_counts "unknown only is excluded" "0 0 0" '{"result":{"agents":[{"agent_status":"unknown"}]}}'

assert_counts "no result key" "0 0 0" '{}'

assert_counts "empty input" "0 0 0" ""

echo ""
echo "passed: $pass, failed: $fail"
[ "$fail" -eq 0 ]
