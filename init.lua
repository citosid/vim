local start_time = vim.uv.hrtime()

require("options")
require("keymaps")
require("autocmds")
require("plugins")

-- Plugin configurations
require("plugins.icons")
require("plugins.files")
require("plugins.buffers")
require("plugins.fzf")
require("plugins.copilot")
require("plugins.gitsigns")
require("plugins.terminal")
require("plugins.ui")
require("plugins.extras")
require("plugins.mason").setup()

-- LSP configuration
require("lsp").setup()

-- Completion configuration
require("completion").setup()

-- Formatters and diagnostics (none-ls)
require("plugins.none-ls").setup()

-- Load colorscheme
require("theme-loader").apply()

vim.diagnostic.config({ virtual_text = true })

-- Report startup time
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local end_time = vim.uv.hrtime()
    local elapsed_ms = (end_time - start_time) / 1e6
    vim.defer_fn(function()
      vim.notify(string.format("Startup: %.2f ms", elapsed_ms), vim.log.levels.INFO)
    end, 100)
  end,
})
