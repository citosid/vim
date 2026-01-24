-- lua/plugins/buffers.lua
-- mini.bufremove and mini.pairs configuration

-- mini.bufremove - Buffer deletion
require("mini.bufremove").setup({})

-- Delete buffer with confirmation for modified buffers
vim.keymap.set("n", "<leader>bd", function()
	local bd = require("mini.bufremove").delete
	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 1 then -- Yes
			vim.cmd.write()
			bd(0)
		elseif choice == 2 then -- No
			bd(0, true)
		end
	else
		bd(0)
	end
end, { desc = "Delete Buffer" })

-- Force delete buffer
vim.keymap.set("n", "<leader>bD", function()
	require("mini.bufremove").delete(0, true)
end, { desc = "Delete Buffer (Force)" })

-- mini.pairs - Auto-pairs
require("mini.pairs").setup({})

-- Toggle auto pairs
vim.keymap.set("n", "<leader>up", function()
	vim.g.minipairs_disable = not vim.g.minipairs_disable
	if vim.g.minipairs_disable then
		vim.notify("Disabled auto pairs")
	else
		vim.notify("Enabled auto pairs")
	end
end, { desc = "Toggle auto pairs" })
