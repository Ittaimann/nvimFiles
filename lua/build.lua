local M={}

M.build_configs={}
M.executable=""

function M.setMake(make_command)
	vim.o.makeprg = make_command 
end

function M.make()
	vim.cmd.make()
end

function M.makeAsync()
  local lines = {""}
  local winnr = vim.fn.win_getid()

  local makeprg = vim.api.nvim_get_option("makeprg")
  print(makeprg)
  if not makeprg then return end

  local cmd = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == "stdout" or event == "stderr" then
      if data then
        vim.list_extend(lines, data)
      end
    end

    if event == "exit" then
      vim.fn.setqflist({}," ", {
        title = cmd,
        lines = lines,
        efm = vim.api.nvim_get_option("errorformat")
      })
      vim.api.nvim_command("doautocmd QuickFixCmdPost")
    end
  end

  local job_id =
    vim.fn.jobstart(
    cmd,
    {
      on_stderr = on_event,
      on_stdout = on_event,
      on_exit = on_event,
      stdout_buffered = true,
      stderr_buffered = true,
    }

  )
end
return M
