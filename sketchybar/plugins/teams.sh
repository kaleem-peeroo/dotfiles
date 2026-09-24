#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/dock_badge.sh"

UNREAD=$(dock_badge_count "Microsoft Teams")

if [ -z "$UNREAD" ] || [ "$UNREAD" = "" ] || [ "$UNREAD" = "0" ]; then
  sketchybar --set $NAME label="0" \
                     icon.color=$WHITE
else
  sketchybar --set $NAME label="$UNREAD" \
                     icon.color=0xff6264A7
fi
