-- lua/plugins/icons.lua
-- mini.icons configuration

require("mini.icons").setup({
	style = "glyph",
	extension = {
		["toml"] = { glyph = "", hl = "MiniIconsYellow" },
		["pem"] = { glyph = "󱕵", hl = "MiniIconsRed" },
	},
})

-- Mock nvim-web-devicons for compatibility with other plugins
MiniIcons.mock_nvim_web_devicons()
