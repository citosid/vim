return {
	{
		"joshuadanpeterson/typewriter",
		lazy = true,
		cmd = { "TWEnable", "TWToggle" },
		config = function()
			require("typewriter").setup({
				enable_horizontal_scroll = false,
			})
		end,
		opts = {},
	},
}
