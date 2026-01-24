-- tests/copilot_spec.lua
-- Tests for Copilot configuration (Step 11)

local T = MiniTest.new_set()

T['copilot'] = MiniTest.new_set()

-- Test that copilot.vim is loaded
T['copilot']['is loaded'] = function()
  -- Check if copilot commands exist
  local commands = vim.api.nvim_get_commands({})
  local has_copilot = commands['Copilot'] ~= nil
  MiniTest.expect.equality(has_copilot, true)
end

-- Test that tab mapping is disabled
T['copilot']['tab mapping is disabled'] = function()
  MiniTest.expect.equality(vim.g.copilot_no_tab_map, true)
end

-- Test that C-Y keymap exists in insert mode (accept suggestion)
T['copilot']['C-Y keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-Y>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that C-O keymap exists in insert mode (accept word)
T['copilot']['C-O keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('i')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-O>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that copilot filetypes are configured
T['copilot']['filetypes configured'] = function()
  MiniTest.expect.no_equality(vim.g.copilot_filetypes, nil)
end

return T
