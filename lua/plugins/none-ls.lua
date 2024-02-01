return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-null-ls").setup({
				-- Each of one of these needs to be added in the configuration for none-ls.nvim
				ensure_installed = {
					-- Diagnostics
					"eslint_d",
					"hadolint",
					"markdownlint", -- This is both, formatter and diagnostics
					"shellharden", -- This is both, formatter and diagnostics

					-- Formatters
					"black",
					"isort",
					"jq",
					"prettier",
					"stylua",
				},
			})
		end,
		lazy = true,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		lazy = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				-- These come from the configuration for mason-null-ls.nvim

				-- Diagnostics
				nls.builtins.diagnostics.eslint_d,
				nls.builtins.diagnostics.hadolint,
				nls.builtins.diagnostics.markdownlint,
				-- nls.builtins.diagnostics.shellharden,

				-- Formatter
				nls.builtins.formatting.black,
				nls.builtins.formatting.isort,
				nls.builtins.formatting.jq,
				nls.builtins.formatting.markdownlint,
				nls.builtins.formatting.prettier,
				nls.builtins.formatting.shellharden,
				nls.builtins.formatting.stylua,
			})

			opts.on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									-- only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end
		end,
	},
}
