return {
  {
    -- theme switcher
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = { 'tokyonight', 'nord', 'rose-pine', 'catppuccin', 'onedark', 'bearded-theme' }, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      }
    end,
  },

  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    priority = 1000, -- Make sure to load this before all the other start plugins.
  },

  {
    'gbprod/nord.nvim',
    name = 'nord',
    priority = 1000,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
      }
    end,
  },

  {
    'xStormyy/bearded-theme.nvim',
    name = 'bearded-theme',
    priority = 1000,
  },
}
