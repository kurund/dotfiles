return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
    -- opts = {
    --   transparent = true,
    --   styles = {
    --     sidebars = 'transparent',
    --     floats = 'transparent',
    --   },
    -- },
  },

  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local settransparancy = function()
        if (vim.uv or vim.loop).os_uname().sysname == 'Darwin' then
          return false
        end
        return true
      end

      require('nord').setup {
        transparent = settransparancy(),
      }
      -- vim.cmd.colorscheme 'nord'
    end,
  },

  {
    'rose-pine/neovim',
    priority = 1000,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
          transparent = true,
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
}