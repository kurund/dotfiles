return {
  -- Project dropped: { 'phaazon/hop.nvim', branch = 'v2' }
  -- replacement:
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump2d.md
  {
    'echasnovski/mini.jump2d',
    version = false, -- '*', -- or version = false for more recent.
    config = function()
      require 'mini.jump2d'.setup({
        -- Options for visual effects
        view = {
          -- Whether to dim lines with at least one jump spot
          dim = true,
          -- How many steps ahead to show. Set to big number to show all steps.
          -- With this set it's nice as you can read what to type, but it makes it
          -- harder because you lose a lot of spaces etc. so the screen is completely unreadable.
          n_steps_ahead = 2,
        },
        allowed_lines = { -- these mean I can jump to the start of a line
          blank = true,
          fold = true,
        },
        allowed_windows = {
          not_current = true, -- might want to review this.
        },
        mappings = { start_jumping = '' }
      })
      vim.keymap.set('n', '<CR>',
        function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end)
    end
  },

  -- delete (close) buffers without affecting windows.
  { 'famiu/bufdelete.nvim' },

  {
    'Shatur/neovim-session-manager',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local Path = require('plenary.path')
      require('session_manager').setup({
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),               -- The directory where the session files will be saved.
        path_replacer = '__',                                                      -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++',                                                     -- The character to which the colon symbol will be replaced for session files.
        -- autoload_mode = require('session_manager.config').AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,                                              -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true,                                         -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {},                                                 -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                                              -- All buffers of these file types will be closed before the session is saved.
          'gitcommit', 'neo-tree'
        },
        autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      })
    end,
  },

  {
    's1n7ax/nvim-window-picker',
    config = true,
    -- tag = 'v1.*',
  },

  -- colours
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = false,       -- "Name" codes like Blue or blue
        RRGGBBAA = false,    -- #RRGGBBAA hex codes
        AARRGGBB = false,    -- 0xAARRGGBB hex codes
        rgb_fn = true,       -- CSS rgb() and rgba() functions
        hsl_fn = true,       -- CSS hsl() and hsla() functions
        css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        -- sass = { enable = false, parsers = { css }, }, -- Enable sass colors
        virtualtext = "■",
      }
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
  },
  -- colour picker
  { 'uga-rosa/ccc.nvim',   config = true },

  -- resize/move windows.
  {
    "mrjones2014/smart-splits.nvim",
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
      'nofile',
      'quickfix',
      'prompt',
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { 'NvimTree' },
    -- the default number of lines/columns to resize by at a time
    default_amount = 3,
    -- whether to wrap to opposite side when cursor is at an edge
    -- e.g. by default, moving left at the left edge will jump
    -- to the rightmost window, and vice versa, same for up/down.
    -- 'wrap'|'split'|'stop'
    at_edge = "stop",
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers. False by default.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
    -- resize mode options
    resize_mode = {
      -- key to exit persistent resize mode
      quit_key = '<ESC>',
      -- keys to use for moving in resize mode
      -- in order of left, down, up' right
      resize_keys = { 'h', 'j', 'k', 'l' },
      -- set to true to silence the notifications
      -- when entering/exiting persistent resize mode
      silent = false,
      -- must be functions, they will be executed when
      -- entering or exiting the resize mode
      hooks = {
        on_enter = nil,
        on_leave = nil
      }
    },
    -- ignore these autocmd events (via :h eventignore) while processing
    -- smart-splits.nvim computations, which involve visiting different
    -- buffers and windows. These events will be ignored during processing,
    -- and un-ignored on completed. This only applies to resize events,
    -- not cursor movement events.
    ignored_events = {
      'BufEnter',
      'WinEnter',
    },
    -- enable or disable the tmux integration
    tmux_integration = false,
    -- disable tmux navigation if current tmux pane is zoomed
    disable_tmux_nav_when_zoomed = false,

    keys = {
      { '<A-h>', function() require('smart-splits').resize_left() end,       desc = "resize left" },
      { '<A-j>', function() require('smart-splits').resize_down() end,       desc = "resize right" },
      { '<A-k>', function() require('smart-splits').resize_up() end,         desc = "resize up" },
      { '<A-l>', function() require('smart-splits').resize_right() end,      desc = "resize right" },
      -- moving between splits
      { '<C-h>', function() require('smart-splits').move_cursor_left() end,  desc = "move left" },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end,  desc = "move down" },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end,    desc = "move up" },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = "move right" },
    }
  },
  -- dim inactive windows 'sunjon/shade.nvim' :  2022-12-19 this crashes a lot
  { 'levouh/tint.nvim',      config = true },
  -- highlight word under cursor when you hover
  { 'RRethy/vim-illuminate' },

  -- find out which mapping does what.
  -- https://github.com/folke/which-key.nvim
  { "folke/which-key.nvim",  config = true },

  -- Not entirely sure, but think I missed this when it wasn't installed
  -- https://github.com/stevearc/dressing.nvim#alternative-and-related-projects
  { 'stevearc/dressing.nvim' },


  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1,  -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false,                -- disables the ruler text in the cmd line area
          showcmd = false,              -- disables the command in the last line of the screen
        },
        twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false },     -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        -- kitty = {
        --   enabled = false,
        --   font = "+4", -- font size increment
        -- },
      },
      -- callback where you can add custom code when the Zen window opens
      -- on_open = function(win)
      -- end,
      -- callback where you can add custom code when the Zen window closes
      -- on_close = function()
      -- end,
    }
  },

  -- Remember previous yanks
  -- :Telescope neoclip
  -- then <c-p> paste, <c-k> paste-behind
  {
    'AckslD/nvim-neoclip.lua',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },

  -- Icon picker inc. emoji. :IconPickerNormal
  -- <C-e> in insert mode:IconPickerInsert (e for emoji) Was C-i but that's Tab!
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })

      -- vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
      -- vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      vim.keymap.set("i", "<C-e>", "<cmd>IconPickerInsert<cr>", opts)
    end,
  },
}
