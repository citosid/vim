return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	config = function()
		-- Define custom highlight groups
		vim.cmd([[
      highlight GitSignsAdd guifg=#A6D189
      highlight GitSignsChange guifg=#A3D9F9
      highlight GitSignsDelete guifg=#F5C2E7
      highlight GitSignsTopDelete guifg=#D9A0D3
      highlight GitSignsChangeDelete guifg=#F6C177
      highlight GitSignsUntracked guifg=#75B8A9
    ]])

		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 250,
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>gB", gitsigns.blame, { desc = "Git blame" })
			end,
		})
	end,
}
