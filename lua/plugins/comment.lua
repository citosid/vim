return {
	"numToStr/Comment.nvim",
	-- event = "VeryLazy",
	lazy = true,
	config = function()
		require("Comment").setup()
	end,
}
