return {
  "lukas-reineke/lsp-format.nvim",
  config = function()
    require("lsp-format").setup {}
    require("lspconfig").lua_ls.setup { on_attach = require("lsp-format").on_attach }
  end
}
