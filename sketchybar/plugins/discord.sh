#!/bin/sh

UNREAD=$(lsappinfo info -only StatusLabel com.hnc.Discord | grep -o '"label"="[^"]*"' | cut -d'"' -f4)

if [ -z "$UNREAD" ] || [ "$UNREAD" = "" ]; then
  sketchybar --set $NAME label="0"
else
  sketchybar --set $NAME label="$UNREAD"
fi
