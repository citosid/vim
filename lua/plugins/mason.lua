-- lua/plugins/mason.lua
-- Mason setup for LSP server management

local M = {}

function M.setup()
  require("mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "bashls",
      "pyright",
      "gopls",
      "biome",
    },
    automatic_installation = true,
  })
end

return M
