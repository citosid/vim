return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		lazy = false,
		priority = 1000,
		opts = {
			current_line_blame = false,
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
		config = function()
			require("gitsigns").setup()
			local map = require("utils").map

			map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview change under cursor" })
			map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" })
		end,
	},
}
