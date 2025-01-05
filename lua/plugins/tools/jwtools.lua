return {
	{
		cmd = {
			"JWToolsFetchScripture",
		},
		config = function()
			require("jwtools").setup()
		end,
		dir = "~/code/personal/jwtools.nvim",
		keys = {
			{ "<leader>jf", "<cmd>JWToolsFetchScripture<cr>" },
		},
	},
}
