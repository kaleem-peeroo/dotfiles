#!/bin/bash
# Shared by fleet_ready.sh / fleet_red.sh / fleet_running.sh. Reads the cache via fleet_status.py only.

FLEET_GREY=0xff888888
FLEET_GREEN=0xff1dfca1
FLEET_RED=0xffff2453
FLEET_ORANGE=0xfff97716

# fleet_render <group> <colour> <always|hide>
fleet_render() {
  local group="$1" color="$2" when_zero="$3" json count stale updated

  json=$(python3 "$CONFIG_DIR/plugins/fleet_status.py")

  if [ "${SENDER:-}" = "mouse.clicked" ]; then
    if [ "${BUTTON:-}" = "right" ]; then
      sketchybar --set "$NAME" popup.drawing=toggle
    else
      local url
      url=$(printf '%s' "$json" | jq -r --arg g "$group" '[.rows[$g][]? | select(.counted and .url != "")][0].url // empty')
      [ -n "$url" ] && open "$url"
    fi
    return
  fi

  count=$(printf '%s' "$json" | jq -r --arg g "$group" '.counts[$g] // "?"')
  stale=$(printf '%s' "$json" | jq -r '.stale')
  updated=$(printf '%s' "$json" | jq -r '.updated')

  if [ "$count" = "0" ] && [ "$when_zero" = "hide" ]; then
    # hidden items get no timer ticks, so collapse the item instead of drawing=off
    sketchybar --set "$NAME" label.drawing=off popup.drawing=off
    return
  fi

  local shade="$WHITE"
  if [ "$stale" = "true" ] || [ "$count" = "?" ]; then
    shade="$FLEET_GREY"
  elif [ "$count" != "0" ]; then
    shade="$color"
  fi
  sketchybar --set "$NAME" label.drawing=on label="$count" label.color=$shade

  fleet_popup "$json" "$group" "$stale" "$updated"
}

fleet_popup() {
  local json="$1" group="$2" stale="$3" updated="$4" i=0 header text url
  local args=()

  sketchybar --remove "/${NAME}\\.row.*/" 2>/dev/null

  header="Updated ${updated:-never}"
  [ "$stale" = "true" ] && header="STALE · last refresh ${updated:-never}"
  args+=(--add item "$NAME.row$i" popup."$NAME" --set "$NAME.row$i" label="$header" label.color=$FLEET_GREY icon.drawing=off)

  while IFS=$'\t' read -r text url; do
    i=$((i + 1))
    args+=(--add item "$NAME.row$i" popup."$NAME" --set "$NAME.row$i" label="$text" label.max_chars=90 icon.drawing=off)
    [ -n "$url" ] && args+=(--set "$NAME.row$i" click_script="open '$url'; sketchybar --set $NAME popup.drawing=off")
  done < <(printf '%s' "$json" | jq -r --arg g "$group" '.rows[$g][]? | [.text, .url] | @tsv')

  sketchybar "${args[@]}"
}
