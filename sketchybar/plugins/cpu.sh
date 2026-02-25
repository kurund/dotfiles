#!/usr/bin/env bash
# CPU usage plugin (user + sys)

CPU=$(top -l 1 -n 0 | awk '/CPU usage/ {
  gsub(/%/,"")
  print int($3 + $5)
}')
sketchybar --set "$NAME" label="${CPU}%"
