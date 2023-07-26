vim.g.mapleader = " " -- set leader key to space
local keymap = vim.keymap -- for conciseness
keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("n", "<leader>so", ":%source<CR>") -- reload the nvim init.lua file
keymap.set("n", "<leader>w", ":w<CR>") -- save file

keymap.set("n", "<leader>Tf", ":ToggleTerm direction=float<CR>")
keymap.set("n", "<leader>Tv", ":ToggleTerm direction=vertical<CR>")
keymap.set("n", "<leader>Th", ":ToggleTerm size=20 direction=horizontal<CR>")

keymap.set("i", "jk", "<ESC>") -- exit from insert mode

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlight

keymap.set("n", "x", '"_x') -- delete char without copying it

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split windows vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- split window equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization
-- resize split windows
-- Resize split windows vertically
keymap.set("n", "<M-h>", ":vertical resize +5<CR>", { noremap = true })
keymap.set("n", "<M-l>", ":vertical resize -5<CR>", { noremap = true })
-- Resize split windows horizontally
keymap.set("n", "<M-j>", ":resize +5<CR>", { noremap = true })
keymap.set("n", "<M-k>", ":resize -5<CR>", { noremap = true })

-- ##############3

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-------------------
-- Plugin keybinds
-------------------

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- move visual line up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stay cursor in same position but add line to then next with space
keymap.set("n", "J", "mzJ`z")

-- half page jump and stay cursor the sanme not to move
-- keymap.set("n", "7", "<C-d>zz")
-- keymap.set("n", "8", "<C-u>zz")

-- help to search terms and the curosr stay in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- paste over other and don't copy the
keymap.set("x", "<leader>p", '"_dP')

-- delete word without copy it to register
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

-- change the register with vim and system
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y') -- [WARNING] i can't know the difference

-- keymap.set("n", "<C-f>", "<cmd>silent !lshisfjiofjd<CR>") -- find a file but not working(28:15)
keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

keymap.set("n", "<C-1>", ":t.<cr>") -- for dubplicate the line

------------ FOR DEBUGGING --------------------
local status, dap = pcall(require, "dap")
if not status then
	return
end

keymap.set("n", "<F5>", dap.toggle_breakpoint)
keymap.set("n", "<F6>", dap.continue)
keymap.set("n", "<F9>", dap.step_into)
keymap.set("n", "<F10>", dap.step_over)
keymap.set("n", "<F12>", dap.step_out)
