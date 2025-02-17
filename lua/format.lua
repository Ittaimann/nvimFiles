--vim.cmd([[
--function FormatBuffer()
--    if &modified && !empty(findfile('.clang-format',expand('%:p:h') . ';'))
--        let cursor_pos = getpos('.')
--        :%!clang-format
--        call setpos('.', cursor_pos)
--    endif
--endfunction
--
--autocmd BufWritePre *.h,*.c,*.cpp :call FormatBuffer()
--
--]])

vim.api.nvim_create_autocmd({"BufWritePre"},{
  pattern = {"*.c", "*.h","*.cpp"},
  callback = function() vim.lsp.buf.format() end,
})
