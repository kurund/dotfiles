-- Copilot and CopilotChat - only enabled on macOS
local is_mac = vim.fn.has("macunix") == 1

return {
  { "zbirenbaum/copilot.lua", enabled = is_mac },
  { "fang2hou/blink-copilot", enabled = is_mac },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = is_mac },

  -- On non-Mac systems, configure blink.cmp to not use copilot source
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      if not is_mac then
        -- Remove copilot from sources on non-Mac systems
        opts.sources = opts.sources or {}
        opts.sources.default = vim.tbl_filter(function(source)
          return source ~= "copilot"
        end, opts.sources.default or {})
        opts.sources.providers = opts.sources.providers or {}
        opts.sources.providers.copilot = nil
      end
    end,
  },
}
