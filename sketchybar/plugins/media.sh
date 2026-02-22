#!/usr/bin/env bash

STATE=$(nowplaying-cli get playbackRate 2>/dev/null)
TITLE=$(nowplaying-cli get title 2>/dev/null)
ARTIST=$(nowplaying-cli get artist 2>/dev/null)

if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
  sketchybar --set "$NAME" drawing=off
else
  if [ "$STATE" = "1" ] || [ "$STATE" = "1.0" ]; then
    ICON=" "
  else
    ICON=" "
  fi

  DISPLAY="${ARTIST} - ${TITLE}"
  sketchybar --set "$NAME" drawing=on icon="$ICON" label="$DISPLAY"
fi
