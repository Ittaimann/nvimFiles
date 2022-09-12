-- My neo vim conifg. Some pieces are still  in vim script but thats fine I guess
vim.cmd([[
"------------------------ Packages --------------------------
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mfussenegger/nvim-dap'
Plug 'ziglang/zig.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/seoul256.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'akinsho/bufferline.nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'tpope/vim-dispatch'
call plug#end()

"---------------------- theme ---------------------------------
set background=dark
"let g:seoul256_background='#ffffff'
colo seoul256
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE                                                           

"---------------------- Shell ---------------------------------
let &shell = has('win32') ? 'powershell' : 'pwsh'
set shellquote= shellpipe=\| shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellredir=\|\ Out-File\ -Encoding\ UTF8

set makeprg=./build.bat

augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
augroup END
]]
)



---------------------- lsp -----------------------------------
local nvim_lsp = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd", "zls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
      --coq.lsp_ensure_capabilities{
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
   -- }
  }
end


local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-n>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<C-p>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require'nvim-treesitter.configs'.setup {
--    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
        enable = true
    }
}

-------------------- Debugger ----------------------------
local dap = require('dap')
dap.adapters.codelldb = function(callback, config)
-- specify in your configuration host = your_host , port = your_port
    callback({ type = "server", host = config.host, port = config.port })
end

dap.adapters.codelldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local cmd = "C:/Users/ittai/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/adapter/codelldb.exe"

  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
            type = 'server',
            host = '127.0.0.1',
            port = port
          })
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    console = "externalTerminal",
    stopOnEntry = false,
  },
}
require('dap').set_log_level('DEBUG')
require("dapui").setup()
-------------------- Lua Line ----------------------------

require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
}

-------------------- projects ----------------------------
--require('project_nvim').setup {}
--require('telescope').setup{extensions = {
--'projects'
--}}
--require('telescope').load_extension('projects')
-------------------- Buffer Line ----------------------------
--vim.opt.termguicolors = true
--require("bufferline").setup{}
------------------- spotify ----------------------------
-- myabe one day crying emoji -- 
-------------------- custom commands ----------------------------
local opts = { noremap=true }
local function set_keymap_norm(...) vim.api.nvim_buf_set_keymap(0,"n", ...) end

-- telescope mappings
vim.api.nvim_set_keymap("n","<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>",opts )
vim.api.nvim_set_keymap("n","<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
vim.api.nvim_set_keymap("n","<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
vim.api.nvim_set_keymap("n","<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- dap mappings
vim.api.nvim_set_keymap("n","<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n","<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n","<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n","<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.api.nvim_set_keymap("n","<leader>dr", "<cmd>lua require'dap'.repl.open()CR>", opts)
vim.api.nvim_set_keymap("n","<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

-- general mappings
vim.api.nvim_set_keymap("n","tn","<cmd> tabnext <cr>",opts)
vim.api.nvim_set_keymap("n","tN","<cmd> tabnew<cr>",opts)
vim.api.nvim_set_keymap("n","tc","<cmd> tabclose <cr>",opts)
vim.api.nvim_set_keymap('i',"jj","<ESC>",{})
vim.api.nvim_set_keymap('n',"FF","yiw/<C-r>0",{})
-- idea about building something from here
vim.api.nvim_set_keymap('n',"<leader>b","<cmd>!build.bat<cr>",{})
-------------------- custom format ------------------------------
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.copyindent = true
vim.o.preserveindent = true
vim.o.softtabstop=0
vim.o.shiftwidth=4
vim.o.tabstop=4
vim.o.expandtab = true
vim.o.wrap = false 



