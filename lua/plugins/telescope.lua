return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
		{ "nvim-lua/plenary.nvim" },
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>/", false },
		-- { "<leader>fw", require("telescope").live_grep, desc = "Grep (root dir)" },
	},
	opts = function()
		local actions = require("telescope.actions")
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
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = { q = actions.close },
				},
			},
		}
	end,
}
