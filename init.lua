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

-- LSP configuration
require("lsp").setup()

-- Completion configuration
require("completion").setup()

-- Formatters configuration
require("formatters").setup()

-- Load colorscheme
vim.cmd.colorscheme("prism")

vim.diagnostic.config({ virtual_text = true })
