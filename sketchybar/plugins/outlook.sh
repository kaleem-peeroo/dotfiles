#!/bin/bash

source "$CONFIG_DIR/colors.sh"

UNREAD=$(lsappinfo info -only StatusLabel com.microsoft.Outlook | grep -o '"label"="[^"]*"' | cut -d'"' -f4)

if [ -z "$UNREAD" ] || [ "$UNREAD" = "" ] || [ "$UNREAD" = "0" ]; then
  sketchybar --set $NAME label="0" \
                     icon.color=$WHITE
else
  sketchybar --set $NAME label="$UNREAD" \
                     icon.color=0xff0078D4
fi
