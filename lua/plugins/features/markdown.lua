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
		lazy = true,
		ft = { "markdown", "vimwiki" },
		config = function()
			require("image").setup({
				integrations = {
					markdown = {
						clear_in_insert_mode = true,
						download_remote_images = true,
						editor_only_render_when_focused = true,
						enabled = true,
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
						only_render_image_at_cursor = true,
						tmux_show_only_in_active_window = true,
					},
				},
			})
		end,
	},
}
