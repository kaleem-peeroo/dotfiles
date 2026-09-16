#!/bin/bash

memory_read() {
  local total_bytes="$1"
  awk -v total="$total_bytes" '
    /Anonymous pages:/ { anon = $NF }
    /Pages purgeable:/ { purge = $NF }
    /Pages wired down:/ { wired = $NF }
    /Pages occupied by compressor:/ { comp = $NF }
    /page size of/ { page = $8 }
    END {
      used = (anon - purge + wired + comp) * page
      printf "%.0f %.0f", used / 1000000000, used * 100 / total
    }'
}

memory_render() {
  local gb pct
  read -r gb pct <<< "$1"
  printf '%s GB 􀫦 %s%%\n' "$gb" "$pct"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  out=$(vm_stat | memory_read "$(sysctl -n hw.memsize)")
  sketchybar --set memory label="$(memory_render "$out")"
fi
