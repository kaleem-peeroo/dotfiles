#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/dock_badge.sh"
source "$CONFIG_DIR/plugins/attention.sh"

UNREAD=$(dock_badge_count "Slack")

if [ -z "$UNREAD" ] || [ "$UNREAD" = "" ] || [ "$UNREAD" = "0" ]; then
  attention_hide
else
  attention_show icon.drawing=on label="$UNREAD" icon.color=0xff4A154B
fi
