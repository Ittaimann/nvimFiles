require('lsp')
require('dap')

local M={}
local opts = { noremap=true }
function M.init(proj_config)
  -- general mappings
  vim.keymap.set("n","tn","<cmd> tabnext <cr>",{desc="next tab"}) 
  vim.keymap.set("n","tN","<cmd> tabnew<cr>",{desc="new tab",noremap=true })
  vim.keymap.set("n","tc","<cmd> tabclose <cr>",{desc="close tab",noremap=true })
  vim.keymap.set('i',"jj","<ESC>",{})
  vim.keymap.set('n',"FF","yiw/<C-r>0",{})

  -- telescope mappings
  vim.keymap.set("n","<leader>ff", "<cmd>lua require('telescope-config').find_files()<cr>",{desc="telescope find files",noremap=true } )
  vim.keymap.set("n","<leader>fg", "<cmd>lua require('telescope-config').live_grep()<cr>", {desc="telescope live grep",noremap=true })
  vim.keymap.set("n","<leader>fb", "<cmd>lua require('telescope-config').buffers()<cr>", {desc="telescope buffers",noremap=true })
  vim.keymap.set("n","<leader>fh", "<cmd>lua require('telescope-config').help_tags()<cr>", {desc="telescope help tags",noremap=true })
  vim.keymap.set("n","<C-p>", "<cmd>lua require('telescope-config').builtin()<cr>", {desc="telescope",noremap=true })

  -- lsp
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc="declaration", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc="definition", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc="hover", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {desc="go implementatino", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc="signature help", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {desc="add to workspace folder", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {desc="remove workspace folder", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, {desc="list workspace folders", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {desc="type definition", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {desc="rename", noremap=true, buffer=ev.buf })
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {desc="code actions", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc="find references", noremap=true, buffer=ev.buf })
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, {desc="format", noremap=true, buffer=ev.buf })

  -- telescope
      vim.keymap.set("n","<leader>ds", "<cmd>lua require('telescope-config').lsp_document_symbols()<cr>", {desc="symbols in document", noremap=true, buffer=ev.buf })

      -- lsp based diagnostics
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    end,
  })

  -- project 
  if proj_config ~= nil then
    vim.keymap.set('n', '<Leader>b', function() proj_config.build() end, {desc="Build project"}) 
    vim.keymap.set('n', '<Leader>r', function() proj_config.run() end,{ desc="Run project"} )
    vim.keymap.set('n', '<Leader>c', function() proj_config.toggleConfig() end, {desc="Change config"} )
    vim.keymap.set('n', '<Leader>t', function() proj_config.toggleTarget() end, {desc="Change target"} )

  end

  -- scratch --
  vim.keymap.set('n', '<Leader>sb',"<cmd>lua require('buffer-utils').Scratch()<cr>", {desc="scratch"})

  -- dap --
  local debugging = require('debugging')
  vim.keymap.set("n","<F5>", function() debugging.continueSession() end,{desc="debug run"})
  vim.keymap.set("n","<F17>", function() debugging.endDebugSession() end,{desc="debug stop"})
  vim.keymap.set("n","<F41>", function() debugging.restartSession() end,{desc="debug restart"})
  vim.keymap.set("n","<F9>", function() debugging.placeBreakPoint() end,{desc="toggle breakpoint"})
  vim.keymap.set("n","<leader>lbp", function() debugging.listBreakPoints() end, {desc="list breakpoints",noremap=true })
  vim.keymap.set("n","<F10>", function() debugging.stepOver() end,{desc="debug step over"})
  vim.keymap.set("n","<F11>", function() debugging.stepIn() end,{desc="debug step in"})
  vim.keymap.set("n","<F23>", function() debugging.stepOut() end,{desc="debug step out"})
  vim.keymap.set("n","<leader>dbs", function() debugging.showScopes() end,{desc="debug show scopes"})
  vim.keymap.set("n","<leader>dbw", function() debugging.showWatch() end,{desc="debug show watch"})
  vim.keymap.set("n","<leader>dbf", function() debugging.showFrame() end,{desc="debug show frame"})
  vim.keymap.set("n","<leader>dbr", function() debugging.openRepl() end,{desc="debug show repl"})
  vim.keymap.set("n","<leader>dbh", function() debugging.openHover() end,{desc="debug show hover"})
  vim.keymap.set("n","<leader>dbp", function() debugging.openPreview() end,{desc="debug show preivew"})

end
return M
