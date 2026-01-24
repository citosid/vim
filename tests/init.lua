-- tests/init.lua
-- Test runner setup for bim configuration
-- Usage: bim --headless -c "lua require('tests').run_all()"

local M = {}

-- Ensure mini.test is available
local function ensure_mini_test()
  local ok, mini_test = pcall(require, 'mini.test')
  if not ok then
    -- mini.test not loaded yet, try to load mini.nvim
    vim.cmd('packadd mini.nvim')
    ok, mini_test = pcall(require, 'mini.test')
    if not ok then
      error('mini.test not available. Ensure mini.nvim is installed.')
    end
  end
  return mini_test
end

-- Run all test files
function M.run_all()
  local MiniTest = ensure_mini_test()
  
  -- Setup mini.test
  MiniTest.setup({
    collect = {
      emulate_busted = true,
      find_files = function()
        return vim.fn.globpath('tests', '*_spec.lua', false, true)
      end,
    },
    execute = {
      reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }),
    },
  })
  
  -- Run tests
  MiniTest.run()
end

-- Run a specific test file
function M.run_file(filename)
  local MiniTest = ensure_mini_test()
  
  MiniTest.setup({
    collect = {
      emulate_busted = true,
    },
    execute = {
      reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }),
    },
  })
  
  MiniTest.run_file(filename)
end

-- Run tests interactively (with buffer output)
function M.run_interactive()
  local MiniTest = ensure_mini_test()
  
  MiniTest.setup({
    collect = {
      emulate_busted = true,
      find_files = function()
        return vim.fn.globpath('tests', '*_spec.lua', false, true)
      end,
    },
    execute = {
      reporter = MiniTest.gen_reporter.buffer({ group_depth = 2 }),
    },
  })
  
  MiniTest.run()
end

return M
