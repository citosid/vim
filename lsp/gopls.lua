-- lsp/gopls.lua
-- Override nvim-lspconfig defaults for additional analysis

return {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
}
