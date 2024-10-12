-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- this contains custom autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable formatting
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting for all files.
    vim.g.disable_autoformat = true
  else
    -- FormatDisable just affects this buffer.
    vim.b.disable_autoformat = true
  end
  vim.notify 'Format on save is disabled.'
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

-- Enable formatting
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.notify 'Format on save is enabled.'
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- Set php coding standard: CiviCRM for PHP
-- refer: https://github.com/civicrm/coder
vim.api.nvim_create_user_command('CiviCRMStandard', function()
  vim.g.php_standard = 'Drupal'
  vim.notify 'CiviCRM coding standard is set.'
end, {
  desc = 'Set CiviCRM coding standard',
})

-- Set php coding standard: WordPress for PHP
-- refer: https://github.com/WordPress/WordPress-Coding-Standards
vim.api.nvim_create_user_command('WordPressStandard', function()
  vim.g.php_standard = 'WordPress'
  vim.notify 'WordPress coding standard is set.'
end, {
  desc = 'Set WordPress coding standard',
})
