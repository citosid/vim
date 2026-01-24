-- lua/plugins/ui.lua
-- UI configuration: lualine, noice, treesitter

-- lualine setup
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = require("plugins.lualine.prism"),
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(mode)
          local icons = {
            NORMAL = "󰊠",
            INSERT = "󰊄",
            VISUAL = "󰈈",
            ["V-LINE"] = "󰡬",
            ["V-BLOCK"] = "󰴅",
            REPLACE = "󰛔",
            COMMAND = "󰘳",
            TERMINAL = "󰆍",
          }
          return icons[mode] or mode
        end,
      },
    },
    lualine_b = {
      {
        "diff",
        symbols = {
          added = "󰐕 ",
          modified = "󰆓 ",
          removed = "󰍴 ",
        },
      },
      {
        "diagnostics",
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = "󰅚 ",
          warn = "󰀪 ",
          info = "󰋽 ",
          hint = "󰌶 ",
        },
      },
    },
    lualine_c = {
      {
        "filename",
        icon = "󰈙",
        path = 1,
      },
    },
    lualine_x = {
      {
        "filetype",
        icon_only = true,
        colored = true,
      },
    },
    lualine_y = {},
    lualine_z = {
      {
        "location",
        icon = "󰍉",
      },
    },
  },
  extensions = { "toggleterm" },
})

-- noice setup
require("noice").setup({
  lsp = {
    -- Override markdown rendering so that cmp and other plugins use Treesitter
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    hover = { enabled = true },
    signature = { enabled = true },
  },
  presets = {
    bottom_search = true,         -- Use a classic bottom cmdline for search
    command_palette = false,      -- Cmdline in center, not with popupmenu
    long_message_to_split = true, -- Long messages will be sent to a split
    inc_rename = false,           -- Enables an input dialog for inc-rename.nvim
    lsp_doc_border = true,        -- Add a border to hover docs and signature help
  },
  views = {
    -- LSP hover/signature stay near cursor
    hover = {
      position = { row = 2, col = 0 },
      relative = "cursor",
    },
    -- Override mini for top-right notifications
    mini = {
      merge = true,
      position = {
        row = 1,
        col = "100%",
      },
      replace = true,
    },
  },
  routes = {
    -- Route LSP progress to cmdline area (bottom)
    {
      filter = {
        event = "lsp",
        kind = "progress",
      },
      view = "cmdline",
    },
    -- Hide "written" messages
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    -- Hide "L, " messages (line count)
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "L, ",
      },
      opts = { skip = true },
    },
  },
})

-- treesitter setup (newer API uses nvim-treesitter.setup directly)
require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
