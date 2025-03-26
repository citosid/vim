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
					"harper_ls",
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
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local setup_options = {
				capabilities = capabilities,
			}

			-- Each one of these are the ones added in mason-lspconfig.nvim
			lspconfig.bashls.setup(setup_options)
			lspconfig.harper_ls.setup({
				capabilities = capabilities,
				settings = {
					["harper-ls"] = {
						isolateEnglish = true,
					},
				},
			})
			lspconfig.lua_ls.setup(setup_options)
			lspconfig.pyright.setup(setup_options)
			lspconfig.gopls.setup(setup_options)

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", function()
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
