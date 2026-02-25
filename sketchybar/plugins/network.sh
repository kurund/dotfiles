#!/usr/bin/env bash
# Network plugin

ICON_WIFI=$'\xEF\x87\xAB'       # U+F1EB wifi
ICON_ETHERNET=$'\xEF\x83\xA8'   # U+F0E8 sitemap
ICON_OFF=$'\xEF\x81\xB1'        # U+F071 warning

# Check for active default route
INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')

if [ -z "$INTERFACE" ]; then
  sketchybar --set "$NAME" icon="$ICON_OFF" label="off"
  exit 0
fi

IP=$(ipconfig getifaddr "$INTERFACE" 2>/dev/null)

if [ -z "$IP" ]; then
  sketchybar --set "$NAME" icon="$ICON_OFF" label="off"
  exit 0
fi

# Check if interface is WiFi (en0 is typically WiFi on Mac)
WIFI_HW=$(networksetup -listallhardwareports 2>/dev/null | grep -A1 "Wi-Fi" | awk '/Device:/ {print $2}')

if [ "$INTERFACE" = "$WIFI_HW" ]; then
  sketchybar --set "$NAME" icon="$ICON_WIFI" label="WiFi"
else
  sketchybar --set "$NAME" icon="$ICON_ETHERNET" label="$INTERFACE"
fi
