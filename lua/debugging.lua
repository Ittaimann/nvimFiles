-------------------- Debugger ----------------------------
local dap = require('dap')
require('dap').set_log_level('DEBUG')
-- require("dapui").setup()

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb'
}

-- maybe move this out to proj config or the local
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return require("proj-config").getExecutable() 
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- debugging state
local M = {}
local widgets = require('dap.ui.widgets')
M.running= false 
M.frames= widgets.sidebar(widgets.frames)
M.scopes= widgets.sidebar(widgets.scopes)
M.watch = widgets.sidebar(widgets.expression)

function M.run()
  if dap.session() == nil then
    dap.continue({true})
  else 
    dap.continue({true})
  end
end

function M.terminate()
  if dap.session() ~= nil then
    dap.terminate()
  end
end

function M.restart()
  if dap.session() ~= nil then
    dap.restart()
  end
end


return M
