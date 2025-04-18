return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	event = "BufReadPre",
	lazy = true,
	version = "1.*",
	opts = {
		keymap = { preset = "enter" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
