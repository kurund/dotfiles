return {
  "mfussenegger/nvim-dap",

  opts = function()
    local dap = require("dap")

    --- check if a file or directory exists in this path
    local function exists(file)
      local ok, err, code = os.rename(file, file)
      if not ok then
        if code == 13 then
          -- permission denied, but it exists
          return true
        end
      end
      return ok, err
    end

    --- check if a directory exists in this path
    local function isdir(path)
      return exists(path .. "/")
    end

    -- lets set dynamic path dynamically for debugging
    local cmsPath = vim.fn.getcwd() .. "/src"
    -- check if it's WordPress or Drupal instance and set correct path
    if isdir(cmsPath .. "/wordpress") then
      cmsPath = cmsPath .. "/wordpress"
    elseif isdir(cmsPath .. "/drupal") then
      cmsPath = cmsPath .. "/drupal"
    else
      cmsPath = ""
    end

    -- vim.notify(cmsPath, 'error')
    local pathMappings = {}
    if cmsPath ~= "" then
      pathMappings = {
        ["/var/www/html/"] = cmsPath,
      }
    else
      -- lets assume we are using buildkit intance for now.
      pathMappings = {
        -- normal buildkit
        [vim.fn.getcwd()] = vim.fn.getcwd(),
      }
    end

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "PHP debugging",
        port = 9003,
        xdebugSettings = {
          max_children = 500,
        },
        pathMappings = pathMappings,
      },
    }
  end,
}
