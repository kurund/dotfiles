#!/usr/bin/env bash
# Install the root-owned parts of the wireplumber package.
#
# The dotfiles under ~/.config and ~/.local/bin are symlinked by stow (via
# bootstrap.sh). The udev rule below lives in /etc and needs root, so it is
# copied (not symlinked), like greetd. It grants the active session read access
# to the headphone-jack input device that headphone-jack-watch.service watches.
#
# Usage:  ./install.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ":: Installing udev rule"
sudo install -Dm644 "$DIR/etc/udev/rules.d/60-headphone-jack-uaccess.rules" \
  /etc/udev/rules.d/60-headphone-jack-uaccess.rules

echo ":: Reloading udev and re-applying to input devices"
sudo udevadm control --reload
sudo udevadm trigger --subsystem-match=input --action=change

echo ":: Enabling and starting the jack-watch user service"
systemctl --user daemon-reload
systemctl --user enable --now headphone-jack-watch.service

echo
echo "Done. Plug/unplug headphones to test; HDMI/DP audio stays available."
