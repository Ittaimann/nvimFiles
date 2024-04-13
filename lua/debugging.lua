-------------------- Debugger ----------------------------
local dap = require('dap')
require('dap').set_log_level('DEBUG')
require("dapui").setup()

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.g.execPath --vim.fn.getcwd() .. "/".. executable[vim.g.configIndex]
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
