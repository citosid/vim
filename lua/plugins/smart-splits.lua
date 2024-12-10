return {
	"mrjones2014/smart-splits.nvim",
	event = "BufReadPre",
	keys = {
		{ "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<cr>" },
		{ "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<cr>" },
		{ "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<cr>" },
		{ "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<cr>" },
		{ "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" } },
		{ "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" } },
	},
	lazy = true,
	opts = {
		ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
		ignored_buftypes = { "nofile" },
	},
}
