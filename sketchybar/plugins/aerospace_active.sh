#!/bin/bash

source "$CONFIG_DIR/colors.sh"

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

if [ -n "$FOCUSED" ]; then
    sketchybar --set $NAME label="$FOCUSED" \
                         icon=􀋦 \
                         background.drawing=on \
                         label.color=$BAR_COLOR \
                         icon.color=$BAR_COLOR
fi
