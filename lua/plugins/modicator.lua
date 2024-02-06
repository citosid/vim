return {
	"mawkler/modicator.nvim",
	lazy = true,
	event = "BufReadPre",
	init = function() end,
	opts = {
		integration = {
			lualine = {
				mode_section = "x",
			},
		},
	},
}
