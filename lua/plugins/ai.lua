return {
	{
		"jackMort/ChatGPT.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "pass show development/chatgpt.nvim",
			})
		end,
	},
	{
		"yetone/avante.nvim",
		cmd = { "AvanteToggle", "AvanteAsk" },
		lazy = true,
		version = false,
		opts = {
			provider = "openai",
			openai = {
				model = "gpt-4o-mini",
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		lazy = true,
		event = "BufReadPre",
		config = function()
			require("supermaven-nvim").setup({
				disable_keymaps = false,
				ignore_filetypes = { markdown = true },
				keymaps = {
					accept_suggestion = "<C-y>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
			})
		end,
	},
}
