#!/usr/bin/env bash
# Left modules: CPU, Memory, Disk, Weather

# CPU — accent-tertiary #6b9fc0
sketchybar --add item cpu left \
  --set cpu \
  icon=" " \
  icon.color=$ACCENT_TERTIARY \
  label.color=$ACCENT_TERTIARY \
  update_freq=5 \
  script="$PLUGIN_DIR/cpu.sh" \
  click_script="open -na kitty --args btop"

# Memory — accent-primary #e05a2d
sketchybar --add item memory left \
  --set memory \
  icon=" " \
  icon.color=$ACCENT_PRIMARY \
  label.color=$ACCENT_PRIMARY \
  update_freq=5 \
  script="$PLUGIN_DIR/memory.sh" \
  click_script="open -na kitty --args btop"

# Disk — accent-quaternary #7b68b0
sketchybar --add item disk left \
  --set disk \
  icon=" " \
  icon.color=$ACCENT_QUATERNARY \
  label.color=$ACCENT_QUATERNARY \
  update_freq=30 \
  script="$PLUGIN_DIR/disk.sh" \
  click_script="open -na kitty --args btop"

# Weather — warning #e8c547
sketchybar --add item weather left \
  --set weather \
  icon.color=$WARNING \
  label.color=$WARNING \
  update_freq=3600 \
  script="$PLUGIN_DIR/weather.sh"
