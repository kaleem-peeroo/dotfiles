#!/bin/zsh

# Uses awk printf to divide by 1000 and format to 1 decimal place
UP_DOWN=$(ifstat -i en0 1 1 | tail -1 | awk '{printf "↓%.1fMbps ↑%.1fMbps", $1/1000, $2/1000}')

sketchybar --set $NAME label="$UP_DOWN"
