return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
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
    config = function()
      require('catppuccin').setup {
        kitty = true,
        flavour = 'macchiato',
        highlight_overrides = {
          all = function(colors)
            return {
              CurSearch = { bg = colors.sky },
              IncSearch = { bg = colors.sky },
              CursorLineNr = { fg = colors.blue, style = { 'bold' } },
              DashboardFooter = { fg = colors.overlay0 },
              TreesitterContextBottom = { style = {} },
              WinSeparator = { fg = colors.overlay0, style = { 'bold' } },
              ['@markup.italic'] = { fg = colors.blue, style = { 'italic' } },
              ['@markup.strong'] = { fg = colors.blue, style = { 'bold' } },
              Headline = { style = { 'bold' } },
              Headline1 = { fg = colors.blue, style = { 'bold' } },
              Headline2 = { fg = colors.pink, style = { 'bold' } },
              Headline3 = { fg = colors.lavender, style = { 'bold' } },
              Headline4 = { fg = colors.green, style = { 'bold' } },
              Headline5 = { fg = colors.peach, style = { 'bold' } },
              Headline6 = { fg = colors.flamingo, style = { 'bold' } },
              rainbow1 = { fg = colors.blue, style = { 'bold' } },
              rainbow2 = { fg = colors.pink, style = { 'bold' } },
              rainbow3 = { fg = colors.lavender, style = { 'bold' } },
              rainbow4 = { fg = colors.green, style = { 'bold' } },
              rainbow5 = { fg = colors.peach, style = { 'bold' } },
              rainbow6 = { fg = colors.flamingo, style = { 'bold' } },
            }
          end,
        },
        color_overrides = {
          macchiato = {
            rosewater = '#F5B8AB',
            flamingo = '#F29D9D',
            pink = '#AD6FF7',
            mauve = '#FF8F40',
            red = '#E66767',
            maroon = '#EB788B',
            peach = '#FAB770',
            yellow = '#FACA64',
            green = '#70CF67',
            teal = '#4CD4BD',
            sky = '#61BDFF',
            sapphire = '#4BA8FA',
            blue = '#00BFFF',
            lavender = '#00BBCC',
            text = '#C1C9E6',
            subtext1 = '#A3AAC2',
            subtext0 = '#8E94AB',
            overlay2 = '#7D8296',
            overlay1 = '#676B80',
            overlay0 = '#464957',
            surface2 = '#3A3D4A',
            surface1 = '#2F313D',
            surface0 = '#1D1E29',
            base = '#0b0b12',
            mantle = '#11111a',
            crust = '#191926',
          },
        },
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          fzf = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          navic = { enabled = true, custom_bg = 'lualine' },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      }
    end,
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
        -- transparent = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      }
    end,
  },

  {
    'slugbyte/lackluster.nvim',
    name = 'lackluster-hack',
    priority = 1000,
  },
  { 'EdenEast/nightfox.nvim' },
}
