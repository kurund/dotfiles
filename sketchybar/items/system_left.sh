#!/usr/bin/env bash
# Left modules: CPU, Memory, Disk, Weather

# Nerd Font icons as raw UTF-8 hex bytes (bash 3.2 compatible)
ICON_CPU=$'\xEF\x8B\x9B'        # U+F2DB microchip
ICON_MEMORY=$'\xEF\x88\xB3'     # U+F233 server
ICON_DISK=$'\xEF\x82\xA0'       # U+F0A0 hdd

# CPU — accent-tertiary #6b9fc0
sketchybar --add item cpu left \
  --set cpu \
  icon="$ICON_CPU" \
  icon.color=$ACCENT_TERTIARY \
  label.color=$ACCENT_TERTIARY \
  update_freq=5 \
  script="$PLUGIN_DIR/cpu.sh" \
  click_script="open -na kitty --args btop"

# Memory — accent-primary #e05a2d
sketchybar --add item memory left \
  --set memory \
  icon="$ICON_MEMORY" \
  icon.color=$ACCENT_PRIMARY \
  label.color=$ACCENT_PRIMARY \
  update_freq=5 \
  script="$PLUGIN_DIR/memory.sh" \
  click_script="open -na kitty --args btop"

# Disk — accent-quaternary #7b68b0
sketchybar --add item disk left \
  --set disk \
  icon="$ICON_DISK" \
  icon.color=$ACCENT_QUATERNARY \
  label.color=$ACCENT_QUATERNARY \
  update_freq=30 \
  script="$PLUGIN_DIR/disk.sh" \
  click_script="open -na kitty --args btop"
