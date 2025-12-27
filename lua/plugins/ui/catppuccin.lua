return {
	"catppuccin/nvim",
	name = "catppuccin",
	event = { "UIEnter" },
	opts = {
		flavour = "mocha",
		term_colors = true,
		transparent_background = true,
	},
	priority = 1000,
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
