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
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- MDX
    vim.filetype.add({
      extension = {
        mdx = "mdx",
      },
    })
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
