return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- auto tag
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = true,
  },
}
