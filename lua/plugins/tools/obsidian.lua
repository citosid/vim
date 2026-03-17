return {
	"epwalsh/obsidian.nvim",
	keys = {
		{ "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's notes" },
		{ "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/code/personal/notes/",
			},
		},
	},
}
