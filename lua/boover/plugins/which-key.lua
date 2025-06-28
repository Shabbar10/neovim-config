return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Loading early not a priority
	init = function() -- run when plugin loads
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>f", group = "file" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
		})

		-- wk.add({
		-- 	e = {
		-- 		name = "nvim-tree",
		-- 	},
		-- 	f = {
		-- 		name = "telescope-find",
		-- 	},
		-- 	s = {
		-- 		name = "split",
		-- 	},
		-- 	w = {
		-- 		name = "split-maximize",
		-- 	},
		-- }, { prefix = "<leader>" })
	end,
}
