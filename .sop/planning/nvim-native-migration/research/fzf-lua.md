# fzf-lua Research

## Overview

fzf-lua is a lightweight Telescope alternative that uses the `fzf` binary for fuzzy finding. It's a single plugin
with no required dependencies (unlike Telescope which needs plenary.nvim and telescope-fzf-native.nvim).

## Installation

```lua
-- Using native vim.pack.add()
vim.pack.add({
  { src = "git@github.com:ibhagwan/fzf-lua" }
})

-- Basic setup
require('fzf-lua').setup({})
```

## Keybinding Migration from Telescope

| Telescope Keymap | fzf-lua Equivalent | Command |
|------------------|-------------------|---------|
| `<leader><space>` | `FzfLua buffers` | Find in open buffers |
| `<leader>ff` | `FzfLua files` | Find files |
| `<leader>fw` | `FzfLua live_grep` | Live grep |
| `<leader>fg` | `FzfLua grep` | Grep with pattern |
| `<leader>fd` | `FzfLua diagnostics_document` | Show diagnostics |
| `<leader>fs` | `FzfLua lsp_document_symbols` | Document symbols |
| `<leader>f2` | `FzfLua lsp_implementations` | Find implementations |

## Configuration to Match Telescope Experience

```lua
require('fzf-lua').setup({
  -- Use ivy-like theme (bottom panel)
  winopts = {
    height = 0.40,
    width = 1,
    row = 1,
    col = 0,
    border = 'rounded',
    preview = {
      layout = 'horizontal',
      horizontal = 'right:50%',
    },
  },
  
  -- Keymaps inside fzf window
  keymap = {
    builtin = {
      ['<C-j>'] = 'preview-page-down',
      ['<C-k>'] = 'preview-page-up',
    },
    fzf = {
      ['ctrl-j'] = 'down',
      ['ctrl-k'] = 'up',
      ['ctrl-n'] = 'preview-page-down',
      ['ctrl-p'] = 'preview-page-up',
      ['ctrl-c'] = 'abort',
    },
  },
  
  -- File picker options
  files = {
    prompt = 'Files❯ ',
    git_icons = false,
    file_icons = true,
    color_icons = true,
  },
  
  -- Grep options
  grep = {
    prompt = 'Rg❯ ',
    git_icons = false,
    file_icons = true,
  },
  
  -- Buffer picker
  buffers = {
    prompt = 'Buffers❯ ',
    file_icons = true,
    color_icons = true,
  },
})
```

## Keybinding Setup

```lua
local fzf = require('fzf-lua')

-- File navigation
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find files' })
vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fw', fzf.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fg', fzf.grep, { desc = 'Grep pattern' })

-- LSP integration
vim.keymap.set('n', '<leader>fd', fzf.diagnostics_document, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>fs', fzf.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>f2', fzf.lsp_implementations, { desc = 'Implementations' })

-- Additional useful pickers
vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fr', fzf.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fc', fzf.commands, { desc = 'Commands' })
```

## Multi-grep (Custom Picker)

To replicate Telescope's multigrep functionality:

```lua
-- Custom multi-grep with file type filter
vim.keymap.set('n', '<leader>fg', function()
  require('fzf-lua').live_grep({
    prompt = 'Grep❯ ',
    -- Use rg's glob support
    rg_opts = '--column --line-number --no-heading --color=always --smart-case',
  })
end, { desc = 'Live grep with type filter' })
```

## Available Pickers

### Files
- `files` - Find files
- `git_files` - Git ls-files
- `oldfiles` - Recent files
- `buffers` - Open buffers

### Search
- `grep` - Grep with pattern input
- `live_grep` - Live grep
- `grep_cword` - Grep word under cursor
- `grep_visual` - Grep visual selection
- `live_grep_glob` - Live grep with glob support

### LSP
- `lsp_references` - References
- `lsp_definitions` - Definitions
- `lsp_declarations` - Declarations
- `lsp_implementations` - Implementations
- `lsp_document_symbols` - Document symbols
- `lsp_workspace_symbols` - Workspace symbols
- `diagnostics_document` - Buffer diagnostics
- `diagnostics_workspace` - Workspace diagnostics
- `lsp_code_actions` - Code actions

### Git
- `git_status` - Git status
- `git_commits` - Git commits
- `git_bcommits` - Buffer commits
- `git_branches` - Git branches

### Misc
- `help_tags` - Help tags
- `commands` - Neovim commands
- `keymaps` - Key mappings
- `colorschemes` - Color schemes
- `highlights` - Highlight groups

## Performance

fzf-lua is significantly faster than Telescope because:
1. Uses native `fzf` binary (written in Go)
2. No Lua-based fuzzy matching
3. Minimal dependencies
4. Efficient preview handling

## Integration with mini.icons

fzf-lua auto-detects mini.icons:

```lua
require('fzf-lua').setup({
  -- Will auto-detect mini.icons if available
  -- Or explicitly set:
  -- file_icons = 'mini',
})
```

## Key Findings

1. **Drop-in replacement** - Same keybindings work with different function names
2. **Single plugin** - No dependencies required
3. **Faster** - Uses native fzf binary
4. **Ivy theme** - Can replicate Telescope's ivy layout
5. **LSP integration** - Full LSP picker support
6. **mini.icons support** - Auto-detects or can be configured

## References

- https://github.com/ibhagwan/fzf-lua
- `:h fzf-lua`
