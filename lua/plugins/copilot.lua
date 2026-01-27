-- lua/plugins/copilot.lua
-- GitHub Copilot configuration

-- Disable tab mapping (we use C-Y instead)
vim.g.copilot_no_tab_map = true

-- Configure filetypes (enable for most, disable for sensitive files)
vim.g.copilot_filetypes = {
  ["*"] = true,
  ["markdown"] = true,
  ["yaml"] = true,
  ["gitcommit"] = true,
  ["env"] = false,
  ["credentials"] = false,
}

-- Accept full suggestion with C-y
vim.keymap.set("i", "<C-y>", function()
  return vim.fn["copilot#Accept"]("")
end, {
  expr = true,
  replace_keycodes = false,
  desc = "Accept Copilot suggestion",
})

-- Accept word with C-o
vim.keymap.set("i", "<C-o>", "<Plug>(copilot-accept-word)", {
  desc = "Accept Copilot word",
})

-- Navigate suggestions
vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })

-- Dismiss suggestion
vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
