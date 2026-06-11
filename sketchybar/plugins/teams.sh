#!/bin/bash

source "$CONFIG_DIR/colors.sh"

UNREAD=$(lsappinfo info -only StatusLabel com.microsoft.teams2 | grep -o '"label"="[^"]*"' | cut -d'"' -f4)

if [ -z "$UNREAD" ] || [ "$UNREAD" = "" ] || [ "$UNREAD" = "0" ]; then
  sketchybar --set $NAME label="0" \
                     icon.color=$WHITE
else
  sketchybar --set $NAME label="$UNREAD" \
                     icon.color=0xff6264A7
fi
