#!/usr/bin/env bash
# Volume plugin using osascript

VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" = "true" ]; then
  ICON=" "
  COLOR_DIR="$CONFIG_DIR/sketchybar/colors"
  if [ -f "$COLOR_DIR/current.sh" ]; then
    source "$COLOR_DIR/current.sh"
  else
    source "$COLOR_DIR/atomic.sh"
  fi
  sketchybar --set "$NAME" \
    icon="$ICON" \
    label="${VOLUME}%" \
    icon.color=$DANGER \
    label.color=$DANGER \
    background.border_color=0x4dc9392b
elif [ "$VOLUME" -gt 66 ]; then
  ICON=" "
  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
elif [ "$VOLUME" -gt 33 ]; then
  ICON=" "
  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
else
  ICON=" "
  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
fi
