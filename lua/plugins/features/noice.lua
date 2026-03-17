return {
	"folke/noice.nvim",
	enabled = true,
	event = { "VeryLazy" },
	lazy = true,
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
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
