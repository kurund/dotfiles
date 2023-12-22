return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "css",
      "gitignore",
      "graphql",
      "php",
      "rust",
      "scss",
      "sql",
      "svelte",
      "http",
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- MDX
    vim.filetype.add({
      extension = {
        mdx = "mdx",
        module = "module",
        inc = "php",
      },
    })
    vim.treesitter.language.register("markdown", "mdx")
    vim.treesitter.language.register("php", "module")
    vim.treesitter.language.register("php", "inc")
  end,
}
