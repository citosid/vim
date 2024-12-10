return {
	{
		"numToStr/Comment.nvim",
		lazy = true,
		keys = {
			{ "<leader>/", mode = { "n", "v" } },
		},
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>/",
				},
				opleader = {
					line = "<leader>/",
				},
			})
		end,
	},
}
