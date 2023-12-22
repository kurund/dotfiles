return {
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    lazy = false,    -- ensure this is loaded
    priority = 1000, -- and loaded v early.
    opts = function()
      return {
        -- Main options --
        style = 'darker',                                                                    -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        -- toggle theme style (does not seem to work) ---
        toggle_style_key = '<leader>q',                                                      -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- redefine colours defined in https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
        colors = {
          black = "#000000",
          bg0 = "#0a0a0a",
          bg1 = "#222120",
        },

        -- redefine which colours are used by highlights, defined in https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua
        highlights = {
          CursorLine = { bg = '$bg1' },
          -- did not work: Comment = { ... }
          -- this works: (I thnk the @ thing is a treesitter thing)
          ['@comment'] = { fg = '#eeddbb' },

          -- this does not work (trying to colour fenced code blocks in md)
          ['@none'] = { fg = '#f7edd9' }, -- code fence.
          ['@text.literal'] = { fg = '#ffeecc' },
          -- TextLiteral = { fg = '#ffeecc'},

          Search = { bg = '#002434', fg = '#22eeff' },
          CurSearch = { bg = '#004e71', fg = '#8df6ff' },

          -- matchup plugin
          MatchParen = { bg = '#0b4c1f', fg = '#79ec9d' },
          MatchParenCur = { bg = '#10702e', fg = '#ffffff' },

          NotifyBackground = { bg = "#ffffff" }
        },
      }
    end
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    priority = 1000,
  }
}
