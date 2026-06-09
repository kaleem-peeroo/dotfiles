#!/bin/bash

# Lockfile to prevent concurrent instances stacking up
LOCKFILE="/tmp/sketchybar_spotify.lock"
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE" 2>/dev/null)" 2>/dev/null; then
  exit 0
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

SPOTIFY_DATA=$(osascript -e '
tell application "System Events"
    set isRunning to (count of (every process whose name is "Spotify")) > 0
end tell
if isRunning then
    tell application "Spotify"
        if player state is playing then
            return "playing"
        else
            return "paused"
        end if
    end tell
else
    return "stopped"
end if
')

if [ "$SPOTIFY_DATA" = "playing" ]; then
  sketchybar --set "$NAME" icon=":spotify:" label="􀊄" drawing=on
elif [ "$SPOTIFY_DATA" = "paused" ]; then
  sketchybar --set "$NAME" icon=":spotify:" label="􀊆" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
