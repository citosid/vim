-- tests/lsp_spec.lua
-- Tests for native LSP configuration (Step 6)

local T = MiniTest.new_set()

T['lsp'] = MiniTest.new_set()

-- Test that vim.lsp.config exists (it's a callable table)
T['lsp']['vim.lsp.config exists'] = function()
  MiniTest.expect.no_equality(vim.lsp.config, nil)
end

-- Test that vim.lsp.enable exists
T['lsp']['vim.lsp.enable exists'] = function()
  MiniTest.expect.equality(type(vim.lsp.enable), 'function')
end

-- Test that LspAttach autocmd group exists
T['lsp']['LspAttach autocmd group exists'] = function()
  local ok = pcall(vim.api.nvim_get_autocmds, { group = 'UserLspConfig' })
  MiniTest.expect.equality(ok, true)
end

-- Test LSP server configs exist in lsp/ directory
T['lsp']['lsp config files'] = MiniTest.new_set({
  parametrize = {
    { 'lua_ls' },
    { 'ts_ls' },
    { 'bashls' },
    { 'pyright' },
    { 'gopls' },
    { 'biome' },
  },
})

T['lsp']['lsp config files']['exists'] = function(server_name)
  local config_path = vim.fn.stdpath('config') .. '/lsp/' .. server_name .. '.lua'
  local exists = vim.fn.filereadable(config_path) == 1
  MiniTest.expect.equality(exists, true, 'LSP config not found: ' .. config_path)
end

-- Test gd keymap exists (go to definition)
T['lsp']['gd keymap exists'] = function()
  local keymaps = vim.api.nvim_get_keymap('n')
  local found = false
  for _, km in ipairs(keymaps) do
    if km.lhs == 'gd' then
      found = true
      break
    end
  end
  MiniTest.expect.equality(found, true)
end

return T
