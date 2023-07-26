local opt = vim.opt -- for concisenss

-- show enter and space on neovim
opt.list = true
opt.listchars:append("eol:↴")
opt.listchars:append("space:⋅")

-- line numbers
opt.number = true -- shows absolute line number of cursor line
opt.relativenumber = true -- show relative line number
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 space for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable lne wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- for smart search

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- setup for themes
opt.termguicolors = true
opt.background = "dark" -- colorschme that be light or dark will made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on idnet, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use styem clipboard as default register

-- split windows
opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- opt.iskeyword:append("-") -- consider string-string as whoel word

opt.scrolloff = 8 -- don't go down after remaning 8 lines
opt.colorcolumn = "80" -- for the main line in the editor

-- this will auto indent when it's in empty line
-- autoindent the current Empty Line
vim.keymap.set("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })

--------- DEBUGING  ---------
