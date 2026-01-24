-- tests/helpers.lua
-- Test utilities for bim configuration tests

local H = {}

-- Mock vim.fn functions
-- Returns a restore function to call after test
function H.mock_fn(name, return_value)
  local original = vim.fn[name]
  vim.fn[name] = function()
    return return_value
  end
  return function()
    vim.fn[name] = original
  end
end

-- Mock vim.g variables
function H.mock_g(name, value)
  local original = vim.g[name]
  vim.g[name] = value
  return function()
    vim.g[name] = original
  end
end

-- Create temporary buffer for testing
function H.create_test_buffer(filetype, lines)
  local buf = vim.api.nvim_create_buf(false, true)
  if filetype then
    vim.api.nvim_buf_set_option(buf, 'filetype', filetype)
  end
  if lines then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
  return buf
end

-- Delete test buffer
function H.delete_test_buffer(buf)
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

-- Wait for condition with timeout
function H.wait_for(condition, timeout_ms)
  timeout_ms = timeout_ms or 5000
  local start = vim.loop.now()
  while vim.loop.now() - start < timeout_ms do
    if condition() then
      return true
    end
    vim.wait(50)
  end
  return false
end

-- Wait for LSP to attach to buffer
function H.wait_for_lsp(bufnr, timeout_ms)
  return H.wait_for(function()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    return #clients > 0
  end, timeout_ms)
end

-- Check if keymap exists
function H.keymap_exists(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, km in ipairs(keymaps) do
    if km.lhs == lhs then
      return true
    end
  end
  return false
end

-- Get keymap details
function H.get_keymap(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, km in ipairs(keymaps) do
    if km.lhs == lhs then
      return km
    end
  end
  return nil
end

-- Check if option is set to expected value
function H.option_equals(name, expected)
  local actual = vim.o[name]
  return actual == expected
end

-- Check if buffer option is set
function H.buf_option_equals(bufnr, name, expected)
  local actual = vim.api.nvim_buf_get_option(bufnr, name)
  return actual == expected
end

-- Simulate keypress
function H.feedkeys(keys, mode)
  mode = mode or 'n'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), mode, false)
end

-- Get current buffer content as string
function H.get_buffer_content(bufnr)
  bufnr = bufnr or 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  return table.concat(lines, '\n')
end

-- Check if module can be required
function H.module_exists(name)
  local ok = pcall(require, name)
  return ok
end

-- Reload module (clear from cache and require again)
function H.reload_module(name)
  package.loaded[name] = nil
  return require(name)
end

-- Create a temporary file
function H.create_temp_file(content, extension)
  extension = extension or 'lua'
  local tmpfile = vim.fn.tempname() .. '.' .. extension
  local f = io.open(tmpfile, 'w')
  if f then
    f:write(content)
    f:close()
  end
  return tmpfile
end

-- Delete temporary file
function H.delete_temp_file(path)
  os.remove(path)
end

return H
