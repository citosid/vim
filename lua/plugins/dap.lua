local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

return {
	"mfussenegger/nvim-dap",
	-- ft = { "ts", "js", "tsx", "jsx" },
	dependencies = {
		{ "nvim-neotest/nvim-nio" },
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = string.format("%s/vscode-js-debug/", lazy_dir),
				adapters = { "pwa-node" },
			},
		},
		{ "rcarriga/nvim-dap-ui" },
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps --no-package-lock && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
		},
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		local dap_configurations = {
			backend = 9229,
			cron = 9320,
			organization = 9232,
			language = 9233,
			geopolitical = 9234,
		}

		dap.configurations.typescript = {}

		for name, port in pairs(dap_configurations) do
			table.insert(dap.configurations.typescript, {
				console = "integratedTerminal",
				localRoot = vim.fn.getcwd(),
				name = name,
				processId = require("dap.utils").pick_process,
				remoteRoot = "/usr/src/app",
				request = "attach",
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				type = "pwa-node",
				port = port,
			})
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

		require("dapui").setup()
	end,
}
