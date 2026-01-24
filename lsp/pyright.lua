-- lsp/pyright.lua
-- Override nvim-lspconfig defaults for workspace-wide diagnostics

return {
	settings = {
		python = {
			analysis = {
				diagnosticMode = "workspace",
			},
		},
	},
}
