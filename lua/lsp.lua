-- lua/lsp.lua
-- Native LSP configuration

local M = {}

function M.setup()
	-- Global defaults for all LSP servers
	vim.lsp.config("*", {
		root_markers = { ".git" },
	})

	-- LspAttach autocmd for buffer-local setup
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buf = args.buf

			-- Enable native completion
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
			end

			-- Disable ts_ls formatting (use biome instead)
			if client.name == "ts_ls" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			-- Format on save for LSP formatters
			if client:supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = buf,
					callback = function()
						vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
					end,
				})
			end
		end,
	})

	-- Custom keymaps (in addition to built-in gra, grn, grr, etc.)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

	-- Enable all LSP servers
	vim.lsp.enable({
		"lua_ls",
		"ts_ls",
		"bashls",
		"pyright",
		"gopls",
		"biome",
	})
end

return M
