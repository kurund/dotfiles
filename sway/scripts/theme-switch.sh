#!/usr/bin/env bash
# Theme switcher for sway desktop
# Usage: theme-switch.sh <theme>   (e.g. vaporwave, atomic)
#        theme-switch.sh           (opens rofi picker)

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
THEMES=("vaporwave" "atomic")

pick_theme() {
  printf '%s\n' "${THEMES[@]}" | rofi -dmenu -p "Theme" -i
}

THEME="${1:-$(pick_theme)}"

if [[ -z "$THEME" ]]; then
  echo "No theme selected."
  exit 0
fi

# Validate theme
valid=false
for t in "${THEMES[@]}"; do
  [[ "$t" == "$THEME" ]] && valid=true && break
done
if ! $valid; then
  echo "Unknown theme: $THEME"
  echo "Available: ${THEMES[*]}"
  exit 1
fi

echo "Switching to theme: $THEME"

# 1. Waybar: change color and bar-style @imports in style.css
sed -i '1s|^@import ".*\.css";|@import "'"${THEME}"'.css";|' "$CONFIG_DIR/waybar/style.css"
sed -i '2s|^@import ".*-bar\.css";|@import "'"${THEME}"'-bar.css";|' "$CONFIG_DIR/waybar/style.css"

# 2. Kitty: change include in kitty.conf
sed -i "s|^include .*\.conf$|include ${THEME}.conf|" "$CONFIG_DIR/kitty/kitty.conf"

# 3. Rofi: change @theme in config.rasi
sed -i "s|^@theme \".*\"|@theme \"${THEME}\"|" "$CONFIG_DIR/rofi/config.rasi"

# 4. Sway: change include theme file
sed -i "s|^include ~/.config/sway/.*-theme|include ~/.config/sway/${THEME}-theme|" "$CONFIG_DIR/sway/config"

# 5. Swaylock: change config path references
sed -i "s|swaylock -f -C ~/.config/swaylock/.*-config|swaylock -f -C ~/.config/swaylock/${THEME}-config|g" "$CONFIG_DIR/sway/config"

# 6. Btop: change color_theme
sed -i "s|^color_theme = \".*\"|color_theme = \"${THEME}\"|" "$CONFIG_DIR/btop/btop.conf"

# 7. Swaync: symlink swap
ln -sf "${THEME}.css" "$CONFIG_DIR/swaync/style.css"

# 8. Wlogout: symlink swap
ln -sf "${THEME}.css" "$CONFIG_DIR/wlogout/style.css"

# 9. Waybar workspace icons: swap between Japanese numerals and plain digits
MODULES="$CONFIG_DIR/waybar/modules.jsonc"
if [[ "$THEME" == "vaporwave" ]]; then
  sed -i 's|"1": "1"|"1": "一"|; s|"2": "2"|"2": "二"|; s|"3": "3"|"3": "三"|' "$MODULES"
  sed -i 's|"4": "4"|"4": "四"|; s|"5": "5"|"5": "五"|; s|"6": "6"|"6": "六"|' "$MODULES"
  sed -i 's|"7": "7"|"7": "七"|; s|"8": "8"|"8": "八"|; s|"9": "9"|"9": "九"|' "$MODULES"
  sed -i 's|"10": "10"|"10": "十"|' "$MODULES"
elif [[ "$THEME" == "atomic" ]]; then
  sed -i 's|"1": "一"|"1": "1"|; s|"2": "二"|"2": "2"|; s|"3": "三"|"3": "3"|' "$MODULES"
  sed -i 's|"4": "四"|"4": "4"|; s|"5": "五"|"5": "5"|; s|"6": "六"|"6": "6"|' "$MODULES"
  sed -i 's|"7": "七"|"7": "7"|; s|"8": "八"|"8": "8"|; s|"9": "九"|"9": "9"|' "$MODULES"
  sed -i 's|"10": "十"|"10": "10"|' "$MODULES"
fi

# 10. Neovim: write theme name for nvim to pick up on launch
NVIM_THEME_MAP_vaporwave="tokyonight-night"
NVIM_THEME_MAP_atomic="atomic"
nvim_theme_var="NVIM_THEME_MAP_${THEME}"
NVIM_THEME="${!nvim_theme_var}"
mkdir -p "$CONFIG_DIR/nvim"
echo "$NVIM_THEME" >"$CONFIG_DIR/nvim/.theme"

echo "Config files updated. Reloading services..."

# Restart waybar (kill + relaunch, same as sway uses via swaybar_command)
"$CONFIG_DIR/waybar/scripts/launch.sh"

# Reload sway (picks up theme include + swaylock config)
swaymsg reload 2>/dev/null || true

# Re-apply gaps (reload doesn't apply to existing workspaces)
swaymsg gaps inner all set 10 2>/dev/null || true

# Reload swaync styles
swaync-client --reload-css 2>/dev/null || true

# Signal kitty to reload config (SIGUSR1)
pkill -USR1 kitty 2>/dev/null || true

echo "Theme switched to: $THEME"
