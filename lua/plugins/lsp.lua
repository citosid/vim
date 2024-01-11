return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp_action.tab_complete(),
					["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
					-- ['<C-j>'] = cmp_action.luasnip_jump_forward(),
					-- ['<C-k>'] = cmp_action.luasnip_jump_backward(),
				}),
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			--- if you want to know more about lsp-zero and mason.nvim
			--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			---@diagnostic disable-next-line: unused-local
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
				local map = require("utils").map

				map("n", "gd", function()
					vim.lsp.buf.definition()
				end, { buffer = bufnr, remap = false, desc = "Go to definition" })
				map("n", "K", function()
					vim.lsp.buf.hover()
				end, { buffer = bufnr, remap = false, desc = "Show signature" })
				map("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, { buffer = bufnr, remap = false, desc = "View diagnostic" })
				map("n", "[d", function()
					vim.diagnostic.goto_next()
				end, { buffer = bufnr, remap = false, desc = "Go to next diagnostic" })
				map("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, { buffer = bufnr, remap = false, desc = "Go to previous diagnostic" })
				map("n", "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, { buffer = bufnr, remap = false, desc = "Open Code Actions" })
				map("n", "<leader>rr", function()
					vim.lsp.buf.references()
				end, { buffer = bufnr, remap = false, desc = "Open references" })
				map("n", "<leader>rn", function()
					vim.lsp.buf.rename()
				end, { buffer = bufnr, remap = false, desc = "Rename variable" })
				map("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, { buffer = bufnr, remap = false, desc = "Show signature" })
			end)

			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"pyright",
					"pylsp",
				},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
					tsserver = function()
						--- in this function you can setup
						--- the language server however you want.
						--- in this example we just use lspconfig

						require("lspconfig").tsserver.setup({
							---
							-- in here you can add your own
							-- custom configuration
							---
						})
					end,
				},
			})
		end,
	},
}
