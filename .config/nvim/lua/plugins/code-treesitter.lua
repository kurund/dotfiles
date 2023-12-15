return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- support the matchup plugin (see other lua file)
        matchup = {
          enable = true,
        },
        highlight = {
          enable = true,

          -- additional_vim_regex_highlighting
          -- =================================
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = true,
        },
        -- -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
        -- You EITHER set additional_vim_regex_highlighting OR set the below
        -- indent = {
        -- 	enable = false
        -- },
        -- :help nvim-treesitter-textobjects-modules
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            }
          },
        },
        ensure_installed = {
          'javascript',
          'html',
          'svelte',
          'vue',
          'lua',
          'css',
          'scss',
          'php',
          'json',
          'query', -- for playground
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,   -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      })
    end
  },
  { 'nvim-treesitter/nvim-treesitter-context', config = true }
}
