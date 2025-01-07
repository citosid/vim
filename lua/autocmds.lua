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

vim.api.nvim_set_hl(0, "HlyBlue", { bg = "#3e8fb0", fg = "#fffaf3" })
vim.api.nvim_set_hl(0, "HlyGreen", { bg = "#9ccfd8", fg = "#2a273f" })
vim.api.nvim_set_hl(0, "HlyOrange", { bg = "#ea9a97", fg = "#2a273f" })
vim.api.nvim_set_hl(0, "HlyRed", { bg = "#eb6f92", fg = "#2a273f" })
vim.api.nvim_set_hl(0, "HlyYellow", { bg = "#f6c177", fg = "#2a273f" })

vim.api.nvim_set_hl(0, "HlyItalic", { fg = "#fffaf3", italic = true })
vim.api.nvim_set_hl(0, "HlyBold", { fg = "#e0def4", bold = true })

vim.cmd([[
  augroup HlyHighlight
    autocmd!

    autocmd FileType markdown lua vim.fn.matchadd('HlyBlue', '\\\\hlb{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('HlyGreen', '\\\\hlg{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('HlyOrange', '\\\\hlo{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('HlyRed', '\\\\hlr{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('HlyYellow', '\\\\hly{\\(\\_.\\{-}\\)*\\}', 10)

    autocmd FileType markdown lua vim.fn.matchadd('HlyItalic', '\\\\hlq{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('HlyBold', '\\\\hlpn{\\(\\_.\\{-}\\)*\\}')

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hl[bgoqry]{\\|\\}\\ze.', 10, -1, {conceal = ''})
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlpn{\\|\\}\\ze.', 10, -1, {conceal = ''})

    au FileType markdown setlocal conceallevel=2
    au FileType markdown setlocal textwidth=120
    au FileType markdown setlocal spell
  augroup END
]])
