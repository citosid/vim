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

-- Function to apply markdown highlighting
local function apply_markdown_highlights()
	vim.fn.matchadd("HlyBlue", "\\\\hlb{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyGreen", "\\\\hlg{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyOrange", "\\\\hlo{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyRed", "\\\\hlr{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyYellow", "\\\\hly{\\(\\_.\\{-}\\)*\\}", 10)
	vim.fn.matchadd("HlyItalic", "\\\\hlq{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyBold", "\\\\hlpn{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyRed", "\\\\marginpar{\\([^{}]*\\|{[^{}]*}\\)*}")
	-- 	vim.fn.matchadd("Conceal", "\\\\hl[bgoqry]{\\|}")
	-- 	vim.fn.matchadd("Conceal", "\\\\hlpn{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\marginpar{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\color\\[rgb\\]{\\([^}]*\\)}")
	-- 	vim.fn.matchadd("Conceal", "\\\\{width*}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\note{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\textit{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\mainpoint{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\secondarypoint{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\tertiarypoint{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\quaternarypoint{\\|\\}\\ze.")
	-- 	vim.fn.matchadd("Conceal", "\\\\quinarypoint{\\|\\}\\ze.")
end
--
-- Make function global so it can be called from autocmd
_G.apply_markdown_highlights = apply_markdown_highlights

-- Original autocmd configuration
vim.cmd([[
  augroup MarkdownSettings
    autocmd!
    autocmd FileType markdown lua apply_markdown_highlights()
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

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			require("telescope.builtin").find_files()
		end
	end,
})
