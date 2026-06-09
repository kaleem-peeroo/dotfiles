#!/bin/bash

# Lockfile to prevent concurrent instances stacking up
LOCKFILE="/tmp/sketchybar_cpu_temp.lock"
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE" 2>/dev/null)" 2>/dev/null; then
  exit 0
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

SMC="/Applications/Stats.app/Contents/Resources/smc"

TEMP=$($SMC list -t 2>/dev/null | grep "^\[TCMb\]" | awk '{print $2}' | awk -F. '{print $1}')

[ -z "$TEMP" ] && TEMP="--"

sketchybar --set $NAME label="${TEMP}°"
