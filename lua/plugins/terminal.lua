-- lua/plugins/terminal.lua
-- toggleterm and smart-splits configuration

-- toggleterm setup
require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = nil, -- We'll set our own
	direction = "float",
	float_opts = {
		border = "rounded",
		width = function()
			return math.floor(vim.o.columns * 0.85)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.85)
		end,
	},
	highlights = {
		FloatBorder = { link = "FloatBorder" },
	},
})

-- Terminal keymaps
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-j><C-j>", "<cmd>ToggleTerm<cr>", { desc = "Close terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Lazygit terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "rounded",
		width = function()
			return math.floor(vim.o.columns * 0.95)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.95)
		end,
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		-- Close with q in normal mode
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
	end,
})

vim.keymap.set("n", "<leader>gg", function()
	lazygit:toggle()
end, { desc = "Lazygit" })

-- smart-splits setup
require("smart-splits").setup({
	-- Ignored filetypes (only while determining if cursor is at edge)
	ignored_filetypes = { "nofile", "quickfix", "prompt" },
	-- Ignored buffer types
	ignored_buftypes = { "NvimTree" },
	-- Default amount to resize by
	default_amount = 3,
	-- At edge behavior
	at_edge = "stop",
	-- Multiplexer integration
	multiplexer_integration = "tmux",
})

-- Split navigation
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right split" })

-- Split resizing
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize left" })
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize down" })
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize up" })
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize right" })

-- Swap buffers between splits
vim.keymap.set("n", "<leader>bh", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
vim.keymap.set("n", "<leader>bj", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
vim.keymap.set("n", "<leader>bk", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
vim.keymap.set("n", "<leader>bl", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })

-- Create splits
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })
