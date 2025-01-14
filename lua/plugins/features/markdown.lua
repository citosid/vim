return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"3rd/image.nvim",
		config = function()
			require("image").setup({
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						floating_windows = false, -- if true, images will be rendered in floating markdown windows
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
				},
			})
		end,
	},
}
