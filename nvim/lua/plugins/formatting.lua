return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      phpcbf = function()
        return {
          command = vim.env.HOME .. "/.config/composer/vendor/bin/phpcbf",
          args = { "--standard=" .. vim.g.php_standard },
          stdin = true,
        }
      end,
    },

    formatters_by_ft = {
      php = { "phpcbf" },
    },
  },
}
