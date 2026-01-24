-- tests/completion_spec.lua
-- Tests for native completion configuration (Step 7)

local T = MiniTest.new_set()

T['completion'] = MiniTest.new_set()

-- Test that completeopt is set correctly
T['completion']['completeopt is set'] = function()
  local completeopt = vim.opt.completeopt:get()
  local has_menu = vim.tbl_contains(completeopt, 'menu')
  local has_menuone = vim.tbl_contains(completeopt, 'menuone')
  local has_noselect = vim.tbl_contains(completeopt, 'noselect')
  MiniTest.expect.equality(has_menu, true)
  MiniTest.expect.equality(has_menuone, true)
  MiniTest.expect.equality(has_noselect, true)
end

-- Test that CR keymap exists in insert mode
T['completion']['CR keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<CR>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that Down keymap exists in insert mode
T['completion']['Down keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<Down>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that Up keymap exists in insert mode
T['completion']['Up keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<Up>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that vim.lsp.completion exists
T['completion']['vim.lsp.completion exists'] = function()
  MiniTest.expect.no_equality(vim.lsp.completion, nil)
  MiniTest.expect.equality(type(vim.lsp.completion.enable), 'function')
end

-- Test that Tab keymap exists (to override default behavior)
T['completion']['Tab keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<Tab>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
