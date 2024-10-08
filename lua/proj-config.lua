local M={}

-- big old wrapper around a lot of stuff lmao
-- for if you use it.

M.proj_configs = {}
M.exec_paths = {}
M.make_cmd = ""
M.make_args= {}
M.currentConfig = 1
M.usingConfigs = false
M.configCount  = 0

function M.build()
  local build = require("build")
  build.setMake(M.make_cmd.. " "..M.make_args[M.currentConfig])
  build.make()
end

function M.toggleConfig()
  M.currentConfig = M.currentConfig + 1
  if M.currentConfig > M.configCount then
    M.currentConfig = 1
  end
end

function M.getCurrentConfig()
  return M.proj_configs[M.currentConfig]
end


function M.run()
  vim.cmd("! "..M.exec_paths[M.currentConfig])
end

function M.getExecutable()
  return M.exec_paths[M.currentConfig]
end

function M.setup(config_table)
  M.proj_configs = config_table.proj_configs
  M.exec_paths = config_table.exec_paths
  M.make_cmd = config_table.make_cmd
  M.make_args= config_table.make_args
  M.currentConfig = 1
  M.usingConfigs = true 
  for _ in pairs(config_table.proj_configs) do
    M.configCount = M.configCount + 1 
  end

end

return M
