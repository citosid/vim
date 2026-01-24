-- lua/plugins.lua
-- Plugin declarations using native vim.pack.add()

vim.pack.add({
	-- LSP (provides lsp/*.lua defaults, merged with our overrides)
	{ src = "git@github.com:neovim/nvim-lspconfig" },

	-- Fuzzy finder
	{ src = "git@github.com:ibhagwan/fzf-lua" },

	-- AI
	{ src = "git@github.com:github/copilot.vim" },

	-- Git
	{ src = "git@github.com:lewis6991/gitsigns.nvim" },

	-- Treesitter
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter" },

	-- UI
	{ src = "git@github.com:nvim-lualine/lualine.nvim" },
	{ src = "git@github.com:folke/noice.nvim" },
	{ src = "git@github.com:MunifTanjim/nui.nvim" }, -- noice dependency

	-- mini.nvim modules
	{ src = "git@github.com:echasnovski/mini.files" },
	{ src = "git@github.com:echasnovski/mini.icons" },
	{ src = "git@github.com:echasnovski/mini.bufremove" },
	{ src = "git@github.com:echasnovski/mini.pairs" },
	{ src = "git@github.com:echasnovski/mini.test" }, -- for testing

	-- Tools
	{ src = "git@github.com:akinsho/toggleterm.nvim" },
	{ src = "git@github.com:mrjones2014/smart-splits.nvim" },

	-- Markdown
	{ src = "git@github.com:MeanderingProgrammer/render-markdown.nvim" },

	-- Misc
	{ src = "git@github.com:catgoose/nvim-colorizer.lua" },

	-- Personal
	{ src = vim.fn.expand("~/code/personal/jwtools.nvim") },
})
