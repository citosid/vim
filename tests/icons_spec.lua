-- tests/icons_spec.lua
-- Tests for mini.icons configuration (Step 3)

local T = MiniTest.new_set()

T['mini.icons'] = MiniTest.new_set()

-- Test that mini.icons is loaded
T['mini.icons']['is loaded'] = function()
  MiniTest.expect.no_equality(MiniIcons, nil)
end

-- Test that MiniIcons.get function exists
T['mini.icons']['has get function'] = function()
  MiniTest.expect.equality(type(MiniIcons.get), 'function')
end

-- Test that MiniIcons.mock_nvim_web_devicons was called
T['mini.icons']['mocks nvim-web-devicons'] = function()
  -- After mock, require('nvim-web-devicons') should work
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  MiniTest.expect.equality(ok, true)
  MiniTest.expect.no_equality(devicons, nil)
end

-- Test custom toml icon has correct highlight
T['mini.icons']['has custom toml icon'] = function()
  local icon, hl = MiniIcons.get('extension', 'toml')
  -- Icon should be non-empty and have yellow highlight
  MiniTest.expect.no_equality(icon, '')
  MiniTest.expect.equality(hl, 'MiniIconsYellow')
end

-- Test custom pem icon has correct highlight
T['mini.icons']['has custom pem icon'] = function()
  local icon, hl = MiniIcons.get('extension', 'pem')
  -- Icon should be non-empty and have red highlight
  MiniTest.expect.no_equality(icon, '')
  MiniTest.expect.equality(hl, 'MiniIconsRed')
end

-- Test standard lua icon works
T['mini.icons']['returns icon for lua files'] = function()
  local icon, hl = MiniIcons.get('extension', 'lua')
  MiniTest.expect.no_equality(icon, nil)
  MiniTest.expect.no_equality(icon, '')
end

return T
