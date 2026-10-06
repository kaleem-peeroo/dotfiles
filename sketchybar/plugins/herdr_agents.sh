#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/attention.sh"

ICON_RUNNING=
ICON_DONE=󰗠

herdr_agents_counts() {
  local json counts
  json=$(cat)
  if [ -z "$json" ]; then
    printf '0 0\n'
    return
  fi
  counts=$(printf '%s' "$json" | jq -r '
    ([.result.agents[]? | select(.agent_status=="working")] | length),
    ([.result.agents[]? | select(.agent_status=="done" or .agent_status=="idle")] | length)' | paste -sd' ' -)
  if [ -z "$counts" ]; then
    printf '0 0\n'
    return
  fi
  printf '%s\n' "$counts"
}

herdr_render() {
  local run done
  read -r run done <<< "$1"
  printf '%s %s %s %s\n' "$ICON_RUNNING" "$run" "$ICON_DONE" "$done"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  out=$("${HERDR_BIN:-$HOME/.local/bin/herdr}" agent list 2>/dev/null) || out=""
  counts="0 0"
  [ -n "$out" ] && counts=$(printf '%s' "$out" | herdr_agents_counts)
  read -r _ done <<< "$counts"

  # Attention = finished or idle agents waiting for you. Running alone does not need you.
  if [ "${done:-0}" -gt 0 ]; then
    attention_show label="$(herdr_render "$counts")" label.color=$WHITE
  else
    attention_hide
  fi
fi
