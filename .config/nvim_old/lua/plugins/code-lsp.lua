return {
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    -- See :help mason-settings
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      -- See :help mason-lspconfig-settings
      ensure_installed = {
        -- 'tsserver',
        -- 'html',
        -- 'cssls',
        -- 'intelephense',
        -- 'lua_ls'
        -- 'eslint',
      }
    },
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      -- lsp_defaults.capabilities = vim.tbl_deep_extend(
      --   'force',
      --   lsp_defaults.capabilities,
      --   require('cmp_nvim_lsp').default_capabilities()
      -- )

      ---
      -- Diagnostic customization
      ---
      local sign = function(opts)
        -- See :help sign_define()
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = ''
        })
      end

      sign({ name = 'DiagnosticSignError', text = '' })
      sign({ name = 'DiagnosticSignWarn', text = '▲' })
      sign({ name = 'DiagnosticSignHint', text = '⚑' })
      sign({ name = 'DiagnosticSignInfo', text = '' })

      -- See :help vim.diagnostic.config()
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
      )

      ---
      -- LSP servers
      ---
      local default_handler = function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({})
      end

      -- See :help mason-lspconfig-dynamic-server-setup
      require('mason-lspconfig').setup_handlers({
        default_handler,
        ['tsserver'] = function()
          lspconfig.tsserver.setup({
            settings = {
              completions = {
                completeFunctionCalls = true
              }
            }
          })
        end,
        lua_ls = function()
          require('plugins.lsp.lua_ls')
        end,
        intelephense = function()
          lspconfig.intelephense.setup({
            -- Looks like root_dir has to be a function that takes the filename and returns the root.
            -- This function I made searches up the filepath for each option in turn,
            -- so if you have a .thisIsDocRoot somewhere in the hierarchy this is used in preference
            -- to a deeper .git, for example.
            root_dir = function(startPath)
              local rp = (require 'lspconfig.util').root_pattern
              for _, pattern in pairs({ ".thisIsDocRoot", ".env", "index.php", ".git", "node_modules",
                "index.php",
                "composer.json" }) do
                local found = rp({ pattern })(startPath)
                -- print(pattern, found)
                if (found and found ~= '') then return found end
              end
              return nil
            end,
            settings = {
              editor = {
                tabSize = 2,
                -- spaces not tabs
                insertSpaces = true,
                -- the detection is annoying, but this line doesn't seem to stop it.
                -- detectIndentation = false,
              },
              -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
              intelephense = {
                files = { associations = { "*.php", "*.module", "*.inc" } },
                format = { braces = "k&r" }, -- alternative values: psr12 or allman
                -- references = { exclude = { "naafin" } }, -- normally it is { "**\/vendor\/**" }
              },
            },
          })
        end
      })
    end
  },
  { 'nvim-lua/lsp-status.nvim' },
  -- signature help
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      debug = false,                                              -- set to true to enable debug logging
      log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false,                                            -- show debug line number

      bind = true,                                                -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 10,                                             -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      max_height = 12,                       -- max height of signature floating_window
      max_width = 80,                        -- max_width of signature floating_window
      noice = false,                         -- set to true if you using noice to render markdown
      wrap = true,                           -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

      floating_window = true,                -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1, -- adjust float windows x position.
      -- can be either a number or function
      floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
      -- can be either number or function, see examples

      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
      },

      always_trigger = false,     -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil,     -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {},   -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200,               -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = '',               -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil,         -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36,          -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black',     -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200,       -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil,           -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

      select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil,      -- imap, use nvim_set_current_win to move cursor between current win and floating
    }
  },
  -- diagnostics listing
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      local standard = 'Drupal'
      --local standard = 'WordPress'
      conform.setup({
        log_level = vim.log.levels.DEBUG,
        formatters = {
          phpcbf = {
            command = "/home/kurund/.config/composer/vendor/bin/phpcbf",
            args = { "--standard=" .. standard }
          }
        },
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          php = { "phpcbf" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  }
}
