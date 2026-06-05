# greetd + ReGreet login screen

The graphical login (display manager) for this machine: [greetd](https://git.sr.ht/~kennylevinsen/greetd)
running [ReGreet](https://github.com/rharish101/ReGreet) inside [cage](https://github.com/cage-kiosk/cage).
Replaces GDM with something lighter while still offering a session picker
(GNOME / niri / sway).

## Files

| File           | Installed to              | Purpose                                    |
| -------------- | ------------------------- | ------------------------------------------ |
| `config.toml`  | `/etc/greetd/config.toml` | greetd itself — runs `cage -s -- regreet`  |
| `regreet.toml` | `/etc/greetd/regreet.toml`| ReGreet config: background, GTK look, clock|
| `regreet.css`  | `/etc/greetd/regreet.css` | Custom theme (autumn rust over great-wall) |
| `wallpaper.jpg`| `/etc/greetd/wallpaper.jpg`| Pre-blurred login background               |

These live in `/etc` (root-owned), so they are **copied, not symlinked** like the
`~/.config` dotfiles. Re-run `install.sh` after editing to push changes.

## Install

```sh
./install.sh
```

Then reboot.

## Theming notes

- ReGreet has **no built-in blur** — the blur is baked into `wallpaper.jpg`.
  To regenerate from a source image:
  ```sh
  magick SOURCE.jpg -blur 0x22 -modulate 88,135 wallpaper.jpg
  ```
- GTK theme/icons/cursor in `regreet.toml` must be installed **system-wide**
  (`/usr/share/themes`, `/usr/share/icons`) — the `greeter` user can't read `~`.
- Icon theme is full `Adwaita` (not `AdwaitaLegacy`, which lacks the symbolic
  icons ReGreet draws next to the username/session fields).
- Palette in `regreet.css`: rust `#b5482c` accent on a deep reddish-brown card,
  sampled to match the autumn wallpaper.
- Preview changes without rebooting: `regreet --demo`

## Fallback

If the login screen fails to come up, switch to a TTY with `Ctrl+Alt+F2`, log in,
and restore GDM:

```sh
sudo systemctl disable greetd && sudo systemctl enable gdm && sudo systemctl start gdm
```
