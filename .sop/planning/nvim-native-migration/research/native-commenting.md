# Native Commenting Research

## Overview

Neovim 0.10+ includes built-in commenting via the `gc` operator, powered by treesitter. This replaces plugins like
Comment.nvim.

## Built-in Commenting

### Default Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `gc{motion}` | Normal | Comment/uncomment lines covered by motion |
| `gcc` | Normal | Comment/uncomment current line |
| `gc` | Visual | Comment/uncomment selection |
| `gcgc` / `gcu` | Normal | Uncomment adjacent commented lines |

### How It Works

1. Uses `commentstring` option to determine comment format
2. Treesitter provides context-aware commenting (e.g., JSX vs JS in same file)
3. Works out of the box with no configuration

## Mapping `<leader>/` to Native Commenting

The user wants `<leader>/` to toggle comments (same as their current Comment.nvim setup).

### Option 1: Map to gcc/gc

```lua
-- Normal mode: toggle current line
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment' })

-- Visual mode: toggle selection
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment' })
```

### Option 2: Using Operatorfunc (More Control)

```lua
-- For line-wise commenting
vim.keymap.set('n', '<leader>/', function()
  return vim.v.count == 0 and 'gcc' or vim.v.count .. 'gcc'
end, { expr = true, desc = 'Toggle comment line' })

vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Toggle comment selection' })
```

### Option 3: Direct API (Neovim 0.10+)

```lua
-- Using the internal commenting API
vim.keymap.set('n', '<leader>/', function()
  vim.cmd('normal gcc')
end, { desc = 'Toggle comment' })

vim.keymap.set('v', '<leader>/', function()
  vim.cmd('normal gc')
end, { desc = 'Toggle comment' })
```

## Ensuring Commentstring is Set

For languages not automatically detected, set `commentstring`:

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact' },
  callback = function()
    vim.bo.commentstring = '// %s'
  end,
})
```

However, with treesitter, this is usually automatic.

## Treesitter Context-Aware Commenting

Treesitter enables context-aware commenting. For example, in a TSX file:

```tsx
// JavaScript comment
<div>
  {/* JSX comment */}
</div>
```

The native `gc` operator will use the correct comment style based on cursor position.

## Complete Configuration

```lua
-- lua/keymaps.lua

-- Native commenting with <leader>/
-- Normal mode: toggle current line
vim.keymap.set('n', '<leader>/', 'gcc', { 
  remap = true, 
  desc = 'Toggle comment line' 
})

-- Visual mode: toggle selection  
vim.keymap.set('v', '<leader>/', 'gc', { 
  remap = true, 
  desc = 'Toggle comment selection' 
})

-- Optional: Also support count prefix (e.g., 3<leader>/ comments 3 lines)
-- This is already handled by the gcc mapping
```

## Comparison with Comment.nvim

| Feature | Native gc | Comment.nvim |
|---------|-----------|--------------|
| Basic toggle | ✅ | ✅ |
| Motion support | ✅ | ✅ |
| Visual mode | ✅ | ✅ |
| Treesitter context | ✅ | ✅ |
| Block comments | ✅ (gb) | ✅ |
| Custom mappings | Manual | Built-in |
| Extra features | ❌ | ✅ (hooks, etc.) |

## Block Comments

Native Neovim also supports block comments with `gb`:

| Key | Action |
|-----|--------|
| `gb{motion}` | Block comment |
| `gbc` | Block comment current line |

## Key Findings

1. **Native gc works** - Neovim 0.10+ has built-in commenting
2. **Simple mapping** - Just remap `<leader>/` to `gcc`/`gc`
3. **Treesitter aware** - Context-aware commenting works automatically
4. **No plugin needed** - Comment.nvim can be dropped entirely
5. **Block comments** - Also available via `gb` operator

## References

- `:h commenting`
- `:h gc`
- `:h commentstring`
