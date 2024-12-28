return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        mode = 'tabs',
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
    }
  end,
}
