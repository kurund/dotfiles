return {
  -- Highlight, edit, and navigate code
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'php',
      'elixir',
      'typescript',
      'tsx',
      'javascript',
      'svelte',
      'graphql',
      'dockerfile',
      'python',
      'css',
      'json',
      'yaml',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    -- register additional file extensions
    vim.filetype.add {
      extension = {
        mdx = 'mdx',
        module = 'module', -- drupal module
        inc = 'php',
      },
    }

    -- consider .mdx as markdown
    vim.treesitter.language.register('markdown', 'mdx')
    -- consider .module files as php files
    vim.treesitter.language.register('php', 'module')
    -- consider .inc files as php files
    vim.treesitter.language.register('php', 'inc')
  end,

  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
