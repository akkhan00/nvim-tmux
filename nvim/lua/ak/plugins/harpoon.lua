local s1, mark = pcall(require, "harpoon.mark")
if not s1 then
  return
end

local s2, ui = pcall(require, "harpoon.ui")
if not s2 then
  return
end


vim.keymap.set("n", "H", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

-- quick access the files
vim.keymap.set("n", "<leader>1", function () ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function () ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function () ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function () ui.nav_file(4) end)
