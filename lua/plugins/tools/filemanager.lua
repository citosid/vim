return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = true,
		cmd = "Neotree",
		keys = {
			{ "<leader>p", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				event_handlers = {
					{
						event = "file_opened",
						handler = function(_)
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
				},
				window = {
					mappings = {
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					},
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
