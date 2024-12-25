local colors = {
	bg = "#232136",
	fg = "#e0def4",
	black = "#191724",
	red = "#eb6f92",
	green = "#31748f",
	yellow = "#f6c177",
	blue = "#9ccfd8",
	magenta = "#c4a7e7",
	cyan = "#ebbcba",
	white = "#e0def4",
	gray = "#6e6a86",
}

return {
	normal = {
		a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.red, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	command = {
		a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	inactive = {
		a = { fg = colors.gray, bg = colors.bg, gui = "bold" },
		b = { fg = colors.gray, bg = colors.bg },
		c = { fg = colors.gray, bg = colors.bg },
	},
}
