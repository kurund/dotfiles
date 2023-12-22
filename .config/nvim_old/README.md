# My nvim config

I was using [Astronvim](https://astronvim.github.io/) but the constant updates caused a weekly re-learning of kepmaps, re-configuration, and hunting for fixes of new bugs. I wanted something I could controll the pace of; I don't mind trying new things, but I'd like to do so when I have the time, and not, say, in the middle of an urgent project. This began as a copy of [VonHeikemen](https://github.com/VonHeikemen/nvim-starter/tree/05-modular) but I've stripped out bits, added new bits, and replaced bits so I'm not sure how much of the original is left. But I'm very grateful for their well doocumented approach.

## Keymaps

Leader is space.

## Buffers

- <leader><space> switch buffers
- <leader>c close current buffer, maintaining window layout
- <leader>q close current buffer and its window
- <leader>lb switch to last edited buffer
- <leader>w write buffer (:w)

## Move around

- <C+Alt>J and K scroll up and down
- <leader>hl **L**ine start (hop)
- <leader>hw **W**ord hop
- <leader>hw **P**pattern hop
- s hop backwards to the next char you type
- S hop forwards to the next char you type

## File manager

- `-` open neotree, focus current file  
   in the tree view, means go up a level
- `w` use window picker to select where to open the file
- `<leader>e` toggle neotree
- ? in the tree view: help

## Session manager

- open vim in a dir to re-open the session from that dir previously
- Sl Ss Sd session load, save, delete.

## Telescope things

- <leader>fo Open recent files
- <leader>fs search current buffer
- <leader>fB search all open buffers
- <leader>fw ripgrep to find files.
- <leader>ff find files
- <leader>fd diagnostics
- Within the telescope UI, <c-up>, <c-down> move through previous searches.

## Other keybindings

- `<S-t>` strip trailing whitespace from selection/current line

# Other bits

- Colorscheme: Even darker onedark.darker
- intelliphense, DAP, dap-ui - for PHP Xdebug etc. .thisIsDocRoot detection.
- other lsp: mason for installing.
- Completion with nvim-cmp

## My todo.

- aerial is nice sometimes

done

- hop
- session load and save was nice
- dap?
- onedark
- buffdel leader c etc.
- neotree
- php: completion  docroot function hints inteliphense
- settings: relativenumber, hls, ..?
- how to select the first item on the popup menu of completions (plugins/nvim-cmp behaviour)
- moving up and down.

## Installation

Clone this into `~/.config/nvim`

Keep running `vim +PackerSync` until you get no errors and everything is installed!

Leader key: `Space`.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>a` | Select all text. |
| Normal | `cp` | Copy selected text to clipboard. |
| Normal | `cv` | Paste clipboard content. |
| Normal | `<Ctrl-g>` | Toggle the builtin terminal. |
| Normal | `K` | Displays hover information about the symbol under the cursor. |
| Normal | `gd` | Jump to the definition. |
| Normal | `gD` | Jump to declaration. |
| Normal | `gi` | Lists all the implementations for the symbol under the cursor. |
| Normal | `go` | Jumps to the definition of the type symbol |
| Normal | `gr` | Lists all the references. |
| Normal | `<Ctrl-k>` | Displays a function's signature information. |
| Normal | `<F2>` | Renames all references to the symbol under the cursor. |
| Normal | `<F3>` | Format code in current buffer. |
| Normal | `<F4>` | Selects a code action available at the current cursor position. |
| Visual | `<F4>` | Selects a code action available in the selected text. |
| Normal | `gl` | Show diagnostics in a floating window. |
| Normal | `[d` | Move to the previous diagnostic. |
| Normal | `]d` | Move to the next diagnostic. |

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Up>` | Move to previous item. |
| Insert | `<Down>` | Move to next item. |
| Insert | `<Ctrl-p>` | Move to previous item. |
| Insert | `<Ctrl-n>` | Move to next item. |
| Insert | `<Ctrl-u>` | Scroll up in documentation window. |
| Insert | `<Ctrl-f>` | Scroll down in documentation window. |
| Insert | `<Ctrl-e>` | Cancel completion. |
| Insert | `<Enter>` | Confirm completion. |
| Insert | `<Ctrl-d>` | Go to next placeholder in snippet. |
| Insert | `<Ctrl-b>` | Go to previous placeholder in snippet. |
| Insert | `<Tab>` | If completion menu is open, go to next item. Else, open completion menu. |
| Insert | `<Shift-Tab>` | If completion menu is open, go to previous item. |

## Plugin list

| Name | Description  |
| --- | --- |
| [packer.nvim](https://github.com/wbthomason/packer.nvim) | Plugin manager. |
| [onedark.vim](https://github.com/joshdick/onedark.vim) | Colorscheme based on Atom's default theme. |
| [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | Helper functions to show icons. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Pretty statusline. |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Shows indent guides in current file. |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder. |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Extension for telescope. Allows fzf-like syntax in searches. |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Shows indicators in gutter based on file changes detected by git. |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration into Neovim/Vim. |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Configures treesitter parsers. Provides modules to manipulate code. |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Creates textobjects based on treesitter queries. |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments. |
| [vim-surround](https://github.com/tpope/vim-surround) | Add, remove, change "surroundings". |
| [targets.vim](https://github.com/wellle/targets.vim) | Creates new textobjects. |
| [vim-repeat](https://github.com/tpope/vim-repeat) | Add "repeat" support for plugins. |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Collection of modules. Used internaly by other plugins. |
| [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) | Add support for [.editorconfig](https://editorconfig.org/) file. |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Manage terminal windows easily. |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim. |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Integrates nvim-lspconfig and mason.nvim. |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim's LSP client.  |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine. |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | nvim-cmp source. Suggest words in the current buffer. |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | nvim-cmp source. Show suggestions based on file system paths. |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | nvim-cmp source. Show suggestions based on installed snippets. |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source. Show suggestions based on LSP servers queries. |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine. |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Collection of snippets. |
| [bufdelete](https://github.com/famiu/bufdelete.nvim) | close buffer without messing up windows |


