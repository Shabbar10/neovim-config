return {
	"https://github.com/mfussenegger/nvim-dap",
	dependencies = {
		"https://github.com/jay-babu/mason-nvim-dap.nvim",
		"https://github.com/rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason_dap = require("mason-nvim-dap")

		dapui.setup()
		mason_dap.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
				args = { "${port}" },
			},
		}

		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		dap.adapters.python = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}", -- Run current file
				pythonPath = function()
					-- Try virtualenv first
					local venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return venv .. "/bin/python"
					end
					return "python3" -- fallback
				end,
			},
		}

		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<leader>do", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<leader>di", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<leader>du", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<Leader>dt", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<Leader>ds", function()
			dap.terminate()
		end)
	end,
}
