return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = false,
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			local mode = vim.api.nvim_get_mode().mode
			local opts = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			}

			if mode == "v" or mode == "V" then
				opts.range = {
					["start"] = vim.api.nvim_buf_get_mark(0, "<"),
					["end"] = vim.api.nvim_buf_get_mark(0, ">"),
				}
			end

			require("conform").format(opts)
		end, { desc = "Format file or selection" })
	end,
}
