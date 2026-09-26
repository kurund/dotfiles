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
#   OS:linux / OS:arch / OS:darwin to gate by operating system, or
#   always to link unconditionally.
PKGS=(
  "applications:OS:arch" # .desktop launchers for /opt installs, Arch only
  "cava:cava"
  "ghostty:ghostty"
  "herdr:herdr"
  "helix:hx helix"
  "jj:jj"
  "kitty:kitty"
  "nvim:nvim"
  "niri:niri"
  "nushell:nu"
  "rofi:rofi"
  "starship:starship"
  "tmux:tmux"
)

detected() {
  local spec="$1" bin
  case "$spec" in
  always) return 0 ;;
  OS:linux) [[ "$(uname)" == Linux ]] ;;
  OS:arch) [[ -f /etc/arch-release ]] ;;
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

# On macOS nushell looks for its config in ~/Library/Application Support/nushell
# rather than ~/.config/nushell, so point the former at the latter.
if [[ "$(uname)" == Darwin ]] && command -v nu >/dev/null 2>&1; then
  nu_xdg="$HOME/.config/nushell"
  nu_mac="$HOME/Library/Application Support/nushell"
  if [[ -L "$nu_mac" ]]; then
    : # already a symlink, assume ours
  elif [[ -e "$nu_mac" ]]; then
    echo
    echo "Note: $nu_mac exists and is not a symlink."
    echo "      Move it aside, then re-run to link it to $nu_xdg."
  elif [[ $DRY_RUN == 1 ]]; then
    echo
    echo "  [nushell] WOULD LINK: $nu_mac -> $nu_xdg"
  else
    ln -s "$nu_xdg" "$nu_mac"
    echo
    echo "LINK: $nu_mac -> $nu_xdg"
  fi
fi

# greetd lives in /etc (root-owned) and cannot be stowed; install separately.
# if [[ "$(uname)" == Linux && -x ./greetd/install.sh ]]; then
#   echo
#   echo "Note: the greetd login screen is not stow-managed."
#   echo "      Run ./greetd/install.sh to (re)install it."
# fi

# wireplumber ships a udev rule (/etc) + user service for headphone auto-switch.
# if [[ "$(uname)" == Linux && -x ./wireplumber/install.sh ]]; then
#   echo
#   echo "Note: the wireplumber headphone-jack udev rule is not stow-managed."
#   echo "      Run ./wireplumber/install.sh to install it and enable the service."
# fi
