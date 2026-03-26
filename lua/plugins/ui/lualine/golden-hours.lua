-- Golden-Hours lualine theme - auto-generated from wallpaper

local colors = {
	bg = "#061415",
	bg_light = "#142223",
	fg = "#d7e0e0",
	fg_dark = "#98a0a0",
	coral = "#d28f20",
	teal = "#00aa8f",
	orange = "#c1b033",
	magenta = "#7e98f5",
	cyan = "#00c8cf",
	blue = "#00aee1",
	gray = "#486a71",
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
