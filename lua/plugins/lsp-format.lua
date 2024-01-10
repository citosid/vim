return {
  "lukas-reineke/lsp-format.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local lspconfig = require("lspconfig")

    require("lsp-format").setup {}
    lspconfig.lua_ls.setup { on_attach = require("lsp-format").on_attach }
    lspconfig.pylsp.setup { on_attach = require("lsp-format").on_attach }
  end
}
