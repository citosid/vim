vim.cmd([[
  hi NeoTreeNormal guibg=None,
  hi NeoTreeNormalNC guibg=None,
]])

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})
