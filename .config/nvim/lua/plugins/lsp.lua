return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "intelephense",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local standard = "Drupal"
      -- local standard = 'WordPress'

      opts.formatters = {
        phpcbf = {
          command = "/home/kurund/.config/composer/vendor/bin/phpcbf",
          args = { "--standard=" .. standard },
        },
      }

      opts.formatters_by_ft = {
        ["php"] = { "phpcbf" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      }
    end,
  },
}
