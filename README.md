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

- Nushell shell + Starship prompt
- NeoVim editor
- Jujutsu (jj) + side-by-side diffs via [delta](https://github.com/dandavison/delta)
- Tmux multiplexer
- Kitty / Ghostty terminals
- niri (Wayland compositor)
- Waybar, swaync, swaylock, rofi, wlogout, cava
- greetd + ReGreet login screen
- Herdr multiplexer

### Nushell

Config lives at `nushell/.config/nushell/` (`env.nu` for PATH and exported
variables, `config.nu` for settings, aliases and custom commands).

The prompt is [starship](starship/.config/starship.toml). Its nushell init
script hard-codes the path to the binary, so `env.nu` generates it into
`~/.cache/nushell/starship.nu` on first start instead of tracking it here.

On macOS nushell reads `~/Library/Application Support/nushell`, not
`~/.config/nushell`, so `bootstrap.sh` symlinks the former to the latter after
stowing. Nushell writes its history and plugin state next to the config, so
those files are gitignored.

To make it the login shell:

```sh
echo "$(command -v nu)" | sudo tee -a /etc/shells
chsh -s "$(command -v nu)"
```

### Jujutsu

`jj/.config/jj/config.toml` is shared across machines, so the identity in it is
the default. To commit as someone else on a given machine, drop an override in
`~/.config/jj/conf.d/` — that directory is read after `config.toml` and is not
stow-managed, so it stays machine-local:

```sh
mkdir -p ~/.config/jj/conf.d
cat > ~/.config/jj/conf.d/10-identity.toml <<'EOF'
[user]
name = "Kurund Jalmi"
email = "other@example.com"
EOF
```

Note that `jj config set --user` writes to the shared `config.toml`, not to
`conf.d/` — edit those files directly. For a per-repo rather than per-machine
split, use a conditional scope in `config.toml` instead:

```toml
[[--scope]]
--when.repositories = ["~/work"]
[--scope.user]
email = "work@example.com"
```

### Past configs

- Sway, Hyprland
- Zellij multiplexer
- Wezterm terminal
