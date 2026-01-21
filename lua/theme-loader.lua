-- Theme loader - reads theme from shared state file and applies it
-- State file: ~/.local/state/dotfiles/theme
-- Used by: dotfiles theme switch <theme>

local M = {}

-- Map theme names to colorscheme commands
-- Add new themes here as they're created
M.theme_map = {
	["prism"] = "prism",
	["catppuccin-frappe"] = "catppuccin-frappe",
	["catppuccin-mocha"] = "catppuccin-mocha",
	["rose-pine"] = "rose-pine-moon",
	["rose-pine-moon"] = "rose-pine-moon",
	["enterprise-desert"] = "enterprise-desert",
}

-- Default theme if state file doesn't exist or theme not found
M.default_theme = "catppuccin-frappe"

-- State file location
M.state_file = vim.fn.expand("~/.local/state/dotfiles/theme")

--- Read current theme from state file
---@return string|nil theme name or nil if file doesn't exist
function M.get_current_theme()
	local file = io.open(M.state_file, "r")
	if not file then
		return nil
	end

	local content = file:read("*l")
	file:close()

	if content then
		return vim.trim(content)
	end
	return nil
end

--- Get colorscheme name for a theme
---@param theme string theme name
---@return string colorscheme name
function M.get_colorscheme(theme)
	return M.theme_map[theme] or theme
end

--- Apply the current theme from state file
function M.apply()
	local theme = M.get_current_theme()
	local colorscheme = M.get_colorscheme(theme or M.default_theme)

	-- Try to apply the colorscheme
	local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
	if not ok then
		vim.notify(
			string.format("Theme '%s' not found, using default", colorscheme),
			vim.log.levels.WARN
		)
		pcall(vim.cmd.colorscheme, M.default_theme)
	end
end

return M
