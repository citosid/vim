return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			ensure_installed = { "markdown", "latex" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
	lazy = true,
	event = "BufReadPre",
}
