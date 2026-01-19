return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup({})
		end,
		event = "BufReadPre",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		config = function()
			require("mason-lspconfig").setup({
				-- Each of these needs also to be added in the config for
				-- nvim-lspconfig
				ensure_installed = {
					"bashls",
					-- "harper_ls",
					"lua_ls",
					"pyright",
				},
			})
		end,
		event = "BufReadPre",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Base setup options applied to all servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Individual server configs
			vim.lsp.config("bashls", {})
			-- vim.lsp.config("harper_ls", {
			--   capabilities = capabilities,
			--   settings = {
			--     ["harper-ls"] = {
			--       isolateEnglish = true,
			--     },
			--   },
			-- })
			vim.lsp.config("lua_ls", {})
			vim.lsp.config("pyright", {})
			vim.lsp.config("gopls", {})

			-- Enable all servers
			vim.lsp.enable({ "bashls", "lua_ls", "pyright", "gopls" })
			-- vim.lsp.enable("harper_ls")

			-- Global mappings.
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			-- Buffer-local mappings after attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
		event = "BufReadPre",
		opts = {
			--- other options
			servers = {
				tsserver = {
					on_attach = function(client)
						-- this is important, otherwise tsserver will format ts/js
						-- files which we *really* don't want.
						client.server_capabilities.documentFormattingProvider = false
					end,
				},
				biome = {},
			},
		},
	},
}
