local map = require("utils").map

-- Disable annoying Q
map("n", "Q", "<nop>")

-- Set space as the global leader
map("n", "<Space>", "<Nop>", { silent = true })

-- Save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Exit insert mode
map("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
map("i", "<Esc>", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Buffer navigation
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Go to previous buffer" })
map("n", "<leader>l", "<cmd>b#<cr>", { desc = "Switch to last buffer" })

-- Hide search results
map("n", "<leader>ns", "<cmd>noh<cr>", { desc = "Hide search results" })

-- Edit .gitlab-ci.yml
map("n", "<leader>.", "<cmd>e .gitlab-ci.yml<CR>", { desc = "Opens the Gitlab CI file" })

-- Turn file into executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Spelling
map("n", "<leader>sa", "1z=", { desc = "Accept first spelling suggestion", noremap = true, silent = true })
map("n", "<leader>sd", "zw", { desc = "Remove word from spelling dictionary", noremap = true, silent = true })
map("n", "<leader>sg", "zg", { desc = "Add word to spelling dictionary", noremap = true, silent = true })
map("n", "<leader>sn", "]s", { desc = "Go to next spelling error", noremap = true, silent = true })
map("n", "<leader>s?", "z=", { desc = "Show spelling suggestions", noremap = true, silent = true })
map("n", "<leader>cse", "<cmd>set spelllang=es<CR>", { desc = "Change spell language to Spanish" })

-- Native commenting with <leader>/
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

-- Pandoc highlights (for LaTeX documents)
map("v", "<leader>hy", 'c\\hly{<c-r>"}<esc>', { desc = "Highlight yellow" })
map("v", "<leader>hg", 'c\\hlg{<c-r>"}<esc>', { desc = "Highlight green" })
map("v", "<leader>hb", 'c\\hlb{<c-r>"}<esc>', { desc = "Highlight blue" })
map("v", "<leader>hr", 'c\\hlr{<c-r>"}<esc>', { desc = "Highlight red" })
map("v", "<leader>ho", 'c\\hlo{<c-r>"}<esc>', { desc = "Highlight orange" })
map("v", "<leader>hp", 'c\\hlpn{<c-r>"}<esc>', { desc = "Highlight paragraph number" })
map("v", "<leader>hq", 'c\\hlq{<c-r>"}<esc>', { desc = "Highlight question" })

-- Pandoc points
map({ "v", "n" }, "<leader>tmp", 'c\\mainpoint{<c-r>"}<esc>', { desc = "Main point" })
map({ "v", "n" }, "<leader>tsp", 'c\\secondarypoint{<c-r>"}<esc>', { desc = "Secondary point" })
map({ "v", "n" }, "<leader>ttp", 'c\\tertiarypoint{<c-r>"}<esc>', { desc = "Tertiary point" })
map({ "v", "n" }, "<leader>tqp", 'c\\quaternarypoint{<c-r>"}<esc>', { desc = "Quaternary point" })
map({ "v", "n" }, "<leader>tup", 'c\\quinarypoint{<c-r>"}<esc>', { desc = "Quinary point" })

-- Pandoc build commands
map("n", "<leader>pb", function()
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
	vim.fn.system(command)

	if vim.v.shell_error == 0 then
		vim.notify("PDF created successfully: " .. output_file)
	else
		vim.notify("Error in creating PDF", vim.log.levels.ERROR)
	end
end, { desc = "Build PDF from markdown", noremap = true, silent = true })

map("n", "<leader>pl", function()
	local input_file = vim.fn.expand("%")
	local output_file = input_file:gsub("(.*/)(.*)%.md$", "%1pdf/%2.pdf")
	local cwd = vim.fn.getcwd()
	local header_file = cwd .. "/header.letter.tex"
	local command = "pandoc --from=gfm --to=pdf '"
		.. input_file
		.. "' --template='"
		.. header_file
		.. "' -o '"
		.. output_file
		.. "'"

	vim.notify(command)
	vim.fn.system(command)

	if vim.v.shell_error == 0 then
		vim.notify("Letter PDF created successfully: " .. output_file)
	else
		vim.notify("Error in creating letter PDF", vim.log.levels.ERROR)
	end
end, { desc = "Build letter PDF from markdown", noremap = true, silent = true })

-- Typewriter mode toggle
map("n", "<leader>tw", function()
	if vim.opt.scrolloff:get() == 999 then
		vim.opt.scrolloff = 4
		vim.notify("Typewriter mode OFF", vim.log.levels.INFO)
	else
		vim.opt.scrolloff = 999
		vim.notify("Typewriter mode ON", vim.log.levels.INFO)
	end
end, { desc = "Toggle typewriter mode", noremap = true, silent = true })
