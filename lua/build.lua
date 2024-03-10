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

local function makeprogramSet()
	vim.o.makeprg = vim.g.buildScript
	vim.cmd.make()
end

vim.api.nvim_set_keymap('n', '<Leader>b',"", {
	callback = function()
		makeprogramSet()
	end
})

