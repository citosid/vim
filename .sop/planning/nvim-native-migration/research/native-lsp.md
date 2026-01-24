# Native LSP Configuration Research

## Overview

Neovim nightly (0.11+) provides native LSP configuration without requiring `nvim-lspconfig` plugin. The key APIs are:

- `vim.lsp.config()` - Define LSP server configurations
- `vim.lsp.enable()` - Enable LSP servers for auto-activation
- `vim.lsp.start()` - Manually start LSP client

## Configuration Methods

### Method 1: Inline Configuration (vim.lsp.config)

```lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) }
    }
  }
})

vim.lsp.enable('lua_ls')
```

### Method 2: File-based Configuration (lsp/*.lua)

Create `lsp/<config-name>.lua` in runtimepath:

```lua
-- ~/.config/barebones/lsp/lua_ls.lua
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = { ... }
}
```

Then enable: `vim.lsp.enable('lua_ls')`

### Method 3: Global Defaults

```lua
vim.lsp.config('*', {
  capabilities = { ... },
  root_markers = { '.git' },
})
```

## Config Merge Order (Increasing Priority)

1. `vim.lsp.config('*', {...})` - Global defaults
2. `lsp/<config>.lua` files in runtimepath
3. `after/lsp/<config>.lua` files (override plugins)
4. Inline `vim.lsp.config('<name>', {...})` calls

## Key Configuration Options

| Option | Description |
|--------|-------------|
| `cmd` | Command to start the server |
| `filetypes` | File types to attach to |
| `root_markers` | Files/dirs to detect workspace root |
| `root_dir` | Function or string for workspace root |
| `settings` | Server-specific settings |
| `capabilities` | LSP capabilities |
| `handlers` | Custom response handlers |

## Default Keymaps (Built-in)

Neovim provides these global keymaps automatically:

| Key | Action |
|-----|--------|
| `gra` | Code action |
| `gri` | Go to implementation |
| `grn` | Rename |
| `grr` | References |
| `grt` | Type definition |
| `gO` | Document symbols |
| `K` | Hover |
| `CTRL-S` (insert) | Signature help |

## Buffer-local Defaults (Auto-set on Attach)

- `omnifunc` → `vim.lsp.omnifunc()`
- `tagfunc` → `vim.lsp.tagfunc()`
- `formatexpr` → `vim.lsp.formatexpr()`

## LspAttach Autocmd Pattern

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Enable completion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    
    -- Auto-format on save
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})
```

## Required LSP Servers for Migration

| Server | Language | Install Command |
|--------|----------|-----------------|
| `lua_ls` | Lua | `brew install lua-language-server` |
| `ts_ls` | TypeScript | `npm i -g typescript-language-server typescript` |
| `bashls` | Bash | `npm i -g bash-language-server` |
| `pyright` | Python | `npm i -g pyright` or `pip install pyright` |
| `gopls` | Go | `go install golang.org/x/tools/gopls@latest` |
| `biome` | JS/TS/JSON | `npm i -g @biomejs/biome` |

## Example: Complete LSP Setup

```lua
-- Global defaults
vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- Individual servers
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'package.json' },
})

vim.lsp.config('biome', {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = { 'javascript', 'typescript', 'json', 'jsonc' },
  root_markers = { 'biome.json', 'biome.jsonc' },
})

-- Enable all
vim.lsp.enable({ 'lua_ls', 'ts_ls', 'bashls', 'pyright', 'gopls', 'biome' })
```

## Key Findings

1. **No nvim-lspconfig needed** - Native `vim.lsp.config()` + `vim.lsp.enable()` replaces it
2. **File-based configs** - Can use `lsp/*.lua` files for cleaner organization
3. **Built-in keymaps** - Many LSP keymaps are now default (gra, grn, grr, etc.)
4. **Completion integration** - Use `vim.lsp.completion.enable()` for native completion
5. **Format on save** - Implement via LspAttach autocmd

## References

- https://neovim.io/doc/user/lsp.html
- `:h vim.lsp.config()`
- `:h vim.lsp.enable()`
- `:h LspAttach`
