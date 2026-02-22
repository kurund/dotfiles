#!/usr/bin/env bash
# Workspace indicators — center position

AEROSPACE_PLUGIN="$PLUGIN_DIR/aerospace.sh"

# Unfocused workspace style
UNFOCUSED_BG=0x4d162830     # surface at 30% opacity
UNFOCUSED_BORDER=0x801e3038 # surface-border at 50% opacity

for i in $(seq 1 10); do
  # Get per-workspace accent color
  ws_color_var="WS_COLOR_${i}"
  ws_color="${!ws_color_var}"

  sketchybar --add item workspace.$i center \
    --set workspace.$i \
    icon="$i" \
    icon.font="JetBrains Mono Nerd Font:Bold:13.0" \
    icon.color=$TEXT_DIM \
    icon.padding_left=0 \
    icon.padding_right=0 \
    label.drawing=off \
    background.color=$UNFOCUSED_BG \
    background.border_color=$UNFOCUSED_BORDER \
    background.border_width=2 \
    background.corner_radius=14 \
    background.height=28 \
    padding_left=3 \
    padding_right=3 \
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
