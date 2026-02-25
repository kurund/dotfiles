#!/usr/bin/env bash

STATE=$(nowplaying-cli get playbackRate 2>/dev/null)
TITLE=$(nowplaying-cli get title 2>/dev/null)
ARTIST=$(nowplaying-cli get artist 2>/dev/null)

ICON_PLAY=$'\xEF\x81\x8B'    # U+F04B play
ICON_PAUSE=$'\xEF\x81\x8C'   # U+F04C pause

if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
  sketchybar --set "$NAME" drawing=off
else
  if [ "$STATE" = "1" ] || [ "$STATE" = "1.0" ]; then
    ICON="$ICON_PLAY"
  else
    ICON="$ICON_PAUSE"
  fi

  DISPLAY="${ARTIST} - ${TITLE}"
  sketchybar --set "$NAME" drawing=on icon="$ICON" label="$DISPLAY"
fi
