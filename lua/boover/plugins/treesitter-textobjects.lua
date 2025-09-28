return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependecies = {
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		local treesitterconfig = require("nvim-treesitter.configs")

		treesitterconfig.setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>pn"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>pN"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
