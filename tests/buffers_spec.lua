-- tests/buffers_spec.lua
-- Tests for mini.bufremove and mini.pairs configuration (Step 5)

local T = MiniTest.new_set()

T['mini.bufremove'] = MiniTest.new_set()

-- Test that mini.bufremove is loaded
T['mini.bufremove']['is loaded'] = function()
  local ok = pcall(require, 'mini.bufremove')
  MiniTest.expect.equality(ok, true)
end

-- Test that delete function exists
T['mini.bufremove']['has delete function'] = function()
  local bufremove = require('mini.bufremove')
  MiniTest.expect.equality(type(bufremove.delete), 'function')
end

-- Test leader-bd keymap exists
T['mini.bufremove']['leader-bd keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' bd' or km.lhs == '<Space>bd' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test leader-bD keymap exists
T['mini.bufremove']['leader-bD keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' bD' or km.lhs == '<Space>bD' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['mini.pairs'] = MiniTest.new_set()

-- Test that mini.pairs is loaded
T['mini.pairs']['is loaded'] = function()
  MiniTest.expect.no_equality(MiniPairs, nil)
end

-- Test leader-up keymap exists (toggle auto pairs)
T['mini.pairs']['leader-up keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' up' or km.lhs == '<Space>up' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
