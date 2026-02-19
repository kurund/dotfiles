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

# 1. Waybar: change @import in style.css
sed -i "s|^@import \".*\.css\";|@import \"${THEME}.css\";|" "$CONFIG_DIR/waybar/style.css"

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

echo "Config files updated. Reloading services..."

# Reload sway (picks up theme include + swaylock config)
swaymsg reload 2>/dev/null || true

# Restart waybar
pkill waybar 2>/dev/null || true
sleep 0.3
waybar &
disown

# Reload swaync styles
swaync-client --reload-css 2>/dev/null || true

# Signal kitty to reload config (SIGUSR1)
pkill -USR1 kitty 2>/dev/null || true

echo "Theme switched to: $THEME"
