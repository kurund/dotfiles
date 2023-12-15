return {
  {
    'jiaoshijie/undotree',
    opts = {
      float_diff = false,
      layout = 'left_left_bottom',
      window = {
        winblend = 0,
      },
    },
    keys = {
      { '<leader>u', function() require('undotree').toggle() end, noremap = true, silent = true },
    }
  }
}
