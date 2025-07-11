return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local code_actions = null_ls.builtins.code_actions

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.asmfmt.with({
					filetypes = { "nasm" },
				}),

				null_ls.builtins.formatting.prettier.with({
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
					extra_args = { "--semi", "true" },
				}),
			},
		})
	end,
}
