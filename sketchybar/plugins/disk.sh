#!/usr/bin/env bash
# Disk usage plugin

PERCENT=$(df -h / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
sketchybar --set "$NAME" label="${PERCENT}%"
