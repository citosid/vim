return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		file_types = { "markdown", "Avante" },
	},
	ft = { "markdown", "Avante" },
	config = function()
		require("render-markdown").setup({})
	end,
}
