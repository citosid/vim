-- Prism colorscheme - custom theme inspired by geometric crystal wallpaper
-- To use: :colorscheme prism

return {
	dir = vim.fn.stdpath("config"),
	name = "prism",
	lazy = false,
	priority = 1000,
	config = function()
		-- Theme is loaded from colors/prism.lua
		-- Uncomment below to make it the default theme:
		vim.cmd.colorscheme("prism")
	end,
}
