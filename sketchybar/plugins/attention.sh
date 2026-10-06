#!/bin/bash
# Collapse an item when nothing needs attention. Not drawing=off: hidden items get no timer ticks.

attention_hide() {
  sketchybar --set "$NAME" icon.drawing=off label.drawing=off background.drawing=off padding_left=0 padding_right=0
}

# extra --set properties go in "$@", e.g. icon.drawing=on for items that have an icon
attention_show() {
  sketchybar --set "$NAME" label.drawing=on background.drawing=on padding_left=5 padding_right=5 "$@"
}
