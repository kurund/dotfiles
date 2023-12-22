-- This is the old config for sumneko_lua which does not seem to be available 14 feb 2023
-- renamed sumneko_lua  → lua_ls Apr 2023
local lspconfig = require('lspconfig')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        library = {
          -- Make the server aware of Neovim runtime files
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua'
        },
        checkThirdParty = false
      },
      telemetry = {
        enable = false
      },
    }
  }
})


