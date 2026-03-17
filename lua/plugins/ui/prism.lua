-- Prism colorscheme - custom theme inspired by geometric crystal wallpaper
-- To use: :colorscheme prism
-- Theme is auto-loaded by theme-loader.lua based on ~/.local/state/dotfiles/theme

return {
	dir = vim.fn.stdpath("config"),
	name = "prism",
	lazy = false,
	priority = 1000,
	-- Don't set colorscheme here - theme-loader handles it
}
