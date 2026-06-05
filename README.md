## My dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Each top-level
folder is a stow "package" that mirrors its path under `$HOME`, e.g.
`niri/.config/niri/config.kdl` → `~/.config/niri/config.kdl`.

### Install

```sh
./bootstrap.sh            # symlink everything that's installed
./bootstrap.sh -n         # dry-run: show what would change, touch nothing
```

`bootstrap.sh` only links a package if its application is actually present
(checked with `command -v`), so the same repo works on Linux and macOS and
stale configs are skipped automatically. It's safe to re-run any time —
install a new app, run it again, and only that package gets linked.

To add a new app: create `pkg/.config/pkg/...` (or whatever path it needs
under `$HOME`), add a `[pkg]="binary"` line to the manifest in `bootstrap.sh`,
and run `./bootstrap.sh`.

The **greetd** login screen lives in `/etc` (root-owned) and is _not_
stow-managed — see [`greetd/`](greetd/) and run `greetd/install.sh`.

### Current setup

- NeoVim editor
- Tmux multiplexer
- Kitty / Ghostty terminals
- niri (Wayland compositor)
- Waybar, swaync, swaylock, rofi, wlogout, cava
- greetd + ReGreet login screen

### Past configs

- Sway, Hyprland
- Starship shell prompt
- Zellij multiplexer
- Wezterm terminal
