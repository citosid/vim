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

vim.api.nvim_set_hl(0, "HlyBlue", { bg = "#89b4fa", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "HlyGreen", { bg = "#a6e3a1", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "HlyOrange", { bg = "#fab387", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "HlyRed", { bg = "#f38ba8", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "HlyYellow", { bg = "#f9e2af", fg = "#1e1e2e" })

vim.api.nvim_set_hl(0, "HlyItalic", { fg = "#cdd6f4", italic = true }) -- Italic highlight
vim.api.nvim_set_hl(0, "HlyBold", { fg = "#f5e0dc", bold = true }) -- Bold highlight

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

    autocmd FileType markdown lua vim.fn.matchadd('HlyRed', '\\\\marginpar{\\([^{}]*\\|{[^{}]*}\\)*}')

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hl[bgoqry]{\\|}', 10, -1, {conceal = '', containedin = 'ALL'})
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlpn{\\|\\}\\ze.', 10, -1, {conceal = ''})

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\marginpar{\\|\\}\\ze.', 10, -1, {conceal = ''})
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\color\\[rgb\\]{\\([^}]*\\)}', 10)

    au FileType markdown setlocal conceallevel=2
    au FileType markdown setlocal textwidth=120
    au FileType markdown setlocal spell
  augroup END
]])
