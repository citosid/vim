-- tests/ui_spec.lua
-- Tests for UI configuration (lualine, noice, treesitter) (Step 14)

local T = MiniTest.new_set()

T['lualine'] = MiniTest.new_set()

-- Test that lualine is loaded
T['lualine']['is loaded'] = function()
  local ok = pcall(require, 'lualine')
  MiniTest.expect.equality(ok, true)
end

-- Test that statusline is set
T['lualine']['statusline is set'] = function()
  -- lualine sets laststatus to 2 or 3
  local laststatus = vim.o.laststatus
  MiniTest.expect.equality(laststatus >= 2, true)
end

T['noice'] = MiniTest.new_set()

-- Test that noice is loaded
T['noice']['is loaded'] = function()
  local ok = pcall(require, 'noice')
  MiniTest.expect.equality(ok, true)
end

-- Test that noice commands exist
T['noice']['commands exist'] = function()
  local commands = vim.api.nvim_get_commands({})
  MiniTest.expect.no_equality(commands['Noice'], nil)
end

T['treesitter'] = MiniTest.new_set()

-- Test that treesitter is loaded
T['treesitter']['is loaded'] = function()
  local ok = pcall(require, 'nvim-treesitter')
  MiniTest.expect.equality(ok, true)
end

-- Test that treesitter config module exists
T['treesitter']['config module exists'] = function()
  local ok = pcall(require, 'nvim-treesitter.config')
  MiniTest.expect.equality(ok, true)
end

-- Test that setup function exists
T['treesitter']['setup function exists'] = function()
  local ts = require('nvim-treesitter')
  MiniTest.expect.equality(type(ts.setup), 'function')
end

return T
