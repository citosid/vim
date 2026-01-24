# mini.nvim Modules Research

## Overview

mini.nvim is a library of 40+ independent Lua modules. For this migration, we need:

- **mini.files** - File explorer (replacing neo-tree)
- **mini.icons** - Icon provider (replacing nvim-web-devicons)
- **mini.bufremove** - Buffer deletion (keeping from current config)
- **mini.pairs** - Auto-pairs (keeping from current config)

## mini.files

### Installation & Setup

```lua
require('mini.files').setup({
  -- Customization of shown content
  content = {
    filter = nil,
    prefix = nil,
    sort = nil,
  },

  -- Module mappings
  mappings = {
    close       = 'q',
    go_in       = 'l',
    go_in_plus  = 'L',
    go_out      = 'h',
    go_out_plus = 'H',
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },

  -- General options
  options = {
    permanent_delete = true,
    use_as_default_explorer = true,
  },

  -- Window customization
  windows = {
    max_number = math.huge,
    preview = false,
    width_focus = 50,
    width_nofocus = 15,
    width_preview = 25,
  },
})
```

### User's Custom Configuration

Based on requirements:
- Files not deleted permanently (use trash)
- `<CR>` → go_in_plus (open file and close explorer)
- Swap go_out and go_out_plus
- `,` → reset
- `.` → reveal_cwd
- `s` → synchronize

```lua
require('mini.files').setup({
  options = {
    permanent_delete = false,  -- Use trash instead of permanent delete
    use_as_default_explorer = true,
  },
  
  mappings = {
    close       = 'q',
    go_in       = 'L',           -- Swapped: L just enters
    go_in_plus  = '<CR>',        -- Enter opens and closes
    go_out      = 'H',           -- Swapped: H just goes out
    go_out_plus = 'h',           -- h goes out and closes
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = ',',           -- Custom: comma resets
    reveal_cwd  = '.',           -- Custom: dot reveals cwd
    show_help   = 'g?',
    synchronize = 's',           -- Custom: s synchronizes
    trim_left   = '<',
    trim_right  = '>',
  },
})

-- Keymap to open mini.files
vim.keymap.set('n', '<leader>e', function()
  MiniFiles.open()
end, { desc = 'Toggle Explorer' })
```

### Key Features

- Miller columns navigation (like macOS Finder)
- Edit filesystem by editing buffer text
- Create/delete/rename/copy/move files
- Bookmarks for quick navigation
- Preview support

## mini.icons

### Installation & Setup

```lua
require('mini.icons').setup({
  -- Icon style: 'glyph' or 'ascii'
  style = 'glyph',

  -- Customize per category
  default   = {},
  directory = {},
  extension = {},
  file      = {},
  filetype  = {},
  lsp       = {},
  os        = {},
})
```

### Custom Icons (Matching nvim-web-devicons)

User has custom icons for `toml` and `pem` files:

```lua
require('mini.icons').setup({
  style = 'glyph',
  
  extension = {
    ['toml'] = { glyph = '', hl = 'MiniIconsYellow' },
    ['pem']  = { glyph = '󱕵', hl = 'MiniIconsRed' },
  },
})
```

### Integration with Other Plugins

mini.icons provides a mock function for nvim-web-devicons compatibility:

```lua
-- Make other plugins use mini.icons
require('mini.icons').mock_nvim_web_devicons()
```

### Usage

```lua
-- Get icon for a file
local icon, hl = MiniIcons.get('file', 'init.lua')

-- Get icon for extension
local icon, hl = MiniIcons.get('extension', 'lua')

-- Get icon for filetype
local icon, hl = MiniIcons.get('filetype', 'lua')
```

## mini.bufremove

### Setup (Already in User's Config)

```lua
require('mini.bufremove').setup({})

-- Keymap with confirmation for modified buffers
vim.keymap.set('n', '<leader>bd', function()
  local bd = require('mini.bufremove').delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(
      ('Save changes to %q?'):format(vim.fn.bufname()),
      '&Yes\n&No\n&Cancel'
    )
    if choice == 1 then     -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end, { desc = 'Delete Buffer' })

vim.keymap.set('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, true)
end, { desc = 'Delete Buffer (Force)' })
```

## mini.pairs

### Setup (Already in User's Config)

```lua
require('mini.pairs').setup({
  -- Default configuration works well
})

-- Toggle keymap
vim.keymap.set('n', '<leader>up', function()
  vim.g.minipairs_disable = not vim.g.minipairs_disable
  if vim.g.minipairs_disable then
    vim.notify('Disabled auto pairs')
  else
    vim.notify('Enabled auto pairs')
  end
end, { desc = 'Toggle auto pairs' })
```

## Complete mini.nvim Configuration

```lua
-- lua/plugins/mini.lua

-- mini.files - File explorer
require('mini.files').setup({
  options = {
    permanent_delete = false,
    use_as_default_explorer = true,
  },
  mappings = {
    close       = 'q',
    go_in       = 'L',
    go_in_plus  = '<CR>',
    go_out      = 'H',
    go_out_plus = 'h',
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = ',',
    reveal_cwd  = '.',
    show_help   = 'g?',
    synchronize = 's',
    trim_left   = '<',
    trim_right  = '>',
  },
})

vim.keymap.set('n', '<leader>e', function()
  MiniFiles.open()
end, { desc = 'Toggle Explorer' })

-- mini.icons - Icon provider
require('mini.icons').setup({
  style = 'glyph',
  extension = {
    ['toml'] = { glyph = '', hl = 'MiniIconsYellow' },
    ['pem']  = { glyph = '󱕵', hl = 'MiniIconsRed' },
  },
})

-- Mock nvim-web-devicons for compatibility
MiniIcons.mock_nvim_web_devicons()

-- mini.bufremove - Buffer deletion
require('mini.bufremove').setup({})

vim.keymap.set('n', '<leader>bd', function()
  local bd = require('mini.bufremove').delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(
      ('Save changes to %q?'):format(vim.fn.bufname()),
      '&Yes\n&No\n&Cancel'
    )
    if choice == 1 then
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then
      bd(0, true)
    end
  else
    bd(0)
  end
end, { desc = 'Delete Buffer' })

vim.keymap.set('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, true)
end, { desc = 'Delete Buffer (Force)' })

-- mini.pairs - Auto-pairs
require('mini.pairs').setup({})

vim.keymap.set('n', '<leader>up', function()
  vim.g.minipairs_disable = not vim.g.minipairs_disable
  if vim.g.minipairs_disable then
    vim.notify('Disabled auto pairs')
  else
    vim.notify('Enabled auto pairs')
  end
end, { desc = 'Toggle auto pairs' })
```

## Key Findings

1. **mini.files** - Full neo-tree replacement with custom mappings
2. **mini.icons** - Drop-in replacement for nvim-web-devicons with customization
3. **mini.bufremove** - Already in use, keep as-is
4. **mini.pairs** - Already in use, keep as-is
5. **No dependencies** - Each mini module is standalone
6. **Consistent API** - All modules follow same setup pattern

## References

- https://github.com/echasnovski/mini.nvim
- https://github.com/echasnovski/mini.files
- https://github.com/echasnovski/mini.icons
- `:h mini.files`
- `:h mini.icons`
- `:h mini.bufremove`
- `:h mini.pairs`
