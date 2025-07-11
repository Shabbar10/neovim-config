return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-p>"] = actions.move_selection_previous,
						["<C-n>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist,
						["<C-Q>"] = actions.smart_send_to_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in CWD" })
		keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
		keymap("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in CWD" })
		keymap("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in CWD" })
		keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
		keymap("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "List jump list entries" })
	end,
}
