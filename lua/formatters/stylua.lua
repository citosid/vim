-- lua/formatters/stylua.lua
-- Stylua formatter for Lua

local utils = require("formatters.utils")

local M = {}

function M.setup(group)
	if not utils.cmd_exists("stylua") then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = "*.lua",
		callback = function()
			utils.format_with_cmd({ "stylua", "-" })
		end,
	})
end

return M
