#!/usr/bin/env bash
# macOS Theme switcher
# Usage: theme-switch-macos.sh <theme>   (e.g. vaporwave, atomic)
#        theme-switch-macos.sh           (opens picker dialog)

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
THEMES=("vaporwave" "atomic")

pick_theme() {
  # Use osascript to show a dialog picker (no rofi on macOS)
  local list
  list=$(printf '%s, ' "${THEMES[@]}" | sed 's/, $//')
  osascript -e "choose from list {$(printf '\"%s\", ' "${THEMES[@]}" | sed 's/, $//')} with prompt \"Select Theme\" default items {\"$(cat "$CONFIG_DIR/sketchybar/colors/.current_theme" 2>/dev/null || echo "atomic")\"}" 2>/dev/null | tr -d '\n'
}

THEME="${1:-$(pick_theme)}"

if [[ -z "$THEME" ]] || [[ "$THEME" == "false" ]]; then
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

# 1. SketchyBar: symlink current color source
ln -sf "${THEME}.sh" "$CONFIG_DIR/sketchybar/colors/current.sh"
echo "$THEME" >"$CONFIG_DIR/sketchybar/colors/.current_theme"

# 2. Kitty: change include in kitty.conf (macOS sed uses -i '')
sed -i '' "s|^include .*\.conf$|include ${THEME}.conf|" "$CONFIG_DIR/kitty/kitty.conf"

# 3. JankyBorders: update colors and reload
source "$CONFIG_DIR/sketchybar/colors/${THEME}.sh"
cat >"$CONFIG_DIR/borders/bordersrc" <<EOF
#!/usr/bin/env bash
# JankyBorders — ${THEME} theme window borders

borders active_color=${BORDER_ACTIVE} \\
        inactive_color=${BORDER_INACTIVE} \\
        width=2.0 \\
        style=round \\
        hidpi=on
EOF

# 4. Btop: change color_theme
if [ -f "$CONFIG_DIR/btop/btop.conf" ]; then
  sed -i '' "s|^color_theme = \".*\"|color_theme = \"${THEME}\"|" "$CONFIG_DIR/btop/btop.conf"
fi

# 5. Neovim: write theme name for nvim to pick up on launch
NVIM_THEME_MAP_vaporwave="tokyonight-night"
NVIM_THEME_MAP_atomic="atomic"
nvim_theme_var="NVIM_THEME_MAP_${THEME}"
NVIM_THEME="${!nvim_theme_var}"
mkdir -p "$CONFIG_DIR/nvim"
echo "$NVIM_THEME" >"$CONFIG_DIR/nvim/.theme"

echo "Config files updated. Reloading services..."

# 6. Restart SketchyBar
brew services restart sketchybar 2>/dev/null || true

# 7. Restart JankyBorders
brew services restart borders 2>/dev/null || true

# 8. Signal Kitty to reload config (SIGUSR1)
pkill -USR1 kitty 2>/dev/null || true

echo "Theme switched to: $THEME"
