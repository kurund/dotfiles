-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local env_var_nvim_theme = os.getenv("NVIM_THEME") or "tokyonight-night"
vim.cmd.colorscheme(env_var_nvim_theme)

-- Define default php standard, Drupal in this case means CiviCRM
vim.g.php_standard = "Drupal"

-- Helper function to set PHP standard and notify
local function set_php_standard(standard, description)
  vim.api.nvim_create_user_command(standard .. "Standard", function()
    vim.g.php_standard = standard
    vim.notify(description .. " coding standard is set.")
  end, {
    desc = "Set " .. description .. " coding standard for PHP",
  })
end

-- Create user commands for different PHP standards
set_php_standard("Drupal", "CiviCRM (Drupal)")
set_php_standard("WordPress", "WordPress")

-- Remove autocommenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Remove autocommenting on new lines",
  group = vim.api.nvim_create_augroup("autocomment_disable", { clear = true }),
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})
