vim.cmd([[
  hi NeoTreeNormal guibg=None,
  hi NeoTreeNormalNC guibg=None,
]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

