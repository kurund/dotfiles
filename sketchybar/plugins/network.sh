#!/usr/bin/env bash
# Network plugin

WIFI=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I 2>/dev/null)

if [ -z "$WIFI" ] || echo "$WIFI" | grep -q "AirPort: Off"; then
  sketchybar --set "$NAME" icon="󰤭 " label="off"
else
  SSID=$(echo "$WIFI" | awk -F': ' '/^ *SSID/ {print $2}')
  if [ -n "$SSID" ]; then
    sketchybar --set "$NAME" icon=" " label="$SSID"
  else
    # Wired or no SSID
    INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')
    if [ -n "$INTERFACE" ]; then
      sketchybar --set "$NAME" icon=" " label="$INTERFACE"
    else
      sketchybar --set "$NAME" icon="󰤭 " label="none"
    fi
  fi
fi
