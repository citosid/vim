return {
	"supermaven-inc/supermaven-nvim",
	lazy = true,
	cmd = { "SupermavenStart" },
	enabled = false,
	keys = {
		{ "<leader>as", "<cmd>SupermavenStart<cr>", desc = "Start SuperMaven" },
		{ "<leader>ax", "<cmd>SupermavenStop<cr>", desc = "Stop SuperMaven" },
	},
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
}
