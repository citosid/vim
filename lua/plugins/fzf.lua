-- lua/plugins/fzf.lua
-- fzf-lua configuration (fuzzy finder)

local fzf = require("fzf-lua")

fzf.setup({
	-- Ivy-like theme (bottom panel)
	winopts = {
		height = 0.40,
		width = 1,
		row = 1,
		col = 0,
		border = "rounded",
		preview = {
			layout = "horizontal",
			horizontal = "right:50%",
		},
	},

	-- Keymaps inside fzf window
	keymap = {
		fzf = {
			["ctrl-j"] = "down",
			["ctrl-k"] = "up",
			["ctrl-c"] = "abort",
		},
	},

	-- File picker options
	files = {
		prompt = "Files❯ ",
		git_icons = false,
		file_icons = true,
		color_icons = true,
	},

	-- Grep options
	grep = {
		prompt = "Rg❯ ",
		git_icons = false,
		file_icons = true,
	},

	-- Buffer picker
	buffers = {
		prompt = "Buffers❯ ",
		file_icons = true,
		color_icons = true,
	},
})

-- File navigation
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader><space>", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fw", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fg", fzf.grep, { desc = "Grep pattern" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })

-- LSP integration
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_document, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>f2", fzf.lsp_implementations, { desc = "Implementations" })

-- Additional pickers
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fc", fzf.commands, { desc = "Commands" })
