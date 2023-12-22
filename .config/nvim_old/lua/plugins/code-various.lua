return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- -- -- -- -- -- -- -- -- toggler = {
      ---Line-comment toggle keymap
      -- line = '<leader>/',
      ---Block-comment toggle keymap
      -- block = '<leader>*',
      -- },
      mappings = false,
    },
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, desc = "Comment line", noremap = true },
      {
        "<leader>/",
        function()
          local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
          vim.api.nvim_feedkeys(esc, 'nx', false)
          require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end,
        mode = 'x',
        desc = "Toggle comment line",
        noremap = true
      },
    }
  },
  { 'tpope/vim-surround' },
  { 'wellle/targets.vim' },
  { 'tpope/vim-repeat' },
  -- For aligning stuff, https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md start with a visual selection and ga or gA
  { 'echasnovski/mini.align',       branch = 'stable', config = function() require 'mini.align'.setup() end },
  { 'editorconfig/editorconfig-vim' },
}
