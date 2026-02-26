-- Color-Wall lualine theme - auto-generated from wallpaper

local colors = {
	bg = "#09131a",
	bg_light = "#172128",
	fg = "#d8dfe4",
	fg_dark = "#999fa4",
	coral = "#d57abd",
	teal = "#00a9a3",
	orange = "#adb742",
	magenta = "#9b8ff0",
	cyan = "#00c4e1",
	blue = "#36a8ec",
	gray = "#4b6875",
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
