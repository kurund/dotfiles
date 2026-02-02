-- Copilot and CopilotChat - only enabled on macOS
local is_mac = vim.fn.has("macunix") == 1

return {
  { "zbirenbaum/copilot.lua", enabled = is_mac },
  { "fang2hou/blink-copilot", enabled = is_mac },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = is_mac },
}
