-- tests/files_spec.lua
-- Tests for mini.files configuration (Step 4)

local T = MiniTest.new_set()

T['mini.files'] = MiniTest.new_set()

-- Test that mini.files is loaded
T['mini.files']['is loaded'] = function()
  MiniTest.expect.no_equality(MiniFiles, nil)
end

-- Test that MiniFiles.open function exists
T['mini.files']['has open function'] = function()
  MiniTest.expect.equality(type(MiniFiles.open), 'function')
end

-- Test configuration options
T['mini.files']['permanent_delete is false'] = function()
  MiniTest.expect.equality(MiniFiles.config.options.permanent_delete, false)
end

T['mini.files']['use_as_default_explorer is true'] = function()
  MiniTest.expect.equality(MiniFiles.config.options.use_as_default_explorer, true)
end

-- Test custom mappings
T['mini.files']['go_in_plus mapped to CR'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.go_in_plus, '<CR>')
end

T['mini.files']['go_in mapped to L'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.go_in, 'L')
end

T['mini.files']['go_out_plus mapped to h'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.go_out_plus, 'h')
end

T['mini.files']['go_out mapped to H'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.go_out, 'H')
end

T['mini.files']['reset mapped to comma'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.reset, ',')
end

T['mini.files']['reveal_cwd mapped to dot'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.reveal_cwd, '.')
end

T['mini.files']['synchronize mapped to s'] = function()
  MiniTest.expect.equality(MiniFiles.config.mappings.synchronize, 's')
end

-- Test leader-e keymap exists
T['mini.files']['leader-e keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == ' e' or km.lhs == '<Space>e' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
