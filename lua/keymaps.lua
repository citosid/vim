local map = require("utils").map

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Go to previous buffer" })

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

-- Turn the current file into an executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Turn the current file into an executable", silent = true })

-- Test
map("n", "<leader>jw", "<cmd>FetchScripture<CR>", { desc = "Fetch scripture" })
