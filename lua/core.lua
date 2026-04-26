local M = {}
-- todo: replace withnvim plug

function M.init()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })
  vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
  vim.pack.add({ 'https://github.com/mfussenegger/nvim-dap' })
  vim.pack.add({ 'https://github.com/ziglang/zig.vim' })
  vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
  vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' })
  vim.pack.add({ 'https://github.com/junegunn/seoul256.vim' })
  vim.pack.add({ 'https://github.com/kyazdani42/nvim-web-devicons' })
  vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })
  vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })
  vim.pack.add({ 'https://github.com/L3MON4D3/LuaSnip' })
  vim.pack.add({ 'https://github.com/tpope/vim-dispatch' })

  vim.cmd([[
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

  ]]
  )

  require('keymaps').init()
  require('lsp')
  require('build')
  require('telescope')
  require('lualine-config')

  -------------------- custom format ------------------------------
  vim.o.encoding = "utf-8"
  vim.o.fileencoding = "utf-8"
  vim.o.copyindent = true
  vim.o.preserveindent = true
  vim.o.softtabstop = 0
  vim.o.tabstop = 4
  vim.o.shiftwidth = 4
  vim.o.expandtab = false
  vim.o.wrap = false
  vim.o.listchars = "tab:>>,space:·"
  vim.o.list = true
  vim.o.relativenumber = true
end

return M
