return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
		-- config.lsp.hover.enabled = false
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
}
