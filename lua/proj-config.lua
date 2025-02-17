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
M.currentTarget = 0
M.targets = {}
M.launch_args = {}

function M.build()
  local build = require("build")
  if table.getn(M.targets) == 0 then
    build.setMake(M.make_cmd.." "..M.make_args[M.currentConfig])
  else
    build.setMake(M.make_cmd.." "..M.make_args[M.currentConfig].." "..M.targets[M.currentTarget])
    print((M.make_cmd.." "..M.make_args[M.currentConfig].." "..M.targets[M.currentTarget]))
  end
  build.make()
end

function M.toggleConfig()
  M.currentConfig = M.currentConfig + 1
  if M.currentConfig > M.configCount then
    M.currentConfig = 1
  end
end

function M.toggleTarget()
  M.currentTarget = M.currentTarget+ 1
  if M.currentTarget > table.getn(M.targets) then
    M.currentTarget = 1
  end
end

function M.getCurrentConfig()
  return M.proj_configs[M.currentConfig]
end


function M.run()
   local  args = M.launch_args
  vim.cmd("! "..M.getExecutable().." --ra "..args)
end

function M.getExecutable()
  local target = "" 
  if table.getn(M.targets) > 0 then
    target = "/"..M.targets[M.currentTarget] 
  end
  return M.exec_paths[M.currentConfig]..target
end

function M.getTarget()
  return M.targets[M.currentTarget]
end

function M.getLaunchArgs()
  return M.launch_args
end

function M.setup(config_table)
  M.proj_configs = config_table.proj_configs
  M.exec_paths = config_table.exec_paths
  M.make_cmd = config_table.make_cmd
  M.make_args= config_table.make_args
  M.currentConfig = 1
  M.usingConfigs = true 
  M.currentTarget = 1
  M.targets = config_table.targets
  M.configCount = table.getn(config_table.proj_configs)
  M.launch_args = config_table.launch_args
end

return M
