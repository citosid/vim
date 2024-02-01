return {
	"rcarriga/nvim-notify",
	lazy = true,
	event = "FileReadPre",
	config = function()
		require("notify").setup({
			background_colour = "#000000",
			render = "compact",
			stages = "static",
		})
	end,
}
