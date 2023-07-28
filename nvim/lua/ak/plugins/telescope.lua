-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- telescope plugin keymap
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fs", builtin.live_grep, {}) -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fc", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>?", builtin.help_tag)
-- telescope git commands (not on youtube nvim video)
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {}) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
vim.keymap.set("n", "<leader>gfc", builtin.git_bcommits, {}) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {}) -- list git branches (use <cr> to checkout) ["gb" for git branch]
vim.keymap.set("n", "<leader>gs", builtin.git_status, {}) -- list current changes per file with diff preview ["gs" for git status]

-- configure telescope
telescope.setup({
	-- configure custom mappings
	extensions = {
		-- TODO: This is for windows only work
		-- 	fzy_native = {
		-- 		override_generic_sorter = false,
		-- 		override_file_sorter = true,
		-- 	},
		-- 	TODO: work for linux not windows
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
		file_ignore_patterns = { "node_modules" },
	},
})

-- require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzf")
