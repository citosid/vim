-- lua/formatters/prettier.lua
-- Prettier formatter for Markdown files

local utils = require("formatters.utils")

local M = {}

function M.setup(group)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = { "*.md" },
		callback = function()
			if not utils.cmd_exists("prettier") then
				return
			end
			local filename = vim.api.nvim_buf_get_name(0)
			utils.format_with_cmd({
				"prettier",
				"--stdin-filepath",
				filename,
			})
		end,
	})
end

return M
