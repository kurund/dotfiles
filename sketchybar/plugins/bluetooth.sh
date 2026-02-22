#!/usr/bin/env bash
# Bluetooth plugin using blueutil

POWER=$(blueutil -p 2>/dev/null)
CONNECTED=$(blueutil --connected --format json 2>/dev/null | jq -r 'length' 2>/dev/null)

if [ "$POWER" = "0" ]; then
  sketchybar --set "$NAME" icon="" label="off"
elif [ -n "$CONNECTED" ] && [ "$CONNECTED" -gt 0 ]; then
  sketchybar --set "$NAME" icon="" label="${CONNECTED}"
else
  sketchybar --set "$NAME" icon="" label=""
fi
