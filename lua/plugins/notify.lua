return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#00000000",
		})

    vim.opt.termguicolors = true -- True color support
    vim.notify = require("notify")
	end,
}
