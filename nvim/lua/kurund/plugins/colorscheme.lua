return {
  {
    -- theme switcher
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'tokyonight',
          'rose-pine',
          'catppuccin',
          'onedark',
          'bearded-theme',
          'oxocarbon',
          'solarized-osaka',
          'gruvbox-material',
          'mango',
        }, -- Your list of installed colorschemes.
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
    config = function()
      require('tokyonight').setup {
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
    end,
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
        colors = {
          black = '#000000',
          bg0 = '#0a0a0a',
          bg1 = '#222120',
        },
      }
    end,
  },

  {
    'xStormyy/bearded-theme.nvim',
    name = 'bearded-theme',
    priority = 1000,
  },

  {
    'nyoom-engineering/oxocarbon.nvim',
    name = 'oxocarbon',
    priority = 1000,
  },

  {
    'craftzdog/solarized-osaka.nvim',
    name = 'solarized-osaka',
    priority = 1000,
    config = function()
      require('solarized-osaka').setup {
        transparent = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      }
    end,
  },

  {
    'sainnhe/gruvbox-material',
    name = 'gruvbox-material',
    priority = 1000,
  },
}
