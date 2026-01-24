-- lua/autocmds.lua
-- Autocommands for bim configuration

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})

-- Apply markdown highlight colors (must run after colorscheme)
local function setup_highlight_colors()
	-- Color highlights
	vim.api.nvim_set_hl(0, "HlyBlue", { bg = "#89b4fa", fg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "HlyGreen", { bg = "#a6e3a1", fg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "HlyOrange", { bg = "#fab387", fg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "HlyRed", { bg = "#f4a7b6", fg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "HlyYellow", { bg = "#f9e2af", fg = "#1e1e2e" })

	-- Text highlights
	vim.api.nvim_set_hl(0, "HlyItalic", { fg = "#cdd6f4", italic = true })
	vim.api.nvim_set_hl(0, "HlyBold", { fg = "#f5e0dc", bold = true })
end

-- Set up highlights after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = setup_highlight_colors,
})

-- Also run now in case colorscheme already loaded
setup_highlight_colors()

-- Function to apply markdown highlighting
local function apply_markdown_highlights()
	-- Color highlights - match the full \hlX{...} pattern
	vim.fn.matchadd("HlyBlue", "\\\\hlb{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyGreen", "\\\\hlg{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyOrange", "\\\\hlo{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyRed", "\\\\hlr{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyYellow", "\\\\hly{\\(\\_.\\{-}\\)*\\}", 10)
	vim.fn.matchadd("HlyItalic", "\\\\hlq{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyBold", "\\\\hlpn{\\(\\_.\\{-}\\)*\\}")
	vim.fn.matchadd("HlyRed", "\\\\marginpar{\\([^{}]*\\|{[^{}]*}\\)*}")

	-- Conceal only the \hlX prefix (not the braces)
	vim.fn.matchadd("Conceal", "\\\\hlb")
	vim.fn.matchadd("Conceal", "\\\\hlg")
	vim.fn.matchadd("Conceal", "\\\\hlo")
	vim.fn.matchadd("Conceal", "\\\\hlr")
	vim.fn.matchadd("Conceal", "\\\\hly")
	vim.fn.matchadd("Conceal", "\\\\hlq")
	vim.fn.matchadd("Conceal", "\\\\hlpn")
	vim.fn.matchadd("Conceal", "\\\\marginpar")
	vim.fn.matchadd("Conceal", "\\\\note")
	vim.fn.matchadd("Conceal", "\\\\textit")
	vim.fn.matchadd("Conceal", "\\\\mainpoint")
	vim.fn.matchadd("Conceal", "\\\\secondarypoint")
	vim.fn.matchadd("Conceal", "\\\\tertiarypoint")
	vim.fn.matchadd("Conceal", "\\\\quaternarypoint")
	vim.fn.matchadd("Conceal", "\\\\quinarypoint")
end

_G.apply_markdown_highlights = apply_markdown_highlights

-- Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- Enable treesitter highlighting (required for render-markdown callouts)
		vim.treesitter.start()
		apply_markdown_highlights()
		vim.opt_local.textwidth = 120
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 2
		vim.opt_local.concealcursor = "nc"
	end,
})

-- Virtual indentation for notes directory
local notes_dir = "/Users/acruz/Library/CloudStorage/Dropbox/Personal/notes"
local debounce_timer = {}

local function is_in_notes_dir()
	local buf_path = vim.fn.expand("%:p")
	return buf_path:sub(1, #notes_dir) == notes_dir
end

local function add_virtual_indentation()
	if not is_in_notes_dir() then
		return
	end

	local ns_id = vim.api.nvim_create_namespace("indent_virtual_text")
	local bufnr = vim.api.nvim_get_current_buf()

	if debounce_timer[bufnr] then
		vim.fn.timer_stop(debounce_timer[bufnr])
	end

	debounce_timer[bufnr] = vim.fn.timer_start(150, function()
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local indent_map = {
			["\\mainpoint"] = "",
			["\\secondarypoint"] = "    ",
			["\\tertiarypoint"] = "        ",
			["\\quaternarypoint"] = "            ",
			["\\quinarypoint"] = "                ",
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

-- Open fzf-lua on startup if no file specified
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			require("fzf-lua").files()
		end
	end,
})
