-- tests/gitsigns_spec.lua
-- Tests for gitsigns configuration (Step 12)

local T = MiniTest.new_set()

T['gitsigns'] = MiniTest.new_set()

-- Test that gitsigns is loaded
T['gitsigns']['is loaded'] = function()
  local ok = pcall(require, 'gitsigns')
  MiniTest.expect.equality(ok, true)
end

-- Test that gitsigns commands exist
T['gitsigns']['commands exist'] = function()
  local commands = vim.api.nvim_get_commands({})
  MiniTest.expect.no_equality(commands['Gitsigns'], nil)
end

-- Test that leader-gB keymap exists (blame)
T['gitsigns']['leader-gB keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' gB' or km.lhs == '<Space>gB' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that leader-gp keymap exists (preview hunk)
T['gitsigns']['leader-gp keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' gp' or km.lhs == '<Space>gp' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that ]h keymap exists (next hunk)
T['gitsigns'][']h keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ']h' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that [h keymap exists (prev hunk)
T['gitsigns']['[h keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '[h' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
