-- place this in one of your configuration file(s)
local hop = require("hop")
hop.setup()
vim.keymap.set("n", "<leader>q", ":HopAnywhere<CR>")
