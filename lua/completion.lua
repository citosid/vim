-- lua/completion.lua
-- Native LSP completion configuration

local M = {}

function M.setup()
  require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        auto_close = true,
      },
      menu = {
        auto_show = true,
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
      },
    },
    signature = {
      enabled = true,
    },
  })
end

return M
