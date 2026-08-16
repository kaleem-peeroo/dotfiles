#!/bin/bash
source "$CONFIG_DIR/colors.sh"

herdr_agents_counts() {
  local json counts
  json=$(cat)
  if [ -z "$json" ]; then
    printf '0 0 0\n'
    return
  fi
  counts=$(printf '%s' "$json" | jq -r '
    ([.result.agents[]? | select(.agent_status=="working")] | length),
    ([.result.agents[]? | select(.agent_status=="blocked" or .agent_status=="idle")] | length),
    ([.result.agents[]? | select(.agent_status=="done")] | length)' | paste -sd' ' -)
  if [ -z "$counts" ]; then
    printf '0 0 0\n'
    return
  fi
  printf '%s\n' "$counts"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  out=$("${HERDR_BIN:-$HOME/.local/bin/herdr}" agent list 2>/dev/null) || out=""
  if [ -n "$out" ]; then
    read -r run wait done <<< "$(printf '%s' "$out" | herdr_agents_counts)"
    run_color=$AGENT_WORKING
    wait_color=$AGENT_WAITING
    done_color=$AGENT_DONE
  else
    run=0; wait=0; done=0
    run_color=$AGENT_DONE
    wait_color=$AGENT_DONE
    done_color=$AGENT_DONE
  fi

  sketchybar --set herdr_run  icon.color=$run_color  label="$run"  label.color=$run_color
  sketchybar --set herdr_wait icon.color=$wait_color label="$wait" label.color=$wait_color
  sketchybar --set herdr_done icon.color=$done_color label="$done" label.color=$done_color
fi
