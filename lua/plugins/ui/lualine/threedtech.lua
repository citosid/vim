-- Threedtech lualine theme - auto-generated from wallpaper

local colors = {
	bg = "#121208",
	bg_light = "#202015",
	fg = "#dedfd7",
	fg_dark = "#9f9f98",
	coral = "#e4804d",
	teal = "#40a762",
	orange = "#e29f36",
	magenta = "#e8777b",
	cyan = "#1fcaa4",
	blue = "#00b7c1",
	gray = "#496b67",
	none = "NONE",
}

return {
	normal = {
		a = { fg = colors.bg, bg = colors.cyan, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg_light },
		c = { fg = colors.fg_dark, bg = colors.none },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.teal, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg_light },
		c = { fg = colors.fg_dark, bg = colors.none },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg_light },
		c = { fg = colors.fg_dark, bg = colors.none },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.coral, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg_light },
		c = { fg = colors.fg_dark, bg = colors.none },
	},
	command = {
		a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
		b = { fg = colors.fg, bg = colors.bg_light },
		c = { fg = colors.fg_dark, bg = colors.none },
	},
	inactive = {
		a = { fg = colors.gray, bg = colors.none, gui = "bold" },
		b = { fg = colors.gray, bg = colors.none },
		c = { fg = colors.gray, bg = colors.none },
	},
}
