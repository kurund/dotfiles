#!/usr/bin/env bash
# Right modules: Media, Volume, Bluetooth, Battery, Network, Clock, Power

# Media — accent-warm #a85d7c
sketchybar --add item media right \
  --set media \
  icon=" " \
  icon.color=$ACCENT_WARM \
  label.color=$ACCENT_WARM \
  label.max_chars=30 \
  update_freq=3 \
  script="$PLUGIN_DIR/media.sh" \
  click_script="nowplaying-cli togglePlayPause"

# Volume — accent-subtle #c47a98
sketchybar --add item volume right \
  --set volume \
  icon.color=$ACCENT_SUBTLE \
  label.color=$ACCENT_SUBTLE \
  update_freq=5 \
  script="$PLUGIN_DIR/volume.sh"

# Bluetooth — accent-tertiary #6b9fc0
sketchybar --add item bluetooth right \
  --set bluetooth \
  icon="" \
  icon.color=$ACCENT_TERTIARY \
  label.color=$ACCENT_TERTIARY \
  update_freq=30 \
  script="$PLUGIN_DIR/bluetooth.sh"

# Battery — success #4dcb8a
sketchybar --add item battery right \
  --set battery \
  icon.color=$SUCCESS \
  label.color=$SUCCESS \
  update_freq=30 \
  script="$PLUGIN_DIR/battery.sh"

# Network — accent-quaternary #7b68b0
sketchybar --add item network right \
  --set network \
  icon.color=$ACCENT_QUATERNARY \
  label.color=$ACCENT_QUATERNARY \
  update_freq=10 \
  script="$PLUGIN_DIR/network.sh"

# Clock — accent-primary #e05a2d (bold border)
sketchybar --add item clock right \
  --set clock \
  icon.drawing=off \
  label.color=$ACCENT_PRIMARY \
  label.font="JetBrains Mono Nerd Font:Bold:13.0" \
  background.border_color=0x80e05a2d \
  update_freq=1 \
  script="$PLUGIN_DIR/clock.sh"

# Power — danger #c9392b
sketchybar --add item power right \
  --set power \
  icon="  " \
  icon.color=$DANGER \
  label.drawing=off \
  background.border_color=0x66c9392b \
  click_script="osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'"
