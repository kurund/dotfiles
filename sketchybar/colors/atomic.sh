#!/usr/bin/env bash
# Atomic (retro space-age) color palette
# Source: waybar/atomic.css — translated to 0xAARRGGBB format

export ACCENT_SOFT=0xfff5ecd7
export ACCENT_WARM=0xffa85d7c
export ACCENT_PRIMARY=0xffe05a2d
export ACCENT_SECONDARY=0xff2fb8b0
export DANGER=0xffc9392b
export DANGER_DEEP=0xff8b1a10
export ACCENT_HIGHLIGHT=0xffd4953a
export WARNING=0xffe8c547
export SUCCESS=0xff4dcb8a
export ACCENT_QUATERNARY=0xff7b68b0
export ACCENT_LIGHT=0xff7accc6
export ACCENT_TERTIARY=0xff6b9fc0
export ACCENT_MUTED=0xff4a7fa5
export ACCENT_SUBTLE=0xffc47a98

export TEXT=0xfff5ecd7
export TEXT_SECONDARY=0xffd9cdb8
export TEXT_TERTIARY=0xffb8a990
export TEXT_BRIGHT=0xff8a7d6b
export TEXT_MUTED=0xff6b6054
export TEXT_DIM=0xff4a4238

export SURFACE_HIGHLIGHT=0xff2a3d44
export SURFACE_BORDER=0xff1e3038
export SURFACE=0xff162830
export BASE_MID=0xff112228
export BASE_DEEP=0xff0a151a
export BASE=0xff0d1b22

# Pill background: base at 85% opacity
export PILL_BG=0xd90d1b22
# Pill border: accent-secondary at 30% opacity
export PILL_BORDER=0x4d2fb8b0
# Workspace container: base-deep at 92% opacity
export WS_BG=0xeb0a151a
# Workspace container border: accent-secondary at 40% opacity
export WS_BORDER=0x662fb8b0

# Per-workspace accent colors (nth-child order from atomic-bar.css)
export WS_COLOR_1=$ACCENT_PRIMARY    # orange
export WS_COLOR_2=$ACCENT_SECONDARY  # teal
export WS_COLOR_3=$ACCENT_TERTIARY   # blue
export WS_COLOR_4=$ACCENT_QUATERNARY # purple
export WS_COLOR_5=$WARNING           # golden yellow
export WS_COLOR_6=$ACCENT_HIGHLIGHT  # golden
export WS_COLOR_7=$SUCCESS           # mint
export WS_COLOR_8=$ACCENT_WARM       # rose
export WS_COLOR_9=$ACCENT_SUBTLE     # pink
export WS_COLOR_10=$DANGER           # red

# Active border color (from sway/atomic-theme)
export BORDER_ACTIVE=0xffe8c547
export BORDER_INACTIVE=0xff1e3038
