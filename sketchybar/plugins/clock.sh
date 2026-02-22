#!/usr/bin/env bash
# Clock plugin

CLOCK=$(date '+%a %b %d, %H:%M:%S (%Z)')
sketchybar --set "$NAME" label="$CLOCK"
