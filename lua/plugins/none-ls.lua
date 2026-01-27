-- lua/plugins/none-ls.lua
-- Formatters and diagnostics via none-ls

local M = {}

function M.setup()
  local nls = require("null-ls")

  nls.setup({
    sources = {
      -- Diagnostics
      nls.builtins.diagnostics.golangci_lint,
      nls.builtins.diagnostics.markdownlint_cli2.with({
        args = { "$FILENAME" },
      }),

      -- Formatters
      nls.builtins.formatting.black,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.gofmt,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.prettier.with({
        filetypes = { "markdown" },
      }),
      nls.builtins.formatting.biome.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "json",
          "jsonc",
          "typescript",
          "typescriptreact",
          "css",
        },
        args = {
          "check",
          "--config-path=/Users/acruz/biome.json",
          "--write",
          "--unsafe",
          "--formatter-enabled=true",
          "--stdin-file-path=$FILENAME",
        },
      }),

      -- From none-ls-extras
      require("none-ls.diagnostics.ruff"),
      require("none-ls.formatting.beautysh"),
    },

    on_attach = function(client, bufnr)
      if client:supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              filter = function(c)
                return c.name == "null-ls"
              end,
              bufnr = bufnr,
            })
          end,
        })
      end
    end,
  })
end

return M
