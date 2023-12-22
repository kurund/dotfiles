return {
  {
    'Wansmer/sibling-swap.nvim',
    requires = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false },
  },
  -- Highlight matching pairs etc.
  {
    'andymass/vim-matchup',
    config = true
  },
  -- This one works but bit crude, doesn't use treesitter: { 'monkoose/matchparen.nvim', opts = {} },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '➤' },
        topdelete = { text = '➤' },
        changedelete = { text = '▎' },
      }
    },
  },
  { 'tpope/vim-fugitive' },
  -- refactoring (do
  -- { 'ThePrimeagen/refactoring.nvim', config = function () require 'plugins.refactoring' end },
  {
    "stevearc/aerial.nvim",
    opts = {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end
    },
    keys = {
      { '<leader>lS', '<cmd>AerialToggle!<CR>}' },
    },
  },
  -- auto-create matching bracket etc.
  -- https://github.com/windwp/nvim-autopairs
  { "windwp/nvim-autopairs",  config = true, },
  -- auto-create matching HTML tags etc.
  -- https://github.com/windwp/nvim-ts-autotag
  { "windwp/nvim-ts-autotag", config = true },
  -- move selection, lines around with shift-arrow-keys
  {
    'echasnovski/mini.move',
    version = false,
    config = function(l, opts) require 'mini.move'.setup(opts) end,
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left       = '<S-left>',
        right      = '<S-right>',
        down       = '<S-down>',
        up         = '<S-up>',

        -- Move current line in Normal mode
        line_left  = '<S-left>',
        line_right = '<S-right>',
        line_down  = '<S-down>',
        line_up    = '<S-up>',
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    }
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    -- opts = {}
  },
  -- allows easier pattern of copy some text, repeatedly paste it over
  -- other places. Mapped to <leader>p
  {
    "gbprod/substitute.nvim",
    opts = {}
  }
}
