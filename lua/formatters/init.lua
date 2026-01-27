-- lua/formatters/init.lua
-- External formatters (non-LSP)

local M = {}

-- Shared utilities
M.utils = require("formatters.utils")

function M.setup()
	local group = vim.api.nvim_create_augroup("ExternalFormatters", { clear = true })

	-- Load individual formatters
	require("formatters.biome").setup(group)
	require("formatters.stylua").setup(group)
	require("formatters.black").setup(group)
	require("formatters.beautysh").setup(group)
	require("formatters.prettier").setup(group)
	require("formatters.markdownlint").setup(group) -- linter, runs after save
end

return M
