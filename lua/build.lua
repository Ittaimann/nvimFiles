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

function makeprogramSet()
	vim.o.makeprg = vim.g.buildScript
	vim.cmd.make()
end

