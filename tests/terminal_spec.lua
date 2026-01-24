-- tests/terminal_spec.lua
-- Tests for toggleterm and smart-splits configuration (Step 13)

local T = MiniTest.new_set()

T['toggleterm'] = MiniTest.new_set()

-- Test that toggleterm is loaded
T['toggleterm']['is loaded'] = function()
  local ok = pcall(require, 'toggleterm')
  MiniTest.expect.equality(ok, true)
end

-- Test that leader-t keymap exists (toggle terminal)
T['toggleterm']['leader-t keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' t' or km.lhs == '<Space>t' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that leader-gg keymap exists (lazygit)
T['toggleterm']['leader-gg keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' gg' or km.lhs == '<Space>gg' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

T['smart-splits'] = MiniTest.new_set()

-- Test that smart-splits is loaded
T['smart-splits']['is loaded'] = function()
  local ok = pcall(require, 'smart-splits')
  MiniTest.expect.equality(ok, true)
end

-- Test that C-h keymap exists (move left)
T['smart-splits']['C-h keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-H>' or km.lhs == '<C-h>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that C-j keymap exists (move down)
T['smart-splits']['C-j keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-J>' or km.lhs == '<C-j>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that C-k keymap exists (move up)
T['smart-splits']['C-k keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-K>' or km.lhs == '<C-k>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

-- Test that C-l keymap exists (move right)
T['smart-splits']['C-l keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == '<C-L>' or km.lhs == '<C-l>' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
