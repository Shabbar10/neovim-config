return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		vim.env.ESLINT_D_PPID = vim.fn.getpid()
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			python = { "flake8" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			require("lint").try_lint()
		end, { desc = "Trigger linting" })
	end,
}
