-- lua/formatters/beautysh.lua
-- Beautysh formatter for Bash/Shell

local utils = require("formatters.utils")

local M = {}

function M.setup(group)
	if not utils.cmd_exists("beautysh") then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = { "*.sh", "*.bash" },
		callback = function()
			utils.format_with_cmd({ "beautysh", "-" })
		end,
	})
end

return M
