return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = require("plugins.ui.lualine.prism"),
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			globalstatus = true,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(mode)
						local icons = {
							NORMAL = "󰊠",
							INSERT = "󰊄",
							VISUAL = "󰈈",
							["V-LINE"] = "󰡬",
							["V-BLOCK"] = "󰴅",
							REPLACE = "󰛔",
							COMMAND = "󰘳",
							TERMINAL = "󰆍",
						}
						return icons[mode] or mode
					end,
				},
			},
			lualine_b = {
				{
					"diff",
					symbols = {
						added = "󰐕 ",
						modified = "󰆓 ",
						removed = "󰍴 ",
					},
				},
				{
					"diagnostics",
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = "󰅚 ",
						warn = "󰀪 ",
						info = "󰋽 ",
						hint = "󰌶 ",
					},
				},
			},
			lualine_c = {
				{
					"filename",
					icon = "󰈙",
					path = 1,
				},
			},
			lualine_x = {
				{
					"filetype",
					icon_only = true,
					colored = true,
				},
			},
			lualine_y = {},
			lualine_z = {
				{
					"location",
					icon = "󰍉",
				},
			},
		},
	},
}
