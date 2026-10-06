# -- Fleet status: one anchor section with the ready count (needs FLEET_POS: q, right, ...). --
# Left click opens the first ready PR, right click lists all.
fleet_count() {
  sketchybar --add item "fleet_$1" "$FLEET_POS" \
      --set "fleet_$1" \
          icon.drawing=off \
          background.drawing=off \
          padding_left=0 \
          padding_right=0 \
          label="?" \
          label.drawing=off \
          update_freq=60 \
          popup.background.color=$BAR_COLOR \
          popup.background.corner_radius=5 \
          script="$PLUGIN_DIR/fleet_$1.sh" \
      --subscribe "fleet_$1" mouse.clicked
}

fleet_count ready

# Added after the count: right-side items stack leftward, so this puts the anchor on the left.
sketchybar --add item fleet_anchor "$FLEET_POS" \
    --set fleet_anchor \
        icon=󰀱 \
        icon.drawing=off \
        label.drawing=off \
        background.drawing=off \
        padding_left=0 \
        padding_right=0

sketchybar --add bracket fleet fleet_anchor fleet_ready \
    --set fleet \
        background.color=$ITEM_BG_COLOR \
        background.corner_radius=5 \
        background.height=20 \
        background.drawing=off
