local M = {}

M.configPresets = {}
M.buildPresets = {}

local config = {}
config.binaryDir = {}


-- build a config
function initConfig(configTable)
  local config = {}
  if configTable["inherits"] ~= nil then
    initConfig
  end
  config["name"] = name
  config["hidden"] = hidden
  config["bindir"] = bindir
  return config
end

function M.populateConfigs()
end

function M.setup(preset_path)
  local preset_file = assert(io.open(preset_path, "r"))
  local preset_text = preset_file:read("*all")
  preset_file:close()

  local presets = vim.json.decode(preset_text)

  local validConfigs = 1
  for i, v in ipairs(presets["configurePresets"]) do
    M.configPresets[validConfigs] = initConfig(v)
    validConfigs = validConfigs + 1

    --    if v["hidden"] ~= true then
    --      if v["inherits"] ~= nil then
    --        -- recurse up the inheritance
    --        -- end
    --      end
    --      M.configPresets[validConfigs] = v["name"]
    --      validConfigs = validConfigs + 1
    --    end
  end

  for i, v in ipairs(presets["buildPresets"]) do
    if v["hidden"] ~= true then
      M.buildPresets[validConfigs] = v["name"]
      validConfigs = validConfigs + 1
    end
  end
end

function M.get_executable(target_name)

end

return M
