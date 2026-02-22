#!/usr/bin/env bash
# Weather plugin using wttr.in

LOCATION="Exeter"
WEATHER=$(curl -s "wttr.in/${LOCATION}?format=%c%t" 2>/dev/null)

if [ -z "$WEATHER" ] || [[ "$WEATHER" == *"Unknown"* ]]; then
  sketchybar --set "$NAME" icon="" label="N/A"
else
  ICON=$(echo "$WEATHER" | head -c 3)
  TEMP=$(echo "$WEATHER" | sed 's/^.\{1,4\}//')
  sketchybar --set "$NAME" icon="$ICON" label="$TEMP"
fi
