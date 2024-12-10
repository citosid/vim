return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = "Telescope",
		keys = {
			{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find in open buffers" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find in symbols" },
			{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
		},
		opts = function()
			require("telescope").load_extension("noice")
			require("telescope").load_extension("fzf")

			local actions = require("telescope.actions")

			local shared_mappings = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.preview_scrolling_down,
				["<C-p>"] = actions.preview_scrolling_up,
			}

			return {
				defaults = {
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					mappings = {
						i = vim.tbl_extend("force", {
							["<C-c>"] = actions.close,
						}, shared_mappings),
						n = vim.tbl_extend("force", {
							q = actions.close,
						}, shared_mappings),
					},
				},
			}
		end,
	},
}
