-- lua/formatters/biome.lua
-- Biome formatter for JS/TS/JSON/CSS

local utils = require("formatters.utils")

local M = {}

function M.setup(group)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc", "*.css" },
		callback = function()
			if not utils.cmd_exists("biome") then
				return
			end
			local filename = vim.api.nvim_buf_get_name(0)
			utils.format_with_cmd({
				"biome",
				"check",
				"--config-path=/Users/acruz/biome.json",
				"--write",
				"--unsafe",
				"--formatter-enabled=true",
				"--format-with-errors=true",
				"--stdin-file-path=" .. filename,
			})
		end,
	})
end

return M
