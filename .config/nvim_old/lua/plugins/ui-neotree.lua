return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree', -- lazy load on this command.
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_gitignored = false,
        hide_by_name = {
          "node_modules"
        },
        hide_by_pattern = {
          "*.civix.php"
        }
      },
      window = {
        mappings = {
          ["-"] = "navigate_up",
          ["/"] = "none",
          ["g/"] = "fuzzy_finder",
        }
      },
      use_git_status_colors = false
    }
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = "Neotree toggle" },
    -- Reveal current file if saved; fallback to current working dir.
    {
      '-',
      function()
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
          reveal_file = vim.fn.getcwd();
        else
          local f = io.open(reveal_file, "r")
          if (f) then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute({
          reveal_file = reveal_file, reveal_force_cwd = true
        })
      end,
      desc = "Toggle Neotree for buffer"
    },
  }
}
