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

-- Override MiniFiles highlights after colorscheme loads
local function set_minifiles_highlights()
  local normal_fg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).fg
  local border_fg = vim.api.nvim_get_hl(0, { name = "FloatBorder" }).fg
  vim.api.nvim_set_hl(0, "MiniFilesNormal", { fg = normal_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniFilesBorder", { fg = border_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniFilesTitle", { link = "FloatTitle" })
  vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { link = "FloatTitle" })
end

-- Override Noice highlights for transparency
local function set_noice_highlights()
  local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
  local border_fg = vim.api.nvim_get_hl(0, { name = "FloatBorder" }).fg
  local orange = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = normal_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = border_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = orange, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = normal_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = orange, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoicePopup", { fg = normal_fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = border_fg, bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    set_minifiles_highlights()
    set_noice_highlights()
  end,
  group = vim.api.nvim_create_augroup("MiniFilesHighlights", { clear = true }),
})

-- Apply immediately
set_minifiles_highlights()
set_noice_highlights()
