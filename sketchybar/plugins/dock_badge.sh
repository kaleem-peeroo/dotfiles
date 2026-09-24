#!/bin/bash

dock_badge_parse() {
  local raw="$1"
  case "$raw" in
  '' | *'missing value'* | *'error'*)
    printf ''
    ;;
  *)
    printf '%s' "$raw"
    ;;
  esac
}

dock_badge_fetch() {
  local app_name="$1"
  osascript -e "
tell application \"System Events\"
  tell process \"Dock\"
    try
      return value of attribute \"AXStatusLabel\" of (first UI element of list 1 whose name is \"$app_name\")
    on error
      return \"\"
    end try
  end tell
end tell" 2>/dev/null
}

dock_badge_count() {
  dock_badge_parse "$(dock_badge_fetch "$1")"
}
