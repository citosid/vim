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

vim.opt.concealcursor = ""

-- First, define the highlight group
vim.api.nvim_set_hl(0, "HlyYellow", { ctermbg = "yellow", bg = "yellow", fg = "black" })
vim.api.nvim_set_hl(0, "HlyGreen", { ctermbg = "green", bg = "green", fg = "white" })
vim.api.nvim_set_hl(0, "HlyRed", { ctermbg = "red", bg = "red", fg = "white" })
vim.api.nvim_set_hl(0, "HlyOrange", { ctermbg = "red", bg = "red", fg = "black" })
vim.api.nvim_set_hl(0, "HlyBlue", { ctermbg = "blue", bg = "blue", fg = "white" })

-- Use a regular expression to highlight \hly{...} in Markdown files
vim.cmd([[
  augroup HlyHighlight
    autocmd!
    autocmd FileType markdown lua vim.fn.matchadd('HlyYellow', '\\\\hly{\\(\\_.\\{-}\\)*\\}', 10)
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hly{\\|\\}\\ze\\(\\s\\|$\\)', 10, -1, {conceal = ''})

    autocmd FileType markdown lua vim.fn.matchadd('HlyGreen', '\\\\hlg{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlg{\\|\\}\\ze\\(\\s\\|$\\)', 10, -1, {conceal = ''})

    autocmd FileType markdown lua vim.fn.matchadd('HlyRed', '\\\\hlr{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlr{\\|\\}\\ze\\(\\s\\|$\\)', 10, -1, {conceal = ''})

    autocmd FileType markdown lua vim.fn.matchadd('HlyOrange', '\\\\hlo{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlo{\\|\\}\\ze\\(\\s\\|$\\)', 10, -1, {conceal = ''})

    autocmd FileType markdown lua vim.fn.matchadd('HlyBlue', '\\\\hlb{\\(\\_.\\{-}\\)*\\}')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlb{\\|\\}\\ze\\(\\s\\|$\\)', 10, -1, {conceal = ''})
  augroup END
]])
