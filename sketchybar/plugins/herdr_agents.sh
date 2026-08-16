#!/bin/bash
source "$CONFIG_DIR/colors.sh"

ICON_RUNNING=
ICON_WAITING=󰂚
ICON_DONE=󰗠

herdr_agents_counts() {
  local json counts
  json=$(cat)
  if [ -z "$json" ]; then
    printf '0 0 0\n'
    return
  fi
  counts=$(printf '%s' "$json" | jq -r '
    ([.result.agents[]? | select(.agent_status=="working")] | length),
    ([.result.agents[]? | select(.agent_status=="blocked")] | length),
    ([.result.agents[]? | select(.agent_status=="done" or .agent_status=="idle")] | length)' | paste -sd' ' -)
  if [ -z "$counts" ]; then
    printf '0 0 0\n'
    return
  fi
  printf '%s\n' "$counts"
}

herdr_render() {
  local run wait done
  read -r run wait done <<< "$1"
  printf '%s %s %s %s %s %s\n' "$ICON_RUNNING" "$run" "$ICON_WAITING" "$wait" "$ICON_DONE" "$done"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  out=$("${HERDR_BIN:-$HOME/.local/bin/herdr}" agent list 2>/dev/null) || out=""
  if [ -n "$out" ]; then
    render=$(herdr_render "$(printf '%s' "$out" | herdr_agents_counts)")
  else
    render=$(herdr_render "0 0 0")
  fi

  sketchybar --set herdr label="$render" label.color=$WHITE
fi
