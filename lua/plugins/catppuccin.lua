return {
  "catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      flavor = "mocha",
      show_end_of_buffer = true,
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    })
    vim.cmd([[colorscheme catppuccin]])
  end,
  name = "catppuccin",
  priority = 1000,
}
