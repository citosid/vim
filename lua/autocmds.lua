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

-- Get dynamic colors from Catppuccin palette
local function setup_highlight_colors()
	local cat = require("catppuccin.palettes").get_palette()
	local base = cat.base
	local text = cat.text

	-- Color highlights: use theme colors instead of hardcoded hex
	vim.api.nvim_set_hl(0, "HlyBlue", { bg = cat.blue, fg = base })
	vim.api.nvim_set_hl(0, "HlyGreen", { bg = cat.green, fg = base })
	vim.api.nvim_set_hl(0, "HlyOrange", { bg = cat.peach, fg = base })
	vim.api.nvim_set_hl(0, "HlyRed", { bg = cat.red, fg = base })
	vim.api.nvim_set_hl(0, "HlyYellow", { bg = cat.yellow, fg = base })

	-- Text highlights: use light foreground colors
	vim.api.nvim_set_hl(0, "HlyItalic", { fg = text, italic = true })
	vim.api.nvim_set_hl(0, "HlyBold", { fg = cat.cream, bold = true })
end

-- Set up highlights on startup and when colorscheme changes
setup_highlight_colors()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = setup_highlight_colors,
	desc = "Update highlight colors when colorscheme changes",
})

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
	vim.fn.matchadd("Conceal", "\\\\hl[bgoqry]")
	vim.fn.matchadd("Conceal", "\\\\hlpn")
	vim.fn.matchadd("Conceal", "\\\\marginpar")
	vim.fn.matchadd("Conceal", "\\\\{width*}\\ze.")
	vim.fn.matchadd("Conceal", "\\\\note")
	vim.fn.matchadd("Conceal", "\\\\textit")
	vim.fn.matchadd("Conceal", "\\\\mainpoint")
	vim.fn.matchadd("Conceal", "\\\\secondarypoint")
	vim.fn.matchadd("Conceal", "\\\\tertiarypoint")
	vim.fn.matchadd("Conceal", "\\\\quaternarypoint")
	vim.fn.matchadd("Conceal", "\\\\quinarypoint")
end
--
-- Make function global so it can be called from autocmd
_G.apply_markdown_highlights = apply_markdown_highlights

-- Markdown-specific settings (spell language configured in options.lua)
vim.cmd([[
  augroup MarkdownSettings
    autocmd!
    autocmd FileType markdown lua apply_markdown_highlights()
    au FileType markdown setlocal textwidth=120
    au FileType markdown setlocal spell
  augroup END
]])

local notes_dir = "/Users/acruz/Library/CloudStorage/Dropbox/Personal/notes"
local debounce_timer = {}

local function is_in_notes_dir()
	local buf_path = vim.fn.expand("%:p")
	return buf_path:sub(1, #notes_dir) == notes_dir
end

local function add_virtual_indentation()
	-- Only run for files in notes directory
	if not is_in_notes_dir() then
		return
	end

	local ns_id = vim.api.nvim_create_namespace("indent_virtual_text")
	local bufnr = vim.api.nvim_get_current_buf()

	-- Debounce: cancel previous timer and set new one
	if debounce_timer[bufnr] then
		vim.fn.timer_stop(debounce_timer[bufnr])
	end

	debounce_timer[bufnr] = vim.fn.timer_start(150, function()
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		-- Clear namespace and recompute
		vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
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
					vim.api.nvim_buf_set_extmark(bufnr, ns_id, i - 1, 0, {
						virt_text = { { indent, "NonText" } },
						virt_text_pos = "inline",
					})
					break
				end
			end
		end

		debounce_timer[bufnr] = nil
	end)
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
