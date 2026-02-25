#!/usr/bin/env bash
# Battery plugin using pmset

BATTERY_INFO=$(pmset -g batt)
PERCENT=$(echo "$BATTERY_INFO" | grep -o '[0-9]*%' | head -1 | tr -d '%')
CHARGING=$(echo "$BATTERY_INFO" | grep -c 'AC Power')

if [ -z "$PERCENT" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Icons as raw UTF-8 hex bytes (bash 3.2 compatible)
ICON_BOLT=$'\xEF\x83\xA7'           # U+F0E7 bolt
ICON_BAT_FULL=$'\xEF\x89\x80'       # U+F240 battery-full
ICON_BAT_THREE=$'\xEF\x89\x81'      # U+F241 battery-three-quarters
ICON_BAT_HALF=$'\xEF\x89\x82'       # U+F242 battery-half
ICON_BAT_QUARTER=$'\xEF\x89\x83'    # U+F243 battery-quarter
ICON_BAT_EMPTY=$'\xEF\x89\x84'      # U+F244 battery-empty

if [ "$CHARGING" -gt 0 ]; then
  ICON="$ICON_BOLT"
elif [ "$PERCENT" -gt 80 ]; then
  ICON="$ICON_BAT_FULL"
elif [ "$PERCENT" -gt 60 ]; then
  ICON="$ICON_BAT_THREE"
elif [ "$PERCENT" -gt 40 ]; then
  ICON="$ICON_BAT_HALF"
elif [ "$PERCENT" -gt 20 ]; then
  ICON="$ICON_BAT_QUARTER"
else
  ICON="$ICON_BAT_EMPTY"
fi

COLOR_DIR="$HOME/.config/sketchybar/colors"
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
  BORDER=0xffc9392b
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
