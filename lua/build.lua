vim.cmd([[

function! Scratch()
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    "setlocal nobuflisted
    "lcd ~
    file scratch
endfunction


]])


local ScratchLua = function()
    print("test")
end

ScratchLua()
