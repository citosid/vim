return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup {}
  end
}
