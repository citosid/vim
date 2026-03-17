return {
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
		cmd = {
			"OverseerRunCmd",
			"OverseerQuickAction",
			"OverseerToggle",
		},
	},
}
