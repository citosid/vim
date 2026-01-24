-- lua/formatters/black.lua
-- Black formatter for Python

local utils = require("formatters.utils")

local M = {}

function M.setup(group)
	if not utils.cmd_exists("black") then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = "*.py",
		callback = function()
			utils.format_with_cmd({ "black", "--quiet", "-" })
		end,
	})
end

return M
