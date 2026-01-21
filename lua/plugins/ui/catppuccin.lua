return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "frappe",
		term_colors = true,
		transparent_background = true,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		-- Don't set colorscheme here - theme-loader handles it
	end,
}
