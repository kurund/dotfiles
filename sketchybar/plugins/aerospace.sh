#!/usr/bin/env bash
# Workspace change handler for AeroSpace
# Called by SketchyBar when aerospace_workspace_change fires
# Args: $1 = workspace number, $2 = accent color for this workspace

WORKSPACE_ID="$1"
ACCENT_COLOR="$2"

# Load colors
COLOR_DIR="$CONFIG_DIR/sketchybar/colors"
if [ -f "$COLOR_DIR/current.sh" ]; then
  source "$COLOR_DIR/current.sh"
else
  source "$COLOR_DIR/atomic.sh"
fi

FOCUSED_WS="$FOCUSED_WORKSPACE"

if [ "$WORKSPACE_ID" = "$FOCUSED_WS" ]; then
  # Focused: fill with accent color, dark text
  sketchybar --set "$NAME" \
    icon.color=$BASE \
    background.color="$ACCENT_COLOR" \
    background.border_color="$ACCENT_COLOR"
else
  # Unfocused: dim background, dim text
  sketchybar --set "$NAME" \
    icon.color=$TEXT_DIM \
    background.color=0x4d162830 \
    background.border_color=0x801e3038
fi
