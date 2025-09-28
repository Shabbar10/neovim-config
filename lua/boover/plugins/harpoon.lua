return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		local keymap = vim.keymap.set

		keymap("n", "<leader>a", function()
			harpoon:list():add()
		end)
		keymap("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		keymap("n", "<C-s>", function()
			harpoon:list():select(1)
		end)
		keymap("n", "<C-d>", function()
			harpoon:list():select(2)
		end)
		keymap("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		keymap("n", "<C-m>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		keymap("n", "<S-H>", function()
			harpoon:list():prev()
		end)
		keymap("n", "<S-L>", function()
			harpoon:list():next()
		end)
	end,
}
