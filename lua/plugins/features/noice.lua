return {
	"folke/noice.nvim",
	enabled = true,
	event = { "VeryLazy" },
	lazy = true,
	config = function()
		require("noice").setup({
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "L, ",
					},
					opts = { skip = true },
				},
			},
		})
	end,
}
