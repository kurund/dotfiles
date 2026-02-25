#!/usr/bin/env bash
# Right modules: Media, Volume, Bluetooth, Battery, Network, Clock, Power

# Nerd Font icons as raw UTF-8 hex bytes (bash 3.2 compatible)
ICON_PLAY=$'\xEF\x81\x8B'       # U+F04B play
ICON_BLUETOOTH=$'\xEF\x8A\x93'  # U+F293 bluetooth
ICON_POWER=$'\xEF\x80\x91'      # U+F011 power_off

# Power — danger #c9392b (added first = far right)
sketchybar --add item power right \
  --set power \
  icon="$ICON_POWER" \
  icon.color=$DANGER \
  label.drawing=off \
  background.border_color=0x66c9392b \
  click_script="osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'"

# Clock — accent-primary #e05a2d (bold border)
sketchybar --add item clock right \
  --set clock \
  icon.drawing=off \
  label.color=$ACCENT_PRIMARY \
  label.font="JetBrainsMono Nerd Font:Bold:13.0" \
  background.border_color=0x80e05a2d \
  update_freq=1 \
  script="$PLUGIN_DIR/clock.sh"

# Network — accent-quaternary #7b68b0
sketchybar --add item network right \
  --set network \
  icon.color=$ACCENT_QUATERNARY \
  label.color=$ACCENT_QUATERNARY \
  update_freq=10 \
  script="$PLUGIN_DIR/network.sh"

# Battery — success #4dcb8a
sketchybar --add item battery right \
  --set battery \
  icon.color=$SUCCESS \
  label.color=$SUCCESS \
  update_freq=30 \
  script="$PLUGIN_DIR/battery.sh"

# Volume — accent-subtle #c47a98
sketchybar --add item volume right \
  --set volume \
  icon.color=$ACCENT_SUBTLE \
  label.color=$ACCENT_SUBTLE \
  script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change

# Media — accent-warm #a85d7c
sketchybar --add item media right \
  --set media \
  icon="$ICON_PLAY" \
  icon.color=$ACCENT_WARM \
  label.color=$ACCENT_WARM \
  label.max_chars=30 \
  update_freq=3 \
  script="$PLUGIN_DIR/media.sh" \
  click_script="nowplaying-cli togglePlayPause"
