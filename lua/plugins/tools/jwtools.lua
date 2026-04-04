return {
	{
		cmd = {
			"JWToolsFetchScripture",
			"JWToolsSearchNotes",
			"JWToolsInsertTag",
			"JWToolsRefreshTags",
			"JWToolsSearchPubs",
		},
		config = function()
			require("jwtools").setup()
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		dir = "~/code/personal/jwtools.nvim",
		keys = {
			{ "<leader>jf", "<cmd>JWToolsFetchScripture<cr>", desc = "JW: Fetch scripture" },
			{ "<leader>jsn", desc = "JW: Search notes" },
			{ "<leader>jss", desc = "JW: Search publications" },
			{ "<leader>jt", desc = "JW: Insert tag" },
		},
	},
}
