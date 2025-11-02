return {
	"https://github.com/mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"Weissle/persistent-breakpoints.nvim",
		-- "mxsdev/nvim-dap-vscode-js",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason_dap = require("mason-nvim-dap")
		local breakpoints = require("persistent-breakpoints")

		dapui.setup()

		breakpoints.setup({
			load_breakpoints_event = { "BufReadPost" },
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		-- 	dapui.close()
		-- end

		-- require("dap-vscode-js").setup({
		-- 	debugger_path = "/Users/shabbar.adamjee/Dev/vscode-js-debug",
		-- 	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		-- })
		--
		-- require("dap.ext.vscode").load_launchjs(nil, {
		-- 	["pwa-node"] = { "javascript", "typescript" },
		-- })

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { "/Users/shabbar.adamjee/Dev/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}

		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.adapters["lldb"] = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
			name = "lldb",
		}

		local project_dap = vim.fn.getcwd() .. "/.nvim-dap.lua"
		if vim.fn.filereadable(project_dap) == 1 then
			dofile(project_dap)
		end

		-- Enhanced keymaps with logging feedback
		vim.keymap.set("n", "<leader>dc", function()
			print("DAP: Continue/Start debugging")
			dap.continue()
		end, { desc = "Debug: Continue" })

		vim.keymap.set("n", "<leader>dr", function()
			print("DAP: Run to cursor")
			dap.continue()
		end, { desc = "Debug: Run to cursor" })

		vim.keymap.set("n", "<leader>do", function()
			print("DAP: Step over")
			dap.step_over()
		end, { desc = "Debug: Step Over" })

		vim.keymap.set("n", "<leader>di", function()
			print("DAP: Step into")
			dap.step_into()
		end, { desc = "Debug: Step Into" })

		vim.keymap.set("n", "<leader>du", function()
			print("DAP: Step out")
			dap.step_out()
		end, { desc = "Debug: Step Out" })

		vim.keymap.set(
			"n",
			"<Leader>dt",
			"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
			{ desc = "Debug: Toggle Breakpoint" }
		)

		vim.keymap.set(
			"n",
			"<Leader>dx",
			"<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
			{ desc = "" }
		)

		vim.keymap.set("n", "<Leader>ds", function()
			print("DAP: Terminating debug session")
			dap.terminate()
		end, { desc = "Debug: Stop" })

		vim.keymap.set("n", "<Leader>dq", function()
			print("DAP: Closing UI")
			dapui.toggle()
		end, { desc = "Debug: Close UI" })

		-- Additional useful keymaps for debugging with logging
		-- vim.keymap.set("n", "<leader>dr", function()
		-- 	print("DAP: Opening REPL")
		-- 	dap.repl.open()
		-- end, { desc = "Debug: Open REPL" })
		--
		-- vim.keymap.set("n", "<leader>dl", function()
		-- 	print("DAP: Running last debug configuration")
		-- 	dap.run_last()
		-- end, { desc = "Debug: Run Last" })
		--
		-- vim.keymap.set("n", "<leader>dh", function()
		-- 	print("DAP: Showing hover information")
		-- 	require("dap.ui.widgets").hover()
		-- end, { desc = "Debug: Hover Variables" })
		--
		-- vim.keymap.set("n", "<leader>dp", function()
		-- 	print("DAP: Showing preview")
		-- 	require("dap.ui.widgets").preview()
		-- end, { desc = "Debug: Preview Variables" })
	end,
}
