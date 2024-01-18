return {
	"folke/zen-mode.nvim",
	keys = {
		{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
	},
	opts = {
		window = {
			options = {
				signcolumn = "no", -- disable signcolumn
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false, -- disables the ruler text in the cmd line area
				showcmd = false, -- disables the command in the last line of the screen
				-- you may turn on/off statusline in zen mode by setting 'laststatus'
				-- statusline will be shown only if 'laststatus' == 3
				laststatus = 0, -- turn off the statusline in zen mode
			},
			twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
			gitsigns = { enabled = false }, -- disables git signs
			tmux = { enabled = false }, -- disables the tmux statusline
		},
	},
}
