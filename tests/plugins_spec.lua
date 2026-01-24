-- tests/plugins_spec.lua
-- Tests for plugin declarations (Step 2)

local T = MiniTest.new_set()

T['plugins'] = MiniTest.new_set()

-- Test that vim.pack exists (Neovim nightly feature)
T['plugins']['vim.pack exists'] = function()
  MiniTest.expect.no_equality(vim.pack, nil)
  MiniTest.expect.equality(type(vim.pack.add), 'function')
end

-- Test that required plugins are declared
T['plugins']['required plugins are loadable'] = MiniTest.new_set({
  parametrize = {
    { 'fzf-lua' },
    { 'gitsigns.nvim' },
    { 'nvim-treesitter' },
    { 'lualine.nvim' },
    { 'noice.nvim' },
    { 'nui.nvim' },
    { 'mini.files' },
    { 'mini.icons' },
    { 'mini.bufremove' },
    { 'mini.pairs' },
    { 'toggleterm.nvim' },
    { 'smart-splits.nvim' },
    { 'render-markdown.nvim' },
    { 'nvim-colorizer.lua' },
  },
})

T['plugins']['required plugins are loadable']['plugin'] = function(plugin_name)
  -- Check plugin directory exists in packpath (vim.pack uses core/opt)
  local packpath = vim.fn.stdpath('data') .. '/site/pack/core/opt'
  local plugin_dir = packpath .. '/' .. plugin_name
  
  local exists = vim.fn.isdirectory(plugin_dir) == 1
  MiniTest.expect.equality(exists, true, 'Plugin not found: ' .. plugin_name)
end

-- Test that copilot.vim is declared (separate test - may need auth)
T['plugins']['copilot.vim is declared'] = function()
  local packpath = vim.fn.stdpath('data') .. '/site/pack/core/opt'
  local exists = vim.fn.isdirectory(packpath .. '/copilot.vim') == 1
  MiniTest.expect.equality(exists, true, 'copilot.vim not found')
end

return T
