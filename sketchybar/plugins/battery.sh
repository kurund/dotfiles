#!/usr/bin/env bash
# Battery plugin using pmset

BATTERY_INFO=$(pmset -g batt)
PERCENT=$(echo "$BATTERY_INFO" | grep -o '[0-9]*%' | head -1 | tr -d '%')
CHARGING=$(echo "$BATTERY_INFO" | grep -c 'AC Power')

if [ -z "$PERCENT" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Choose icon based on level
if [ "$CHARGING" -gt 0 ]; then
  ICON=" "
elif [ "$PERCENT" -gt 80 ]; then
  ICON=" "
elif [ "$PERCENT" -gt 60 ]; then
  ICON=" "
elif [ "$PERCENT" -gt 40 ]; then
  ICON=" "
elif [ "$PERCENT" -gt 20 ]; then
  ICON=" "
else
  ICON=" "
fi

# Color based on state (matches waybar battery states)
COLOR_DIR="$CONFIG_DIR/sketchybar/colors"
if [ -f "$COLOR_DIR/current.sh" ]; then
  source "$COLOR_DIR/current.sh"
else
  source "$COLOR_DIR/atomic.sh"
fi

if [ "$CHARGING" -gt 0 ]; then
  COLOR=$SUCCESS
  BORDER=0x664dcb8a
elif [ "$PERCENT" -le 15 ]; then
  COLOR=$DANGER
  BORDER=0xff$(echo "$DANGER" | tail -c 7)
elif [ "$PERCENT" -le 30 ]; then
  COLOR=$WARNING
  BORDER=0x66e8c547
else
  COLOR=$SUCCESS
  BORDER=$PILL_BORDER
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  label="${PERCENT}%" \
  icon.color=$COLOR \
  label.color=$COLOR \
  background.border_color=$BORDER
