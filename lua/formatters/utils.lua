-- lua/formatters/utils.lua
-- Shared utilities for formatters

local M = {}

-- Format buffer with external command via stdin (using vim.system)
function M.format_with_cmd(cmd)
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local content = table.concat(lines, "\n")

	local result = vim.system(cmd, { stdin = content, text = true }):wait()

	if result.code == 0 and result.stdout and result.stdout ~= "" then
		local formatted = vim.split(result.stdout, "\n", { plain = true })
		-- Remove trailing empty line if present
		if formatted[#formatted] == "" then
			table.remove(formatted)
		end
		-- Only update if content changed
		if not vim.deep_equal(lines, formatted) then
			local cursor = vim.api.nvim_win_get_cursor(0)
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
			cursor[1] = math.min(cursor[1], #formatted)
			pcall(vim.api.nvim_win_set_cursor, 0, cursor)
		end
	end
end

-- Check if command exists
function M.cmd_exists(cmd)
	return vim.fn.executable(cmd) == 1
end

return M
