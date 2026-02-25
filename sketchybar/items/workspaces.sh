#!/usr/bin/env bash
# Workspace indicators — left position

AEROSPACE_PLUGIN="$PLUGIN_DIR/aerospace.sh"

# Unfocused workspace style
UNFOCUSED_BG=0x4d162830     # surface at 30% opacity
UNFOCUSED_BORDER=0x801e3038 # surface-border at 50% opacity

WS_COUNT=6

for i in $(seq 1 $WS_COUNT); do
  # Get per-workspace accent color
  ws_color_var="WS_COLOR_${i}"
  ws_color="${!ws_color_var}"

  # Extra padding on first/last items so they don't merge into bracket border
  PAD_LEFT=3
  PAD_RIGHT=3
  if [ "$i" -eq 1 ]; then
    PAD_LEFT=6
  fi
  if [ "$i" -eq "$WS_COUNT" ]; then
    PAD_RIGHT=6
  fi

  sketchybar --add item workspace.$i left \
    --set workspace.$i \
    icon="$i" \
    icon.font="JetBrainsMono Nerd Font:Bold:13.0" \
    icon.color=$TEXT_SECONDARY \
    icon.padding_left=8 \
    icon.padding_right=8 \
    label.drawing=off \
    background.color=$UNFOCUSED_BG \
    background.border_color=$UNFOCUSED_BORDER \
    background.border_width=2 \
    background.corner_radius=14 \
    background.height=28 \
    padding_left=$PAD_LEFT \
    padding_right=$PAD_RIGHT \
    click_script="aerospace workspace $i" \
    script="$AEROSPACE_PLUGIN $i $ws_color" \
    --subscribe workspace.$i aerospace_workspace_change
done

# Group workspaces into a container pill (matching #workspaces styling)
sketchybar --add bracket workspaces '/workspace\..*/' \
  --set workspaces \
  background.color=$WS_BG \
  background.border_color=$WS_BORDER \
  background.border_width=2 \
  background.corner_radius=20 \
  background.height=36
