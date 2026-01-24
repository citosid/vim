-- lsp/bashls.lua
-- Bash language server configuration

return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git" },
}
