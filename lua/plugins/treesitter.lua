return {
  {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
  },
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},
}
