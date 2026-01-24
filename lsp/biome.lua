-- lsp/biome.lua
-- Biome language server configuration (JS/TS/JSON formatter and linter)

return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
	root_markers = { "biome.json", "biome.jsonc" },
}
