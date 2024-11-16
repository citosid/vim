return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		enabled = true,
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
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
							fmt = function(str)
								local mode_icons = {
									["NORMAL"] = "",
									["INSERT"] = "",
									["VISUAL"] = "",
									["REPLACE"] = "",
									["COMMAND"] = "",
								}
								return mode_icons[str] or str
							end,
						},
					},
					lualine_b = {
						{ "branch", icon = "" },
						{
							"diff",
							symbols = {
								added = " ",
								modified = " ",
								removed = " ",
							},
						},
						{
							"diagnostics",
							sections = { "error", "warn", "info", "hint" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = " ",
							},
						},
					},
					lualine_c = {
						{
							"filename",
							icon = "",
							file_status = true,
							path = 1,
						},
					},
					lualine_x = {
						{
							"encoding",
							icon = "",
						},
						{
							"fileformat",
							icon = "",
						},
						"filetype",
					},
					lualine_y = {
						{
							"progress",
							icon = "",
						},
					},
					lualine_z = {
						{
							"location",
							icon = "",
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
