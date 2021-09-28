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
call minpac#add('puremourning/vimspector')
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

"---------------------- misc settings -------------------------
let g:localvimrc_persistent=2
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
set encoding=utf-8
set fileencoding=utf8
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"-------------------- custom commands ----------------------------
nnoremap <C-p> :<C-u>FZF<CR>
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
