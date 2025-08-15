return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        phpcbf = function()
          return {
            cmd = vim.env.HOME .. "/.config/composer/vendor/bin/phpcbf",
            args = {
              "--standard=" .. vim.g.php_standard,
              "-q",
            },
            stdin = true,
          }
        end,
      },

      formatters_by_ft = {
        php = { "phpcbf" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        phpcs = function()
          return {
            cmd = vim.env.HOME .. "/.config/composer/vendor/bin/phpcs",
            args = {
              "--standard=" .. vim.g.php_standard,
              "-q",
              "--report=json",
            },
            stdin = true,
            parser = function(output)
              local ok, decoded = pcall(vim.fn.json_decode, output)
              if not ok then
                return {}
              end

              local diagnostics = {}
              for _, file in pairs(decoded.files or {}) do
                for _, msg in ipairs(file.messages or {}) do
                  table.insert(diagnostics, {
                    lnum = msg.line - 1,
                    col = msg.column - 1,
                    end_lnum = msg.endLine and msg.endLine - 1 or msg.line - 1,
                    end_col = msg.endColumn and msg.endColumn - 1 or msg.column - 1,
                    source = "phpcs",
                    message = msg.message,
                    severity = msg.type == "ERROR" and vim.lsp.protocol.DiagnosticSeverity.Error
                      or vim.lsp.protocol.DiagnosticSeverity.Warning,
                  })
                end
              end
              return diagnostics
            end,
          }
        end,
      },
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },
}
