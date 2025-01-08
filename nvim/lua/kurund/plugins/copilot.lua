return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          javascript = true,
          typescript = true,
          lua = true,
          html = true,
          css = true,
          php = true,
          python = true,
          ['*'] = false, -- disable for all other filetypes and ignore default `filetypes`
        },
        copilot_node_command = 'node',
        server_opts_overrides = {},
      }
    end,
  },
  {
    'giuxtaposition/blink-cmp-copilot',
  },
  {
    'AndreM222/copilot-lualine',
    config = function() end,
  },
}
