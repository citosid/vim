-- tests/final_spec.lua
-- Tests for final keymaps consolidation (Step 16)

local T = MiniTest.new_set()

T['keymaps'] = MiniTest.new_set()

-- Buffer navigation
T['keymaps']['leader-bn exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' bn' or km.lhs == '<Space>bn' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['keymaps']['leader-bp exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' bp' or km.lhs == '<Space>bp' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Hide search
T['keymaps']['leader-ns exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' ns' or km.lhs == '<Space>ns' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Make executable
T['keymaps']['leader-x exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' x' or km.lhs == '<Space>x' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Spelling keymaps
T['keymaps']['leader-sa exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' sa' or km.lhs == '<Space>sa' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['lualine-theme'] = MiniTest.new_set()

-- Test prism theme file exists
T['lualine-theme']['prism theme exists'] = function()
  local config_path = vim.fn.stdpath('config') .. '/lua/plugins/lualine/prism.lua'
  local exists = vim.fn.filereadable(config_path) == 1
  MiniTest.expect.equality(exists, true)
end

return T
