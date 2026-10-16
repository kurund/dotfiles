# Nvim configuration

A single-file Neovim config (`init.lua`) using the built-in `vim.pack` plugin manager.

## Requirements

Install these before the first launch. Mason can't install them itself.

### macOS

```sh
brew install neovim git tree-sitter-cli node php composer luarocks fzf fd ripgrep lazygit
xcode-select --install
```

### NixOS

Add to `environment.systemPackages` (or `home.packages`):

```nix
neovim git tree-sitter gcc gnumake nodejs php phpPackages.composer
lua luarocks fzf fd ripgrep lazygit curl wget unzip gnutar gzip wl-clipboard
```

Mason and markdown-preview download prebuilt Linux binaries (efm, lua-language-server, stylua, shellcheck, shfmt, ruff, the preview server). NixOS can't run these without nix-ld:

```nix
programs.nix-ld.enable = true;
```

`wl-clipboard` is needed for the system clipboard under Wayland.

### Both

Also install [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and a [Nerd Font](https://www.nerdfonts.com) for the terminal.

| Tool                        | Used for                                                                         |
| --------------------------- | -------------------------------------------------------------------------------- |
| Neovim 0.12+, git           | `vim.pack`                                                                       |
| tree-sitter-cli, C compiler | building Treesitter parsers                                                      |
| node                        | prettierd, eslint_d, fixjson, pyright, bash/TypeScript/Tailwind language servers |
| php, composer               | phpactor, phpcbf, phpcs                                                          |
| luarocks                    | luacheck (Mason installs it through luarocks)                                    |
| fzf, fd, ripgrep            | fzf-lua pickers                                                                  |
| lazygit                     | `<leader>gg`                                                                     |

### PHP coding standards

phpcbf and phpcs are expected in `~/.config/composer/vendor/bin`:

```sh
composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
composer global require drupal/coder
composer global require --dev wp-coding-standards/wpcs
```

## Install

This lives in the dotfiles repo as the `nvim` stow package, so `./bootstrap.sh` links it to `~/.config/nvim`.

On the first launch:

- plugins install at the versions pinned in `nvim-pack-lock.json`
- Treesitter parsers build
- language servers, formatters and linters install through Mason (the `mason_packages` list in `init.lua`); progress shows as "Mason: installing ..."
- the markdown-preview server downloads

Restart Neovim once everything has finished installing.

Plugins, Mason tools and parsers live in `~/.local/share/nvim/`.

## After installing

- macOS: in Ghostty, add `macos-option-as-alt = left` to `~/.config/ghostty/config` so left Option works as Alt (mini.move, fzf-lua toggles). Right Option still types special characters such as `#`.

## Claude Code

[claudecode.nvim](https://github.com/coder/claudecode.nvim) connects the `claude` CLI to Neovim the same way the VS Code extension does: Claude sees the current file and selection, and its edits open as diffs to accept or reject.

- `<leader>ac` opens Claude in a terminal split.
- `Ctrl+,` jumps between the editor and Claude, opening Claude if needed.
- To use a `claude` session from another terminal, run `/ide` in it and pick Neovim.

## Adding tools

- **Formatter:** add it to `formatters_by_ft` in the conform setup, and to `mason_packages` if Mason provides it.
- **Linter:** add it to the efm `languages` and `filetypes`, and to `mason_packages`.
- **Language server:** add `vim.lsp.config(...)`, add it to `vim.lsp.enable`, and add its Mason package to `mason_packages`.
- **Snippets:** add VS Code style snippets to `snippets/<filetype>.json`.

## PHP

- Formatting (phpcbf) and linting (phpcs) use the Drupal standard by default. Switch with `:DrupalStandard` or `:WordPressStandard`.
- `<leader>cl` logs the variable under the cursor (or the visual selection) with `\Civi::log()->debug()`. The `clog` snippet does the same in insert mode.

## Handy keys

| Key                         | Action                                                                                              |
| --------------------------- | --------------------------------------------------------------------------------------------------- |
| `<leader>ff`                | Find files, including gitignored ones (skips `node_modules`, `wp-content/uploads`, `sites/*/files`) |
| `<leader>fF`                | Find all files                                                                                      |
| `<leader>fg`                | Live grep                                                                                           |
| `<leader>e`                 | File tree                                                                                           |
| `<leader>gg`                | Lazygit                                                                                             |
| `<leader>cp`                | Markdown preview in the browser                                                                     |
| `<leader>tm`                | Toggle in-editor markdown rendering                                                                 |
| `<leader>hs` / `<leader>hr` | Stage / discard hunk                                                                                |
| `<leader>tf`                | Toggle format on save                                                                               |
| `<leader>td`                | Toggle diagnostics (off by default)                                                                 |
| `<leader>ac`                | Toggle Claude Code                                                                                  |
| `<leader>as`                | Send selection to Claude (visual), add file (nvim-tree)                                             |
| `<leader>aa` / `<leader>ad` | Accept / reject Claude's proposed diff                                                              |

Press `<leader>` and wait to see everything else in which-key.
