return {
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
		keys = {
			{
				"<leader>cr",
				function()
					require("inc_rename")
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "IncRename",
			},
		},
	}
