require('dap')

local M = {}

local map = vim.keymap

-- general mappings useful in all cases
-- primarily useful for navigation
function M.init()
  map.set("n", "tn", "<cmd> tabnext <cr>", { desc = "next tab" })
  map.set("n", "tN", "<cmd> tabnew<cr>", { desc = "new tab", noremap = true })
  map.set("n", "tc", "<cmd> tabclose <cr>", { desc = "close tab", noremap = true })
  map.set('i', "jj", "<ESC>", {})
  map.set('n', "FF", "yiw/<C-r>0", {})

  -- telescope mappings
  map.set("n", "<leader>ff", "<cmd>lua require('telescope-config').find_files()<cr>",
    { desc = "telescope find files", noremap = true })
  map.set("n", "<leader>fg", "<cmd>lua require('telescope-config').live_grep()<cr>",
    { desc = "telescope live grep", noremap = true })
  map.set("n", "<leader>fb", "<cmd>lua require('telescope-config').buffers()<cr>",
    { desc = "telescope buffers", noremap = true })
  map.set("n", "<leader>fh", "<cmd>lua require('telescope-config').help_tags()<cr>",
    { desc = "telescope help tags", noremap = true })
  map.set("n", "<C-p>", "<cmd>lua require('telescope-config').builtin()<cr>",
    { desc = "telescope", noremap = true })

  -- scratch --
  map.set('n', '<Leader>sb', "<cmd>lua require('buffer-utils').Scratch()<cr>", { desc = "scratch" })
end

-- bind lsp functions
-- called bind lsp files
function M.bindLSPKeys(opts, args)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  map.set('n', 'grd', vim.lsp.buf.declaration, { desc = "declaration", noremap = true, buffer = args.buf })
  map.set('n', 'grD', vim.lsp.buf.definition, { desc = "definition", noremap = true, buffer = args.buf })
  map.set('n', 'K', vim.lsp.buf.hover, { desc = "hover", noremap = true, buffer = args.buf })
  map.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
    { desc = "add to workspace folder", noremap = true, buffer = args.buf })
  map.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
    { desc = "remove workspace folder", noremap = true, buffer = args.buf })
  map.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "list workspace folders", noremap = true, buffer = args.buf })
  map.set('n', '<space>D', vim.lsp.buf.type_definition, {
    desc = "type definition",
    noremap = true,
    buffer =
        args.buf
  })

  if opts["impl"] == true then
    map.set('n', 'gdd', vim.lsp.buf.implementation, { desc = "implementation" })
  end

  if opts["clangd_header_switch"] == true then
       map.set('n', '<space>s', "<cmd>LspClangdSwitchSourceHeader<cr>", { desc = "swap header", noremap = true })
  end

  -- telescope
  map.set("n", "<leader>ds", "<cmd>lua require('telescope-config').lsp_document_symbols()<cr>",
    { desc = "symbols in document", noremap = true, buffer = args.buf })

  -- lsp based diagnostics
  map.set('n', '<space>e', vim.diagnostic.open_float)

  map.set('n', '[d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end)
  map.set('n', ']d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end)
  map.set('n', '<space>q', vim.diagnostic.setloclist)
end

-- bind project based files
function M.bindProjectConfigKeys(proj_config)
  map.set('n', '<Leader>b', function() proj_config.build() end, { desc = "Build project" })
  map.set('n', '<Leader>r', function() proj_config.run() end, { desc = "Run project" })
  map.set('n', '<Leader>c', function() proj_config.toggleConfig() end, { desc = "Change config" })
  map.set('n', '<Leader>t', function() proj_config.toggleTarget() end, { desc = "Change target" })
end

-- bind if debugging enabled
function M.bindDebugKeys(debugging)
  map.set("n", "<F5>", function() debugging.continueSession() end, { desc = "debug run" })
  map.set("n", "<F17>", function() debugging.endDebugSession() end, { desc = "debug stop" })
  map.set("n", "<F41>", function() debugging.restartSession() end, { desc = "debug restart" })
  map.set("n", "<F9>", function() debugging.placeBreakPoint() end, { desc = "toggle breakpoint" })
  map.set("n", "<leader>lbp", function() debugging.listBreakPoints() end,
    { desc = "list breakpoints", noremap = true })
  map.set("n", "<F10>", function() debugging.stepOver() end, { desc = "debug step over" })
  map.set("n", "<F11>", function() debugging.stepIn() end, { desc = "debug step in" })
  map.set("n", "<F23>", function() debugging.stepOut() end, { desc = "debug step out" })
  map.set("n", "<leader>dbs", function() debugging.showScopes() end, { desc = "debug show scopes" })
  map.set("n", "<leader>dbw", function() debugging.showWatch() end, { desc = "debug show watch" })
  map.set("n", "<leader>dbf", function() debugging.showFrame() end, { desc = "debug show frame" })
  map.set("n", "<leader>dbr", function() debugging.openRepl() end, { desc = "debug show repl" })
  map.set("n", "<leader>dbh", function() debugging.openHover() end, { desc = "debug show hover" })
  map.set("n", "<leader>dbp", function() debugging.openPreview() end, { desc = "debug show preivew" })
end

return M
