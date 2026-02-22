#!/usr/bin/env bash
# macOS Atomic Theme — Install dependencies
# Usage: ./install.sh

set -euo pipefail

echo "Installing macOS Atomic Theme dependencies..."

# Add taps
brew tap FelixKratz/formulae
brew tap nikitabobko/tap

# Install AeroSpace (tiling WM)
brew install --cask nikitabobko/tap/aerospace

# Install SketchyBar, JankyBorders, and CLI tools
brew install sketchybar borders nowplaying-cli blueutil jq

# Install Nerd Font
brew install --cask font-jetbrains-mono-nerd-font

echo ""
echo "Installation complete!"
echo ""
echo "Symlink configs to ~/.config/:"
echo "  ln -sf $(pwd)/../aerospace ~/.config/aerospace"
echo "  ln -sf $(pwd)/../sketchybar ~/.config/sketchybar"
echo "  ln -sf $(pwd)/../borders ~/.config/borders"
echo ""
echo "Make all scripts executable:"
echo "  chmod +x ~/.config/sketchybar/sketchybarrc"
echo "  chmod +x ~/.config/sketchybar/items/*.sh"
echo "  chmod +x ~/.config/sketchybar/plugins/*.sh"
echo "  chmod +x ~/.config/sketchybar/colors/*.sh"
echo "  chmod +x ~/.config/borders/bordersrc"
echo ""
echo "Start services:"
echo "  brew services start sketchybar"
echo "  brew services start borders"
echo "  open -a AeroSpace"
