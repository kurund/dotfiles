#!/usr/bin/env bash
#
# Symlink dotfiles into place with GNU stow.
#
# A package is only linked if its application is actually installed (or, for
# OS-specific packages, the OS matches). Safe to re-run any time: it restows
# everything detected, so newly installed apps get linked and the rest are
# no-ops. Stale/uninstalled apps are skipped.
#
# Usage:
#   ./bootstrap.sh            link everything detected
#   ./bootstrap.sh -n         dry-run (show what would change, touch nothing)
#
# Layout: every package mirrors its path under $HOME, e.g.
#   niri/.config/niri/config.kdl  ->  ~/.config/niri/config.kdl
#
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

DRY_RUN=0
case "${1:-}" in
-n | --dry-run) DRY_RUN=1 ;;
"") ;;
*)
  echo "usage: $0 [-n|--dry-run]" >&2
  exit 2
  ;;
esac

if ! command -v stow >/dev/null 2>&1; then
  echo "error: GNU stow is not installed." >&2
  echo "  Arch:  yay -S stow      macOS:  brew install stow" >&2
  exit 1
fi

# package:spec entries (kept as a plain list so this works on bash 3.2, which
# ships with macOS and lacks associative arrays). Spec is one of:
#   space-separated binary candidates (linked if ANY is found on PATH), or
#   OS:linux / OS:darwin to gate by operating system, or
#   always to link unconditionally.
PKGS=(
  "applications:OS:linux" # .desktop launchers, Linux only
  "cava:cava"
  "ghostty:ghostty"
  "herdr:herdr"
  "helix:hx helix"
  "hypr:hyprland"
  "kitty:kitty"
  "nvim:nvim"
  "niri:niri"
  "rofi:rofi"
  "starship:starship"
  "sway:sway"
  "swaylock:swaylock"
  "swaync:swaync"
  "tmux:tmux"
  "waybar:waybar"
  "waypaper:waypaper"
  "wezterm:wezterm"
  "wireplumber:wireplumber"
  "wlogout:wlogout"
  "zellij:zellij"
)

detected() {
  local spec="$1" bin
  case "$spec" in
  always) return 0 ;;
  OS:linux) [[ "$(uname)" == Linux ]] ;;
  OS:darwin) [[ "$(uname)" == Darwin ]] ;;
  *)
    for bin in $spec; do command -v "$bin" >/dev/null 2>&1 && return 0; done
    return 1
    ;;
  esac
}

linked=() skipped=()
for entry in "${PKGS[@]}"; do
  pkg="${entry%%:*}"
  spec="${entry#*:}"
  if detected "$spec"; then
    if [[ $DRY_RUN == 1 ]]; then
      stow -nv --target="$HOME" --restow "$pkg" 2>&1 | sed "s/^/  [$pkg] /" || true
    else
      stow -v --target="$HOME" --restow "$pkg"
    fi
    linked+=("$pkg")
  else
    skipped+=("$pkg")
  fi
done

echo
echo "Linked : ${linked[*]:-(none)}"
echo "Skipped: ${skipped[*]:-(none)}  (app not installed / wrong OS)"

# greetd lives in /etc (root-owned) and cannot be stowed; install separately.
if [[ "$(uname)" == Linux && -x ./greetd/install.sh ]]; then
  echo
  echo "Note: the greetd login screen is not stow-managed."
  echo "      Run ./greetd/install.sh to (re)install it."
fi

# wireplumber ships a udev rule (/etc) + user service for headphone auto-switch.
if [[ "$(uname)" == Linux && -x ./wireplumber/install.sh ]]; then
  echo
  echo "Note: the wireplumber headphone-jack udev rule is not stow-managed."
  echo "      Run ./wireplumber/install.sh to install it and enable the service."
fi
