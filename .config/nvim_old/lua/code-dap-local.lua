local dap = require "dap"
dap.configurations.php[1].pathMappings = {
  ['/buildkit/build/'] = '/home/kurund/src/civicrm-buildkit-docker/build/'
}
