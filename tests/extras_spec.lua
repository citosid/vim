-- tests/extras_spec.lua
-- Tests for remaining plugins (Step 15): markdown, colorizer, jwtools

local T = MiniTest.new_set()

T['render-markdown'] = MiniTest.new_set()

-- Test that render-markdown is loaded
T['render-markdown']['is loaded'] = function()
  local ok = pcall(require, 'render-markdown')
  MiniTest.expect.equality(ok, true)
end

T['colorizer'] = MiniTest.new_set()

-- Test that colorizer is loaded
T['colorizer']['is loaded'] = function()
  local ok = pcall(require, 'colorizer')
  MiniTest.expect.equality(ok, true)
end

-- Test that ColorizerToggle command exists
T['colorizer']['command exists'] = function()
  local commands = vim.api.nvim_get_commands({})
  MiniTest.expect.no_equality(commands['ColorizerToggle'], nil)
end

return T
