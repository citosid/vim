local map = require("utils").map

-- Set space as the global leader
map("n", "<Space>", "<Nop>", { silent = true })

map("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Neotree
map("n", "<leader>p", "<cmd>Neotree toggle<cr>", { desc = "Open neo tree" })

-- Save
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })

-- Hide search results
map("n", "<leader>ns", "<cmd>noh<cr>", { desc = "Hide search results" })

-- Comments
map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Toggle comment" })
map(
	"v",
	"<leader>/",
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	{ desc = "Toggle comment for selection" }
)

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Go to next buffer" })

-- Telescope
map("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Go to next buffer" })
map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files in current pwd" })
map("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, { desc = "Find in symbols" })
map("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "Grep find" })

-- Splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Splits the window vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Splits the window horizontally" })

-- Terminal
map("n", "<leader>t", "<cmd>exe v:count1 . 'ToggleTerm name=terminal'<cr>", { desc = "Open or toggle terminal" })

-- Disable annoying Q
map("n", "Q", "<nop>")

-- Turn the current file into an executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Turn the current file into an executable", silent = true })
