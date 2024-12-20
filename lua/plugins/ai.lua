return {
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
