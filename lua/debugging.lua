-------------------- Debugger ----------------------------
local dap = require('dap')
dap.set_log_level('DEBUG')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
  name = 'lldb'
}

-- maybe move this out to proj config or the local
dap.configurations.zig= {
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
--M.breakpointList

local sign = vim.fn.sign_define

sign('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
sign('DapStopped', {text='➡️', texthl='', linehl='', numhl=''})
sign('DapBreakpointRejected', {text='😔', texthl='', linehl='', numhl=''})

function M.continueSession()
  M.running = true
  dap.continue({true})
end

function M.endDebugSession()
  if M.running == true then
    M.running = false
    M.terminate()
  end
end

function M.restartSession()
  if M.running == true then
    M.restart({true})
  end
end

function M.pauseSession()
  M.pause();
end

function M.placeBreakPoint()
  M.toggle_breakpoint()
end

function M.listBreakPoints()
  M.list_breakpoints()
end

function M.stepIn()
  M.step_into();
end

function M.stepOut()
  M.step_out();
end

function M.stepOver()
  M.step_over();
end

--- wrappers around dap
function M.continue()
    dap.continue({true})
end

function M.terminate()
  dap.terminate()
end

function M.restart()
  dap.restart()
end

function M.run()
  dap.run()
end
function M.sessions()
  dap.sessions()
end
function M.step_out()
  dap.step_out()
end
function M.stop()
  dap.stop()
end
function M.step_back()
  dap.step_back()
end
function M.reverse_continue()
  dap.reverse_continue()
end
function M.set_log_level()
  dap.set_log_level()
end
function M.pause()
  dap.pause()
end
function M.launch()
  dap.launch()
end
function M.close()
  dap.close()
end
function M.disconnect()
  dap.disconnect()
end
function M.up()
  dap.up()
end
function M.down()
  dap.down()
end
function M.goto_()
  dap.goto_()
end
function M.attach()
  dap.attach()
end
function M.list_breakpoints()
  dap.list_breakpoints()
end
function M.run_last()
  dap.run_last()
end
function M.step_over()
  dap.step_over()
end
function M.focus_frame()
  dap.focus_frame()
end
function M.set_session()
  dap.set_session()
end
function M.set_breakpoint()
  dap.set_breakpoint()
end
function M.run_to_cursor()
  dap.run_to_cursor()
end
function M.restart_frame()
  dap.restart_frame()
end
function M.step_into()
  dap.step_into()
end
function M.toggle_breakpoint()
  dap.toggle_breakpoint()
end
function M.session()
  dap.session()
end
function M.terminate()
  dap.terminate()
end
function M.restart()
  dap.restart()
end
function M.status()
  dap.status()
end
function M.clear_breakpoints()
  dap.clear_breakpoints()
end
function M.set_exception_breakpoints()
  dap.set_exception_breakpoints()
end

return M
