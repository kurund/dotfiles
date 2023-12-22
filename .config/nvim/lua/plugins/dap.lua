return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_setup = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {
      function(config)
        require('mason-nvim-dap').default_setup(config)
      end,
      php = function(config)
        local sourceDirectory = os.getenv("HOME") .. "/src/"
        local cmsPath = require("lazyvim.util.root").cwd() .. "/src"

        --- Check if a file or directory exists in this path
        local function exists(file)
          local ok, err, code = os.rename(file, file)
          if not ok then
            if code == 13 then
              -- Permission denied, but it exists
              return true
            end
          end
          return ok, err
        end

        --- Check if a directory exists in this path
        local function isdir(path)
          return exists(path .. "/")
        end

        -- check if it's WordPress or Drupal instance and set correct path
        if isdir(cmsPath .. "/wordpress") then
          cmsPath = cmsPath .. "/wordpress"
        elseif isdir(cmsPath .. "/drupal") then
          cmsPath = cmsPath .. "/drupal"
        end

        config.configurations = {
          {
            type = 'php',
            request = 'launch',
            name = "Listen for XDebug",
            port = 9003,
            log = false,
            pathMappings = {
              ["/buildkit/build/"] = sourceDirectory .. "civicrm-buildkit-docker/build/",
              ["/var/www/html/"] = cmsPath
            },
          }
        }

        require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,

    },

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      -- Update this to ensure that you have the debuggers for the langs you want
      'delve',
    },
  }
}
