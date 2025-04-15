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
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Spelling
map("n", "<leader>sa", "1z=", { desc = "Accept first spelling suggestion", noremap = true, silent = true })
map("n", "<leader>sd", "zw", { desc = "Remove word from spelling dictionary", noremap = true, silent = true })
map("n", "<leader>sg", "zg", { desc = "Add word to spelling dictionary", noremap = true, silent = true })
map("n", "<leader>sn", "]s", { desc = "Go to next spelling error", noremap = true, silent = true })
map("n", "<leader>s?", "z=", { desc = "Show spelling suggestions", noremap = true, silent = true })
map("n", "<leader>s/", "zR", { desc = "Replace word with suggestions", noremap = true, silent = true })

-- Set space as the global leader
map("n", "<Space>", "<Nop>", { silent = true })

-- Set jj to esc
map("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Turn the current file into an executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Turn the current file into an executable", silent = true })

-- Highlight for pandoc
map("v", "<leader>hy", 'c\\hly{<c-r>"}<esc>', { desc = "Highlight yellow" })
map("v", "<leader>hg", 'c\\hlg{<c-r>"}<esc>', { desc = "Highlight green" })
map("v", "<leader>hb", 'c\\hlb{<c-r>"}<esc>', { desc = "Highlight blue" })
map("v", "<leader>hr", 'c\\hlr{<c-r>"}<esc>', { desc = "Highlight red" })
map("v", "<leader>ho", 'c\\hlo{<c-r>"}<esc>', { desc = "Highlight orange" })
map("v", "<leader>hp", 'c\\hlpn{<c-r>"}<esc>', { desc = "Highlight paragraph number" })
map("v", "<leader>hq", 'c\\hlq{<c-r>"}<esc>', { desc = "Highlight question" })

map({ "v", "n" }, "<leader>tmp", 'c\\mainpoint{<c-r>"}<esc>', { desc = "Highlight main point" })
map({ "v", "n" }, "<leader>tsp", 'c\\secondarypoint{<c-r>"}<esc>', { desc = "Highlight secondary point" })
map({ "v", "n" }, "<leader>ttp", 'c\\tertiarypoint{<c-r>"}<esc>', { desc = "Highlight tertiarypoint point" })
map({ "v", "n" }, "<leader>tqp", 'c\\quaternarypoint{<c-r>"}<esc>', { desc = "Highlight quaternary point" })
map({ "v", "n" }, "<leader>tup", 'c\\quinarypoint{<c-r>"}<esc>', { desc = "Highlight quinarypoint point" })

-- Key maps for pandoc
map("n", "<leader>bp", function()
	local input_file = vim.fn.expand("%")
	local output_file = input_file:gsub("(.*/)(.*)%.md$", "%1pdf/%2.pdf")
	local cwd = vim.fn.getcwd()
	local header_file = cwd .. "/header.tex"
	local command = "pandoc '"
		.. input_file
		.. "' --include-in-header='"
		.. header_file
		.. "' --pdf-engine=xelatex -o '"
		.. output_file
		.. "'"

	vim.notify(command)

	-- Execute the command silently
	vim.fn.system(command)

	-- Check if the command was successful and notify
	if vim.v.shell_error == 0 then
		vim.notify("PDF created successfully: " .. output_file)
	else
		vim.notify("Error in creating PDF", vim.log.levels.ERROR)
	end
end, {
	desc = "Turn the markdown file into a pdf",
	noremap = true,
	silent = true,
})

-- Key maps for spelling
map("n", "<leader>cse", "<cmd>set spelllang=es<CR>", { desc = "Change spell language to Spanish" })
