-- lua/plugins/files.lua
-- mini.files configuration (file explorer)

require("mini.files").setup({
  options = {
    permanent_delete = false, -- Use trash instead of permanent delete
    use_as_default_explorer = true,
  },

  mappings = {
    close = "q",
    go_in = "l",       -- Swapped: L just enters directory
    go_in_plus = "<CR>", -- Enter opens file and closes explorer
    go_out = "H",      -- Swapped: H just goes to parent
    go_out_plus = "h", -- h goes to parent and closes
    mark_goto = "'",
    mark_set = "m",
    reset = ",",     -- Custom: comma resets
    reveal_cwd = ".", -- Custom: dot reveals cwd
    show_help = "g?",
    synchronize = "s", -- Custom: s synchronizes
    trim_left = "<",
    trim_right = ">",
  },
})

-- Keymap to open mini.files
vim.keymap.set("n", "<leader>e", function()
  MiniFiles.open()
end, { desc = "Toggle Explorer" })
