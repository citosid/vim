# Native Completion Research

## Overview

Neovim nightly provides `vim.lsp.completion` module for native LSP completion without plugins like nvim-cmp or
blink.cmp.

## Enabling Native Completion

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
```

## Key Options

```lua
vim.lsp.completion.enable(true, client_id, bufnr, {
  autotrigger = true,  -- Trigger completion automatically
  -- Optional: trigger on every keypress (may be slow)
  -- convert = function(item) return item end,
})
```

## Default Keybindings

Native completion uses Neovim's built-in completion menu:

| Key | Action |
|-----|--------|
| `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<C-y>` | Accept selected item |
| `<C-e>` | Cancel completion |
| `<C-x><C-o>` | Trigger omnifunc completion |

## Custom Keybindings for Requirements

To match the user's requirements:
- **Enter** to select highlighted option
- **Arrow keys** to navigate
- **Tab** does NOT navigate or select

```lua
-- Custom completion keymaps
vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-y>'  -- Accept completion
  else
    return '<CR>'   -- Normal enter
  end
end, { expr = true, noremap = true })

vim.keymap.set('i', '<Down>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  else
    return '<Down>'
  end
end, { expr = true, noremap = true })

vim.keymap.set('i', '<Up>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    return '<Up>'
  end
end, { expr = true, noremap = true })

-- Tab does nothing in completion menu (normal tab behavior)
-- No mapping needed - just don't map Tab to completion
```

## Completion Options

Set in `options.lua`:

```lua
vim.opt.completeopt = "menu,menuone,noselect"
-- menu: Use popup menu
-- menuone: Show menu even with one match
-- noselect: Don't auto-select first item
```

## Copilot Integration

Copilot keybindings are separate from LSP completion:

```lua
-- Copilot accepts (from copilot.vim)
vim.keymap.set('i', '<C-Y>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

vim.keymap.set('i', '<C-o>', 'copilot#AcceptWord()', {
  expr = true,
  replace_keycodes = false,
})

vim.g.copilot_no_tab_map = true
```

## Limitations of Native Completion

1. **No snippet expansion** - Native completion doesn't expand snippets (user doesn't need this)
2. **No path completion** - Only LSP sources (can add via omnifunc)
3. **No buffer completion** - Only LSP sources
4. **Simpler UI** - No fancy icons or formatting without additional config

## Alternative: mini.completion

If native completion proves too basic, `mini.completion` is a lightweight alternative:

```lua
require('mini.completion').setup({
  delay = { completion = 100, info = 100, signature = 50 },
  window = {
    info = { height = 25, width = 80, border = 'single' },
    signature = { height = 25, width = 80, border = 'single' },
  },
  lsp_completion = {
    source_func = 'completefunc',
    auto_setup = true,
  },
})
```

## Recommended Approach

1. Start with native `vim.lsp.completion.enable()` 
2. Configure keymaps for Enter/Arrow navigation
3. Test with actual workflow
4. Fall back to mini.completion if needed

## Key Findings

1. **Native completion exists** - `vim.lsp.completion.enable()` in nightly
2. **Keymaps need customization** - Default uses C-n/C-p, need to map Enter/Arrows
3. **No snippets** - User doesn't need them, so this is fine
4. **Copilot separate** - Copilot.vim handles its own keybindings independently
5. **Fallback available** - mini.completion if native proves insufficient

## References

- `:h vim.lsp.completion`
- `:h complete-functions`
- `:h ins-completion`
