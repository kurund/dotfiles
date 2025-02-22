-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- return early if formatting is disabled
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        print 'format_on_save is disabled'
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 10000,
        lsp_format = lsp_format_opt,
        async = false,
      }
    end,
    -- log_level = vim.log.levels.DEBUG,
    formatters = {
      phpcbf = function()
        -- set the appropriate path based on the OS
        local formatter_path = '/home/kurund/.config/composer/vendor/bin/phpcbf'
        if (vim.uv or vim.loop).os_uname().sysname == 'Darwin' then
          formatter_path = '/Users/kurund/.config/composer/vendor/bin/phpcbf'
        end

        return {
          command = formatter_path,
          args = { '--standard=' .. vim.g.php_standard },
          stdin = true,
        }
      end,
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      javascriptreact = { 'prettier', stop_after_first = true },
      typescriptreact = { 'prettier', stop_after_first = true },
      svelte = { 'prettier', stop_after_first = true },
      php = { 'phpcbf' },
      html = { 'prettier', stop_after_first = true },
      css = { 'prettier', stop_after_first = true },
      scss = { 'prettier', stop_after_first = true },
      json = { 'prettier', stop_after_first = true },
      jsonc = { 'prettier', stop_after_first = true },
      yaml = { 'prettier', stop_after_first = true },
      graphql = { 'prettier', stop_after_first = true },
      sh = { 'prettier', stop_after_first = true },
      markdown = { 'prettier', stop_after_first = true },
    },
  },
}
