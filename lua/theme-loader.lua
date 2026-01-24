-- Theme loader: reads theme from shared state file
-- Location: ~/.local/state/dotfiles/theme

local M = {}

-- Map theme names to Neovim colorschemes
local theme_map = {
  ["prism"] = "prism",
  ["catppuccin-frappe"] = "catppuccin-frappe",
  ["catppuccin-mocha"] = "catppuccin-mocha",
  ["catppuccin-latte"] = "catppuccin-latte",
  ["catppuccin-macchiato"] = "catppuccin-macchiato",
  ["rose-pine"] = "rose-pine",
  ["rose-pine-moon"] = "rose-pine-moon",
  ["rose-pine-dawn"] = "rose-pine-dawn",
}

local DEFAULT_THEME = "prism"

function M.get_theme()
  local state_file = vim.fn.expand("~/.local/state/dotfiles/theme")
  local f = io.open(state_file, "r")
  if not f then
    return DEFAULT_THEME
  end
  local theme = f:read("*l")
  f:close()
  return theme and theme:match("^%s*(.-)%s*$") or DEFAULT_THEME
end

function M.apply()
  local theme = M.get_theme()
  local colorscheme = theme_map[theme] or theme
  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify("Theme loader: failed to load '" .. colorscheme .. "': " .. err, vim.log.levels.WARN)
    pcall(vim.cmd.colorscheme, DEFAULT_THEME)
  end
end

return M
