#!/usr/bin/env bash
# Disk usage plugin (uses Data volume on macOS)

PERCENT=$(df -h /System/Volumes/Data | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
sketchybar --set "$NAME" label="${PERCENT}%"
