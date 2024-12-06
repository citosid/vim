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
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					{
						section = "startup",
					},
				},
			},
			bigfile = { enabled = true },
			notifier = { enabled = true, style = "fancy" },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
			terminal = {},
			words = { enabled = true },
		},
		keys = {
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
