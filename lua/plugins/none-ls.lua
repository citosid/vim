return {
	"nvimtools/none-ls.nvim",
	-- optional = true,
	opts = function(_, opts)
		local nls = require("null-ls")
		opts.sources = vim.list_extend(opts.sources or {}, {
			-- Diagnostics
			nls.builtins.diagnostics.eslint_d,
			nls.builtins.diagnostics.markdownlint,

			-- Formatting
			-- nls.builtins.formatting.autopep8,
			-- nls.builtins.formatting.black,
			-- nls.builtins.formatting.isort,
			nls.builtins.formatting.markdownlint,
			nls.builtins.formatting.prettier,
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
}
