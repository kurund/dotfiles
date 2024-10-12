-- set basic config
require 'kurund.config.options'
require 'kurund.config.keymaps'

-- [[ Custom Settings ]]
-- define default php standard, Drupal in this case means CiviCRM
vim.g.php_standard = 'Drupal'

-- add lazy and plugins
require 'kurund.config.lazy'

-- custom commands
require 'kurund.config.autocommands'

-- [[ set default colorschemes ]]
-- Available colorschemes:
--  * 'tokyonight-night'
--  * 'nord'
--  * 'rose-pine'

local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'tokyonight-night'
vim.cmd.colorscheme(env_var_nvim_theme)
