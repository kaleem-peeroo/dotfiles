#!/bin/zsh

# Uses awk printf %d to convert floats to integers
UP_DOWN=$(ifstat -i en0 1 1 | tail -1 | awk '{printf "↓%dKB/s ↑%dKB/s", $1, $2}')

sketchybar --set $NAME label="$UP_DOWN"
