return {
	"epwalsh/obsidian.nvim",
	keys = {
		{ "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's notes" },
		{ "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
	},
	opts = {
		workspaces = {
			{
				name = "bible-study",
				path = "~/code/personal/bible-study/",
			},
			{
				name = "letters",
				path = "~/code/personal/letters/",
			},
			{
				name = "notes",
				path = "~/code/personal/notes/",
			},
			{
				name = "watchtower_study",
				path = "~/code/personal/watchtower_study/",
			},
		},
	},
}
