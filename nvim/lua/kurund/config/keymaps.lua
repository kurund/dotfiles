-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Increment or decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- save file
keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- quit file
keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- save file without auto-formatting
keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- delete single character without copying to register, so that paste does not use that
keymap.set('n', 'x', '"_x', opts)

-- Keep last yanked when pasting
keymap.set('v', 'p', '"_dP', opts)

-- Find and center
keymap.set('n', 'n', 'nzzzv', opts)
keymap.set('n', 'N', 'Nzzzv', opts)

-- Vertical scroll and center
keymap.set('n', '<C-d>', '<C-d>zz', opts)
keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Resize with arrows
keymap.set('n', '<Up>', ':resize -2<CR>', opts)
keymap.set('n', '<Down>', ':resize +2<CR>', opts)
keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Tabs
keymap.set('n', 'te', ':tabedit', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<s-tab>', ':tabprev<Return>', opts)

-- Stay in indent mode
keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)

-- Window management
keymap.set('n', 'ss', ':split<Return>', opts) -- split window horizontally
keymap.set('n', 'sv', ':vsplit<Return>', opts) -- split window vertically
keymap.set('n', 'se', '<C-w>=', opts) -- make split windows equal width & height
keymap.set('n', 'xs', ':close<CR>', opts) -- close current split window

-- quick fix navigation
keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- moving lines up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
