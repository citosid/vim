return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
    -- config.lsp.hover.enabled = false
    lsp = {
      hover = {
        enabled = false
      },
      signature = {
        enabled = false
      }
    }
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}
