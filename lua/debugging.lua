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

-- dap mappings
local opts = { noremap=true }
vim.api.nvim_set_keymap("n","<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n","<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n","<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n","<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>tb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>bp", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>lbp", "<cmd>lua require'dap'.list_breakpoints()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

vim.api.nvim_set_keymap("n","<leader>dui", "<cmd>lua require'dapui'.toggle()<CR>", {})
vim.api.nvim_set_keymap("n","<F5>", "",
{
	callback = function()
		if dap.session() == nil then
			dap.continue({true})
		else 
			dap.continue({true})
		end
	end
})

-- keyboard layout is stupid for now do this 
vim.api.nvim_set_keymap("n","<s-F5>", "",
{
	callback = function()
		if dap.session() ~= nil then
			dap.terminate()
		end
	end
})

vim.api.nvim_set_keymap("n","<c-s-F5>", "",
{
	callback = function()
		if dap.session() ~= nil then
			dap.restart()
		end
	end
})

local sidebar=false
local widgets = require('dap.ui.widgets')
local my_sidebar = widgets.sidebar(widgets.frames)
vim.api.nvim_set_keymap("n","<leader>cs", "",
{
	callback = function()
		if sidebar ~= true then
			my_sidebar.open()
			sidebar=true
		else
			my_sidebar.close()
			sidebar=false
		end
	end
})

local locals = widgets.sidebar(widgets.scopes)
vim.api.nvim_set_keymap("n","<leader>cv", "",
{
	callback = function()
		if sidebar ~= true then
			locals.open()
			sidebar=true
		else
			locals.close()
			sidebar=false
		end
	end
})

local watch = widgets.sidebar(widgets.expression)
vim.api.nvim_set_keymap("n","<leader>cw", "",
{
	callback = function()
		if sidebar ~= true then
			watch.open()
			sidebar=true
		else
			watch.close()
			sidebar=false
		end
	end
})
