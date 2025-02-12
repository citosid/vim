return {
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		main = "nvim-silicon",
		opts = {
			background = "#2e3440",
			output = function()
				return "/Users/acruz/Dropbox/Screenshots/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
			end,
			theme = "/Users/acruz/dotfiles/config/silicon/themes/Rose-Pine-Moon.tmTheme",
			to_clipboard = true,
			window_title = function()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
			end,
		},
	},
}
