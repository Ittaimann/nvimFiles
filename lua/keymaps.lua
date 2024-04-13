require('build')
require('lsp')
require('dap')

local opts = { noremap=true }

-- general mappings
vim.keymap.set("n","tn","<cmd> tabnext <cr>",opts) 
vim.keymap.set("n","tN","<cmd> tabnew<cr>",opts)
vim.keymap.set("n","tc","<cmd> tabclose <cr>",opts)
vim.keymap.set('i',"jj","<ESC>",{})
vim.keymap.set('n',"FF","yiw/<C-r>0",{})

-- telescope mappings
vim.keymap.set("n","<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>",opts )
vim.keymap.set("n","<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
vim.keymap.set("n","<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
vim.keymap.set("n","<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
vim.keymap.set("n","<leader>ts", "<cmd>Telescope<cr>", opts)


-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

	-- telescope
    vim.keymap.set("n","<leader>ds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)

    -- lsp based diagnostics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
  end,
})

-- build --
vim.keymap.set('n', '<Leader>b',"", {
  callback = function()
    makeprogramSet()
  end
})


-- dap --
vim.keymap.set("n","<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n","<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n","<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n","<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n","<leader>tb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n","<leader>bp", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.keymap.set("n","<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.keymap.set("n","<leader>lbp", "<cmd>lua require'dap'.list_breakpoints()<CR>", opts)
vim.keymap.set("n","<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", opts)
vim.keymap.set("n","<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

vim.keymap.set("n","<leader>dui", "<cmd>lua require'dapui'.toggle()<CR>", {})

local dap = require('dap')
vim.keymap.set("n","<F5>", "",
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
vim.keymap.set("n","<s-F5>", "",
{
callback = function()
if dap.session() ~= nil then
  dap.terminate()
end
end
})

vim.keymap.set("n","<c-s-F5>", "",
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
vim.keymap.set("n","<leader>cs", "",
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
vim.keymap.set("n","<leader>cv", "",
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
vim.keymap.set("n","<leader>cw", "", {
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
