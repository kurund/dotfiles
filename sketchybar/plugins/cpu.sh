#!/usr/bin/env bash
# CPU usage plugin

CPU=$(top -l 1 -n 0 | awk '/CPU usage/ {print int($3)}')
sketchybar --set "$NAME" label="${CPU}%"
