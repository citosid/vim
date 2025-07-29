return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				enabled = true,
				formats = {
					key = function(item)
						return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
					end,
				},
				sections = {
					{ section = "recent_files", cwd = true, limit = 8, padding = 1 },
					{
						{ icon = " ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					{
						section = "startup",
					},
				},
			},
			bigfile = { enabled = false },
			input = { enabled = true },
			notifier = { enabled = true, style = "fancy" },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
			terminal = {},
			toggle = {
				which_key = true,
				notify = true,
				icon = {
					enabled = " ",
					disabled = " ",
				},
				color = {
					enabled = "green",
					disabled = "yellow",
				},
			},
			words = { enabled = true },
			zen = {
				toggles = {
					dim = false,
					git_signs = false,
					mini_diff_signs = false,
					diagnostics = true,
					inlay_hints = true,
				},
				win = {
					enter = true,
					fixbuf = false,
					minimal = false,
					width = 140,
					height = 0,
					backdrop = { transparent = true, blend = 40 },
					keys = { q = false },
					zindex = 40,
					wo = {
						winhighlight = "NormalFloat:Normal",
					},
				},
			},
		},
		keys = {
			{
				"<leader>gb",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Open current file in browser",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>T",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.inlay_hints():map("<leader>uh")
				end,
			})
		end,
	},
}
