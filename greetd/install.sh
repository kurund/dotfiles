#!/usr/bin/env bash
# Install the greetd + ReGreet login screen from this dotfiles folder.
# Unlike the ~/.config dotfiles, greetd lives in /etc and needs root, so we
# copy (not symlink) the files into place.
#
# Usage:  ./install.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ":: Installing packages (yay)"
yay -S --needed --noconfirm greetd greetd-regreet cage

echo ":: Copying configs to /etc/greetd"
sudo install -Dm644 "$DIR/config.toml"   /etc/greetd/config.toml
sudo install -Dm644 "$DIR/regreet.toml"  /etc/greetd/regreet.toml
sudo install -Dm644 "$DIR/regreet.css"   /etc/greetd/regreet.css
sudo install -Dm644 "$DIR/wallpaper.jpg" /etc/greetd/wallpaper.jpg

echo ":: Setting up the greeter user"
# ReGreet runs as the 'greeter' user (created by the greetd package). It needs
# access to the GPU/input/seat and writable cache + log dirs.
sudo usermod -aG video,input,seat greeter
sudo install -d -o greeter -g greeter /var/cache/regreet /var/log/regreet

echo ":: Enabling greetd (replaces the current display manager)"
sudo systemctl disable gdm.service 2>/dev/null || true
sudo systemctl enable greetd.service

echo
echo "Done. Reboot to use the new login screen."
echo "Fallback if it fails: Ctrl+Alt+F2, log in, then:"
echo "    sudo systemctl disable greetd && sudo systemctl enable gdm && sudo systemctl start gdm"
