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
"let &shell = has('win32') ? 'powershell' : 'pwsh'
"set shellquote= shellpipe=\| shellxquote=
"set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
"set shellredir=\|\ Out-File\ -Encoding\ UTF8
"
"set makeprg=./build.bat

augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
augroup END
]]
)


require('lsp')
require('format')
require('debugging')
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

-- general mappings
vim.api.nvim_set_keymap("n","tn","<cmd> tabnext <cr>",opts) vim.api.nvim_set_keymap("n","tN","<cmd> tabnew<cr>",opts)
vim.api.nvim_set_keymap("n","tc","<cmd> tabclose <cr>",opts)
vim.api.nvim_set_keymap('i',"jj","<ESC>",{})
vim.api.nvim_set_keymap('n',"FF","yiw/<C-r>0",{})
vim.api.nvim_set_keymap('n',"<leader>br","build",{})

-------------------- autocmd ------------------------------
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.zig' },
    callback = function()
        vim.o.makeprg = "zig/ build"
    end,
    group = generalSettingsGroup,
})

-------------------- custom format ------------------------------
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.copyindent = true
vim.o.preserveindent = true
vim.o.softtabstop=0
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = false
vim.o.wrap = false 
vim.o.listchars = "tab:>>,space:·"
vim.o.list = true
vim.o.relativenumber = true
