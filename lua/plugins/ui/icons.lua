return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({
			override_by_extension = {
				["toml"] = {
					icon = "",
				},
				["pem"] = {
					icon = "󱕵",
				},
			},
		})
	end,
}
