require("flash").setup({
  jump = { nohlsearch = true },
  prompt = {
    win_config = {
      border = "none",
      -- Place the prompt above the statusline.
      row = -3,
    },
  },
  search = {
    exclude = {
      "flash_prompt",
      "qf",
      function(win)
        -- Non-focusable windows.
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
  },
  modes = {
    -- Enable flash when searching with ? or /
    search = { enabled = false },
  },
})

-- Keymaps
vim.keymap.set("o", "r", function()
  require("flash").treesitter_search()
end, { desc = "Flash Treesitter Search" })

vim.keymap.set("o", "R", function()
  require("flash").remote()
end, { desc = "Flash Remote" })
