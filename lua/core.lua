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
let g:seoul256_background='#00ffffff'
colo seoul256
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

"---------------------- Shell ---------------------------------
"let &shell = has('win32') ? 'powershell' : 'pwsh'
"set shellquote= shellpipe=\| shellxquote=
"set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
"set shellredir=\|\ Out-File\ -Encoding\ UTF8
"
"set makeprg=./build.bat
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden  
    set grepformat=%f:%l:%c:%m
endif

augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
augroup END
]]
)


require('lsp')
require('format')
require('debugging')
require('build')
require('keymaps')

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
