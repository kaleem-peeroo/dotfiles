#!/bin/zsh

RAM_USAGE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{printf "%d%%", 100-$5}')

sketchybar --set $NAME label="$RAM_USAGE"
