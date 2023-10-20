vim.cmd([[
function FormatBuffer()
    if &modified && !empty(findfile('.clang-format',expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        :%!clang-format
        call setpos('.', cursor_pos)
    endif
endfunction

autocmd BufWritePre *.h,*.c,*.cpp :call FormatBuffer()

]])
