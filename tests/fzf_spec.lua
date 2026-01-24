-- tests/fzf_spec.lua
-- Tests for fzf-lua configuration (Step 8)

local T = MiniTest.new_set()

T['fzf-lua'] = MiniTest.new_set()

-- Test that fzf-lua is loaded
T['fzf-lua']['is loaded'] = function()
  local ok = pcall(require, 'fzf-lua')
  MiniTest.expect.equality(ok, true)
end

-- Test keymaps exist
T['fzf-lua']['leader-ff keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' ff' or km.lhs == '<Space>ff' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['fzf-lua']['leader-space keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    -- leader is space, so leader-space is two spaces
    if km.lhs == '  ' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['fzf-lua']['leader-fw keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' fw' or km.lhs == '<Space>fw' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['fzf-lua']['leader-fd keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' fd' or km.lhs == '<Space>fd' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['fzf-lua']['leader-fs keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' fs' or km.lhs == '<Space>fs' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
