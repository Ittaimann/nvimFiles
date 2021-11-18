"------------------------ Packages --------------------------
packadd minpac
call minpac#init()
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-scriptease',{'type':'opt'})
call minpac#add('preservim/nerdtree',{'type':'opt'})
call minpac#add('k-takata/minpac',{'type':'opt'})
call minpac#add('vhdirk/vim-cmake')
call minpac#add('embear/vim-localvimrc')
call minpac#add('tpope/vim-dispatch')
call minpac#add('bfrg/vim-cpp-modern')
call minpac#add('neoclide/coc.nvim')

call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-obsession')
call minpac#add('ziglang/zig.vim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-telescope/telescope.nvim')
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

"---------------------- theme ---------------------------------
call minpac#add('junegunn/seoul256.vim')
set background=dark
let g:seoul256_background='#ffffff'
colo seoul256
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE                                                           

"---------------------- Shell ---------------------------------
let &shell = has('win32') ? 'powershell' : 'pwsh'
set shellquote= shellpipe=\| shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellredir=\|\ Out-File\ -Encoding\ UTF8

"---------------------- lsp -----------------------------------

"---------------------- misc settings -------------------------
let g:localvimrc_persistent=2
set encoding=utf-8
set fileencoding=utf8
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"-------------------- custom commands ----------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <A-o> :w <bar> :CocCommand clangd.switchSourceHeader<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <A-m> :CocList outline <CR>
map <C-K> :!clang-format -i -style=file % <cr>
nmap tn :tabnext <cr>
nmap tN :tabnew <cr>
nmap tc :tabclose <cr>
imap jj <ESC>

"-------------------- custom format ------------------------------
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set expandtab
set nowrap
