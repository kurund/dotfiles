#!/usr/bin/env bash
# Memory usage plugin

TOTAL=$(sysctl -n hw.memsize)
USED=$(vm_stat | awk '
  /Pages active/   {a=$NF}
  /Pages wired/    {w=$NF}
  /Pages compressed/ {c=$NF}
  END {
    gsub(/\./,"",a); gsub(/\./,"",w); gsub(/\./,"",c);
    print (a+w+c) * 4096
  }
')
PERCENT=$((USED * 100 / TOTAL))

sketchybar --set "$NAME" label="${PERCENT}%"
