-- lua/plugins.lua
-- Plugin declarations using native vim.pack.add()

vim.pack.add({
  -- LSP (provides lsp/*.lua defaults, merged with our overrides)
  { src = "git@github.com:neovim/nvim-lspconfig" },
  { src = "git@github.com:williamboman/mason.nvim" },
  { src = "git@github.com:williamboman/mason-lspconfig.nvim" },

  -- Completion
  { src = "https://github.com/Saghen/blink.cmp" },

  -- Fuzzy finder
  { src = "git@github.com:ibhagwan/fzf-lua" },

  -- AI
  { src = "git@github.com:github/copilot.vim" },

  -- Git
  { src = "git@github.com:lewis6991/gitsigns.nvim" },

  -- Treesitter
  { src = "git@github.com:nvim-treesitter/nvim-treesitter" },

  -- UI
  { src = "git@github.com:nvim-lualine/lualine.nvim" },
  { src = "git@github.com:folke/noice.nvim" },
  { src = "git@github.com:MunifTanjim/nui.nvim" }, -- noice dependency

  -- mini.nvim modules
  { src = "git@github.com:echasnovski/mini.files" },
  { src = "git@github.com:echasnovski/mini.icons" },
  { src = "git@github.com:echasnovski/mini.bufremove" },
  { src = "git@github.com:echasnovski/mini.pairs" },
  { src = "git@github.com:echasnovski/mini.test" }, -- for testing

  -- Tools
  { src = "git@github.com:akinsho/toggleterm.nvim" },
  { src = "git@github.com:mrjones2014/smart-splits.nvim" },

  -- Markdown
  { src = "git@github.com:MeanderingProgrammer/render-markdown.nvim" },
  { src = "git@github.com:3rd/image.nvim" },

  -- Misc
  { src = "git@github.com:catgoose/nvim-colorizer.lua" },

  -- None-ls (formatters and diagnostics)
  { src = "git@github.com:nvimtools/none-ls.nvim" },
  { src = "git@github.com:nvimtools/none-ls-extras.nvim" },
  { src = "git@github.com:nvim-lua/plenary.nvim" }, -- none-ls dependency

  -- Personal
  { src = vim.fn.expand("~/code/personal/jwtools.nvim") },
})

local function update()
  vim.pack.update()
end

local function remove_package(name)
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/*/start/" .. name
  vim.fn.system("rm -rf " .. vim.fn.shellescape(pack_path))
  vim.notify("Removed " .. name, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>pd", function()
  vim.ui.input({ prompt = "Package to remove: " }, function(name)
    if name then remove_package(name) end
  end)
end, { noremap = true })

vim.keymap.set("n", "<leader>pu", update, { noremap = true, silent = true })
