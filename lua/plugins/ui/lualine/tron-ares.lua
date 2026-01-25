-- Tron-Ares lualine theme - auto-generated from wallpaper

local colors = {
	bg = "#0d0e11",
	bg_light = "#1a1d22",
	fg = "#e0e8f0",
	fg_dark = "#a0b0c0",
	coral = "#b10703",
	teal = "#3d9494",
	orange = "#c38b4c",
	magenta = "#c44a8a",
	cyan = "#43c0c0",
	blue = "#4a8ac4",
	gray = "#4a6a8a",
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
