local map = require("utils").map

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Go to next buffer" })

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

-- Debugging and breakpoints
map("n", "<leader>dd", "<cmd>lua require('dap').debug()<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" })
map("n", "<leader>dq", "<cmd>lua require('dap').close()<cr>", { desc = "Close the debugger window" })
map("n", "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })

-- Disable annoying Q
map("n", "Q", "<nop>")

-- Edit easily .gitlab-ci.yml files
map("n", "<leader>.", "<cmd>e .gitlab-ci.yml<CR>", { desc = "Opens the Gitlab CI file to be edited." })

-- Hide search results
map("n", "<leader>ns", "<cmd>noh<cr>", { desc = "Hide search results" })

-- Refactor
map(
	{ "n", "x" },
	"<leader>ri",
	"<cmd>lua vim.lsp.buf.rename()<cr>",
	{ desc = "Rename pointer under cursor for current buffer" }
)

-- Save
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })

-- Set space as the global leader
map("n", "<Space>", "<Nop>", { silent = true })

-- Set jj to esc
map("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Splits
map("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end)
map("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end)
map("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end)
map("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end)

map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Splits the window vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Splits the window horizontally" })

-- Telescope
map("n", "<leader><space>", function()
	require("telescope.builtin").buffers()
end, { desc = "Go to next buffer" })
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files in current pwd" })
map("n", "<leader>fs", function()
	require("telescope.builtin").lsp_document_symbols()
end, { desc = "Find in symbols" })
map("n", "<leader>fw", function()
	require("telescope.builtin").live_grep()
end, { desc = "Grep find" })

-- Terminal
map("n", "<leader>t", "<cmd>exe v:count1 . 'ToggleTerm name=terminal'<cr>", { desc = "Open or toggle terminal" })

-- Turn the current file into an executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Turn the current file into an executable", silent = true })
