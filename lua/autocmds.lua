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
vim.api.nvim_set_hl(0, "HlyRed", { bg = "#f4a7b6", fg = "#1e1e2e" })
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

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hl[bgoqry]{\\|}')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\hlpn{\\|\\}\\ze.')

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\marginpar{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\color\\[rgb\\]{\\([^}]*\\)}')

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\{width*}\\ze.')

    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\note{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\textit{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\mainpoint{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\secondarypoint{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\tertiarypoint{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\quaternarypoint{\\|\\}\\ze.')
    autocmd FileType markdown lua vim.fn.matchadd('Conceal', '\\\\quinarypoint{\\|\\}\\ze.')

    au FileType markdown setlocal textwidth=120
    au FileType markdown setlocal spell
  augroup END
]])

local function add_virtual_indentation()
	local ns_id = vim.api.nvim_create_namespace("indent_virtual_text")
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1) -- Clear previous virtual text

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local indent_map = {
		["\\mainpoint"] = "", -- 0 spaces
		["\\secondarypoint"] = "    ", -- 4 spaces
		["\\tertiarypoint"] = "        ", -- 8 spaces
		["\\quaternarypoint"] = "            ", -- 12 spaces
		["\\quinarypoint"] = "                ", -- 16 spaces
	}

	for i, line in ipairs(lines) do
		for pattern, indent in pairs(indent_map) do
			local start_idx = line:find(pattern)
			if start_idx then
				vim.api.nvim_buf_set_extmark(0, ns_id, i - 1, 0, {
					virt_text = { { indent, "NonText" } },
					virt_text_pos = "inline",
				})
				break
			end
		end
	end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter", "TextChanged", "TextChangedI" }, {
	pattern = "*.md",
	callback = add_virtual_indentation,
})
