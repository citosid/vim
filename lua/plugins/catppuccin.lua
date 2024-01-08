return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	opts = {
		flavour = "mocha",
		transparent_background = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			lsp_trouble = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true },
			neotest = true,
			noice = true,
			notify = true,
			nvimtree = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
			which_key = true,
		},
	},
	config = function()
		-- vim.cmd([[colorscheme catppuccin]])
    -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    -- vim.cmd([[hi NvimTreeNormal guibg=NONE]])
    -- vim.cmd([[hi NvimTreeNormalNC guibg=NONE]])
	end,
  setup = {
    flavour = "mocha",
    color_overrides = {
        mocha = {
            base = "None",
        },
    },
    integrations = {
        nvimtree = true,
    },
    highlight_overrides = {
        mocha = function(mocha)
            return {
                NvimTreeNormal = { bg = mocha.none },
                NvimTreeNormalNC = { bg = mocha.none },
            }
        end,
    },
}
}
