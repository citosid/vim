-- lua/completion.lua
-- Native LSP completion configuration

local M = {}

function M.setup()
	-- Completion options
	vim.opt.completeopt = "menu,menuone,noselect"

	-- Make completion trigger faster
	vim.opt.updatetime = 50

	-- Enter to accept completion
	vim.keymap.set("i", "<CR>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-y>"
		else
			return "<CR>"
		end
	end, { expr = true, noremap = true, desc = "Accept completion or newline" })

	-- Arrow keys to navigate completion menu
	vim.keymap.set("i", "<Down>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-n>"
		else
			return "<Down>"
		end
	end, { expr = true, noremap = true, desc = "Next completion or move down" })

	vim.keymap.set("i", "<Up>", function()
		if vim.fn.pumvisible() == 1 then
			return "<C-p>"
		else
			return "<Up>"
		end
	end, { expr = true, noremap = true, desc = "Previous completion or move up" })

	-- Disable Copilot's Tab mapping - we'll handle Tab ourselves
	vim.g.copilot_no_tab_map = true

	-- Tab closes completion menu if open, otherwise normal tab
	-- This runs AFTER plugins load via VimEnter
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.keymap.set("i", "<Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-e><Tab>"
				else
					return "<Tab>"
				end
			end, { expr = true, noremap = true, desc = "Insert tab (ignore completion)" })
		end,
	})
end

return M
