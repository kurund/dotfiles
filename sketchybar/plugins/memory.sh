#!/usr/bin/env bash
# Memory usage plugin (uses actual page size for Apple Silicon)

PAGE_SIZE=$(sysctl -n hw.pagesize)
TOTAL=$(sysctl -n hw.memsize)
USED=$(vm_stat | awk -v ps="$PAGE_SIZE" '
  /Pages active/     {a=$NF}
  /Pages wired/      {w=$NF}
  /Pages compressed/ {c=$NF}
  END {
    gsub(/\./,"",a); gsub(/\./,"",w); gsub(/\./,"",c);
    print (a+w+c) * ps
  }
')
PERCENT=$((USED * 100 / TOTAL))

sketchybar --set "$NAME" label="${PERCENT}%"
