local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("plugins", {})

-- like this because of some weird treesitter bug.
vim.cmd("colorscheme " .. "onedark")

-- This disables the builtin matchparen plugin which causes frustrating slowness moving around big files.
vim.g.loaded_matchparen = 1
-- vim.cmd('NoMatchParen');

vim.opt.number = true
-- vim.opt.mouse = 'a'
vim.opt.mouse = ''
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.scrolloff = 1  -- keep 1 line in view while scrolling
vim.opt.laststatus = 2 -- ???
vim.opt.cmdheight = 1  -- space allowed for command line, without this you get a lot of Hit ENTER... prompts.

-- vim.g.matchparen_timeout = 20
-- vim.g.matchparen_insert_timeout = 20


local group = vim.api.nvim_create_augroup('mapping_cmds', { clear = true })

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set('x', '<S-t>', ":'<,'>s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
vim.keymap.set('n', '<S-t>', ":s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
vim.keymap.set('x', '`', "di```<Enter>```<Enter><Enter><Esc>kkP", { desc = "Wrap in Markdown codefences" })

-- no hls
vim.keymap.set('n', "<Leader><CR>", ":noh<CR>", { desc = "Hide hlsearch" })

-- prevent me typing q: when I mean :q
vim.keymap.set('n', 'q:', ':q')

-- Basic clipboard interaction - ctrl-c  =copy
vim.keymap.set({ 'n', 'x' }, '<C-c>', '"+y', { desc = 'Clipbaord copy' })
-- vim.keymap.set({'n', 'x'}, '', '"+p', {desc = 'Clipbaord paste'})

-- Delete text to blackhole register _ - not sure why this was considered useful.
-- vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader><S-c>', '<cmd>Bdelete<cr>', { desc = "✕ buff+win" })
vim.keymap.set('n', '<leader>c', function() require('bufdelete').bufdelete(0, false) end, { desc = "✕ buf not win" })
vim.keymap.set('n', '<C-p>', '<cmd>buffer #<cr>', { desc = "Go to previous buffer" })

vim.keymap.set('n', '<M-,>', require('sibling-swap').swap_with_left, { desc = "swap left" })
vim.keymap.set('n', '<M-.>', require('sibling-swap').swap_with_right, { desc = "swap right" })

-- substitute.nvim
vim.keymap.set('n', '<leader>p', require('substitute').operator, { noremap = true })
vim.keymap.set('x', '<leader>p', require('substitute').visual, { noremap = true })

-- Move around
vim.keymap.set('n', "<C-M-j>", "2<C-e>")
vim.keymap.set('n', "<C-M-k>", "2<C-y>")
vim.keymap.set('n', "<C-M-h>", "5zh")
vim.keymap.set('n', "<C-M-l>", "5zl")

-- these work but I have <m-,> mapped to sibling-swap
-- vim.keymap.set('n', '<M-,>', '[m^zz', { desc = "Go to previous method" })
-- vim.keymap.set('n', '<M-.>', '$]m^zz', { desc = "Go to next method" })

-- Hop (plugin)
vim.keymap.set('n', "<leader>hl", ":HopLineStart<cr>", { desc = "Hop line start" })
vim.keymap.set('n', "<leader>hp", ":HopPattern<cr>", { desc = "Hop pattern" })
vim.keymap.set('n', "<leader>hw", ":HopWord<cr>", { desc = "Hop word" })
vim.keymap.set('n', "s", ":HopChar1AC<cr>")
vim.keymap.set('n', "S", ":HopChar1BC<cr>")

-- -- File manager
--
vim.keymap.set('n', "<leader>.", "<cmd>cd %:p:h<cr>") -- make this the current dir.
-- vim.keymap.set('n', "-", function()
--   local d = vim.fn.getreg('%')
--   if (d == '') then
--           d = vim.fn.getcwd();
--   end
--   vim.cmd("Neotree reveal_force_cwd " .. d)
-- end)
--
-- -- Telescope keymaps - see plugins/telescope
--
-- Session Manager
vim.keymap.set('n', "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>")
vim.keymap.set('n', "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>")
vim.keymap.set('n', "<leader>Sd", "<cmd>SessionManager! delete_session<cr>")
vim.keymap.set('n', "<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>")
-- -- LSP Info
vim.keymap.set('n', "<leader>li", "<cmd>LspInfo<cr>")
-- -- Toggle 'Trouble' plugin
vim.keymap.set('n', "<leader>lt", "<cmd>TroubleToggle document_diagnostics<cr>")
--
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- 'gr' mapped in telescope for lsp_references
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    -- bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'quickfix', 'qf' },
  group = group,
  command = 'nnoremap <buffer> <cr> <cr>'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  group = group,
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.showbreak = '›'
    vim.bo.textwidth = 80
    -- +1 keep one letter words on next line.
    -- +2 -n possibly nice support for indented numbered lists
    -- +c I DO want comments to wrap
    -- +j when joining lines, remove comment leader
    -- +o same for o and O (learn i_CTRL-U)
    -- +q Support gq
    -- +r I DO want comment leaders to be inserted
    -- +w trailing whitespace means a line continuation, otherwise end para. ??
    -- And specifically I don't want:
    -- -a no autoformat.
    -- -t I don't want to auto wrap at textwidth
    vim.bo.formatoptions = 'croqw21j'
    vim.keymap.set('n', 'j', 'gj', { buffer = true })
    vim.keymap.set('n', 'k', 'gk', { buffer = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'php' },
  group = group,
  callback = function()
    vim.opt.foldmethod = 'expr'
    -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.bo.autoindent = true;
    vim.bo.sw = 2;
    vim.bo.ts = 2;
  end
})
-- artfulrobot: Set up custom filetypes (for Drupal)
vim.filetype.add { extension = { module = "php", inc = "php" } }
