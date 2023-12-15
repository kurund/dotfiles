return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function(lazy, opts)
      local telescope = require('telescope')
      telescope.load_extension('fzf')
      telescope.setup({
        defaults = {
          wrap_result = true,
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              -- search history
              ["<C-Down>"] = require('telescope.actions').cycle_history_next,
              ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
              -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
              ["<C-j>"] = require('telescope.actions').move_selection_next,
            },
          },
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              width = 0.9,
              preview_cutoff = 10,
            }
          }
        },
        pickers = {
          -- note: remove the 'builtin.' prefix.
          ["lsp_references"] = { wrap_results = true, },
          ["lsp_definitions"] = { wrap_results = true, },
          ["diagnostics"] = { wrap_results = true, },
          ["find_files"] = { wrap_results = true, },
          ["live_grep"] = {
            additional_args = function(opts)
              return { "--no-ignore-vcs" }
            end
          },
          ["buffers"] = {
            sort_lastused = true,
            sort_mru = true,
            ignore_current_buffer = false,
            mappings = {
              n = {
                ['<C-c>'] = require('telescope.actions').delete_buffer
              }, -- n
              i = {
                ["<C-h>"] = "which_key",
                ['<C-c>'] = require('telescope.actions').delete_buffer
              } -- i
            },
          }
        }
      })
    end,

    keys = {
      -- See :help telescope.builtin
      {
        '<leader>fo',
        function()
          require("telescope.builtin").oldfiles {
            prompt_title = 'Recent files',
            sort_mru = true
          }
        end,
        desc = "Old (recent) files"
      },
      { '<leader><space>', '<cmd>Telescope buffers<cr>',        desc = "Buffers" },
      { '<leader>t',       '<cmd>Telescope resume<cr>',         desc = "Resume last telescope" },
      { '<leader>b',       '<cmd>Telescope buffers<cr>',        desc = "Buffers" },
      { 'gr',              '<cmd>Telescope lsp_references<cr>', desc = "LSP References for word under cursor" },

      { '<leader>ff',      '<cmd>Telescope find_files<cr>',     desc = "Find filenames" },
      { '<leader>fm',      '<cmd>Telescope marks<cr>',          desc = "Marks" },
      { '<leader>fw',      '<cmd>Telescope live_grep<cr>',      desc = "Grep files" },
      { '<leader>ld',      '<cmd>Telescope diagnostics<cr>',    desc = "diagnostics" },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").live_grep {
            prompt_title = 'grep open files',
            grep_open_files = true }
        end,
        desc = "Grep open files"
      },
      { "<leader>fc", function() require("telescope.builtin").current_buffer_fuzzy_find() end,                          desc = "Grep this file" },
      { "<leader>:",  function() require("telescope.builtin").command_history { prompt_title = 'Command history' } end, desc = "cmd history" },
      {
        "<leader>ls",
        function()
          local aerial_avail, _ = pcall(require, "aerial")
          if aerial_avail then
            require("telescope").extensions.aerial.aerial()
          else
            require("telescope.builtin").lsp_document_symbols()
          end
        end,
        desc = "Search symbols"
      },
    }
  }
}
