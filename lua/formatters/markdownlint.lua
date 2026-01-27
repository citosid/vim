-- lua/formatters/markdownlint.lua
-- Markdownlint linter for Markdown files (runs after save)

local utils = require("formatters.utils")

local M = {}

local ns = vim.api.nvim_create_namespace("markdownlint")

function M.setup(group)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = { "*.md" },
    callback = function()
      if not utils.cmd_exists("markdownlint-cli2") then
        return
      end
      local bufnr = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(bufnr)

      vim.system({ "markdownlint-cli2", filename }, { text = true }, function(result)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end

          vim.diagnostic.reset(ns, bufnr)

          local output = result.stderr or ""

          if output == "" then
            return
          end

          local diagnostics = {}

          for line in output:gmatch("[^\n]+") do
            -- Format: path:line error CODE/name message
            -- Path can be relative with ../
            local lnum, severity, msg = line:match(":(%d+) (%w+) (.+)")
            if lnum and msg then
              table.insert(diagnostics, {
                lnum = tonumber(lnum) - 1,
                col = 0,
                message = msg,
                severity = severity == "error" and vim.diagnostic.severity.ERROR
                    or vim.diagnostic.severity.WARN,
                source = "markdownlint",
              })
            end
          end

          if #diagnostics > 0 then
            vim.diagnostic.set(ns, bufnr, diagnostics)
          end
        end)
      end)
    end,
  })
end

return M
