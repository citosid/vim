local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "nvim-neotest/nvim-nio" },
			{ "rcarriga/nvim-dap-ui" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			-- Icons for dap-ui
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🐞", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define("DapLogPoint", {
				text = "",
				texthl = "DapLogPoint",
				linehl = "DapLogPoint",
				numhl = "DapLogPoint",
			})
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)
			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
			vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
		end,
		keys = {
			{ "<leader>dd", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle dap ui" },
			{ "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
			{ "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step into" },
			{ "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step over" },
			{ "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
		},
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps --no-package-lock && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
		config = function()
			local debugger_path = string.format("%s/vscode-js-debug/", lazy_dir)
			local debugger_executable = string.format("%sout/src/vsDebugServer.js", debugger_path)
			local dap = require("dap")
			local dap_utils = require("dap.utils")

			dap.set_log_level("DEBUG")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						"/Users/acruz/.local/share/blinkin_vim/mason/packages/js-debug-adapter"
							.. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
				options = {
					source_filemap = {
						["/usr/src/app/"] = vim.fn.getcwd(),
						[vim.fn.getcwd()] = "/usr/src/app/",
					},
				},
			}

			local dap_configurations = {
				backend = 9229,
				cron = 9320,
				organization = 9232,
				language = 9233,
				geopolitical = 9234,
				debug = 9876,
			}

			dap.configurations.typescript = {}

			for name, port in pairs(dap_configurations) do
				table.insert(dap.configurations.typescript, {
					cwd = "${workspaceFolder}",
					localRoot = "${workspaceFolder}",
					name = name,
					processId = dap_utils.pick_process,
					remoteRoot = "/usr/src/app",
					request = "attach",
					skipFiles = {
						"<node_internals>/**",
						"node_modules/**",
					},
					type = "pwa-node",
					port = port,
				})
			end

			require("dapui").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local path = "~/.local/share/blinkin_vim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
		},
		ft = { "python" },
	},
}
