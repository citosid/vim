-- tests/comments_spec.lua
-- Tests for native commenting configuration (Step 10)

local T = MiniTest.new_set()

T['comments'] = MiniTest.new_set()

-- Test that leader-/ keymap exists in normal mode
T['comments']['leader-/ keymap exists in normal mode'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' /' or km.lhs == '<Space>/' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that leader-/ keymap exists in visual mode
T['comments']['leader-/ keymap exists in visual mode'] = function()
  local keymaps = vim.api.nvim_get_keymap('v')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' /' or km.lhs == '<Space>/' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that native gc operator exists
T['comments']['native gc operator exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == 'gc' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that native gcc operator exists
T['comments']['native gcc operator exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == 'gcc' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
