return {
	"rainbowhxch/beacon.nvim",
	config = function()
		local beacon = require("beacon")

		beacon.setup()

		vim.keymap.set("n", "<leader> ", "<cmd>Beacon<CR>", { desc = "Flash cursor" })
	end,
}
