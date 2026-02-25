#!/usr/bin/env bash
# Volume plugin using osascript
# Subscribes to volume_change event for instant updates

ICON_HIGH=$'\xEF\x80\xA8'    # U+F028 volume_up
ICON_MED=$'\xEF\x80\xA7'     # U+F027 volume_down
ICON_LOW=$'\xEF\x80\xA6'     # U+F026 volume_off
ICON_MUTED=$'\xEF\x80\x86'   # U+F023 lock (distinct muted icon)

VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

COLOR_DIR="$HOME/.config/sketchybar/colors"
if [ -f "$COLOR_DIR/current.sh" ]; then
  source "$COLOR_DIR/current.sh"
else
  source "$COLOR_DIR/atomic.sh"
fi

if [ "$MUTED" = "true" ]; then
  sketchybar --set "$NAME" \
    icon="$ICON_MUTED" \
    label="mute" \
    icon.color=$DANGER \
    label.color=$DANGER \
    background.border_color=0x4dc9392b
else
  # Reset colors back to normal
  if [ "$VOLUME" -gt 66 ]; then
    ICON="$ICON_HIGH"
  elif [ "$VOLUME" -gt 33 ]; then
    ICON="$ICON_MED"
  else
    ICON="$ICON_LOW"
  fi
  sketchybar --set "$NAME" \
    icon="$ICON" \
    label="${VOLUME}%" \
    icon.color=$ACCENT_SUBTLE \
    label.color=$ACCENT_SUBTLE \
    background.border_color=$PILL_BORDER
fi
