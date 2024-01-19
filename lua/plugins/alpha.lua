return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = {
				[[                                  ]],
				[[┓  ┏┓┏┓┳┓┳┳┓┏┳┓┓┏┳┏┓┳┓┏┓   ┓┏┓ ┏┓┓]],
				[[┃  ┃ ┃┃┣┫┃┃┃ ┃ ┣┫┃┣┫┃┃┗┓   ┃┃┫• ┫┃]],
				[[┻  ┗┛┗┛┛┗┻┛┗ ┻ ┛┗┻┛┗┛┗┗┛•  ┻┗┛•┗┛┻]],
			}

			dashboard.section.header.val = logo

			dashboard.section.buttons.val = {
				dashboard.button("<space>ff", "󱡴  Find file", ":Telescope find_files <CR>"),
				dashboard.button("<space>fn", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("<space>fr", "󰁯  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("<space>fw", "󰺮  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/dotfiles/config/nvim/init.lua<CR>"),
				dashboard.button("q", "󰍃  Quit Neovim", ":qa<CR>"),
			}
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.opts.layout[1].val = 6
			return dashboard
		end,
		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)
			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
