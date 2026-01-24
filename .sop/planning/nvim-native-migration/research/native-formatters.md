# Native Formatters Research

## Overview

Replacing none-ls.nvim with native formatting approaches. The goal is to use LSP servers where possible and
autocommands for tools that don't have LSP support.

## Formatter Categories

### 1. LSP-based Formatters (Preferred)

These tools have LSP servers and can be configured natively:

| Tool | LSP Server | Filetypes |
|------|------------|-----------|
| biome | `biome lsp-proxy` | js, ts, json, css |
| gopls | `gopls` | go (includes gofmt, goimports) |

### 2. Autocommand-based Formatters

These tools don't have LSP servers, use `BufWritePre` autocommands:

| Tool | Command | Filetypes |
|------|---------|-----------|
| stylua | `stylua --stdin-filepath % -` | lua |
| black | `black --quiet -` | python |
| beautysh | `beautysh -` | bash, sh |
| markdownlint | `markdownlint-cli2 --fix` | markdown |

## Implementation Patterns

### Pattern 1: LSP Format on Save

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            timeout_ms = 1000,
          })
        end,
      })
    end
  end,
})
```

### Pattern 2: External Formatter via formatprg

```lua
-- Set formatprg for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.bo.formatprg = 'stylua --stdin-filepath % -'
  end,
})

-- Then use `gq` to format or create BufWritePre autocmd
```

### Pattern 3: External Formatter via Autocommand

```lua
-- Stylua for Lua files
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, '\n')
    
    local result = vim.fn.system('stylua -', content)
    if vim.v.shell_error == 0 then
      local new_lines = vim.split(result, '\n', { trimempty = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    end
  end,
})
```

### Pattern 4: Using vim.fn.system (Simpler)

```lua
local function format_with_cmd(cmd, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, '\n')
  
  local result = vim.fn.system(cmd, content)
  if vim.v.shell_error == 0 then
    local new_lines = vim.split(result, '\n')
    -- Remove trailing empty line if present
    if new_lines[#new_lines] == '' then
      table.remove(new_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  end
end

-- Usage
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    format_with_cmd('stylua -')
  end,
})
```

## Complete Formatter Configuration

```lua
-- formatters.lua

local M = {}

-- Helper function
local function format_with_cmd(cmd)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, '\n')
  
  local result = vim.fn.system(cmd, content)
  if vim.v.shell_error == 0 then
    local new_lines = vim.split(result, '\n')
    if new_lines[#new_lines] == '' then
      table.remove(new_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  else
    vim.notify('Format failed: ' .. result, vim.log.levels.ERROR)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup('Formatters', { clear = true })
  
  -- Lua: stylua
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*.lua',
    callback = function()
      format_with_cmd('stylua -')
    end,
  })
  
  -- Python: black
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*.py',
    callback = function()
      format_with_cmd('black --quiet -')
    end,
  })
  
  -- Bash: beautysh
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = { '*.sh', '*.bash' },
    callback = function()
      format_with_cmd('beautysh -')
    end,
  })
  
  -- Markdown: markdownlint (file-based, not stdin)
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = '*.md',
    callback = function()
      local file = vim.fn.expand('%:p')
      vim.fn.system('markdownlint-cli2 --fix ' .. vim.fn.shellescape(file))
      vim.cmd('edit')  -- Reload file
    end,
  })
end

return M
```

## Biome LSP Configuration

Biome has its own LSP server, configure it natively:

```lua
vim.lsp.config('biome', {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'typescript',
    'typescriptreact',
    'css',
  },
  root_markers = { 'biome.json', 'biome.jsonc' },
  -- Use custom biome.json path
  -- settings = {
  --   biome = {
  --     configPath = '/Users/acruz/biome.json',
  --   },
  -- },
})

vim.lsp.enable('biome')
```

## TypeScript Organize Imports on Save

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ts', '*.tsx' },
  callback = function()
    -- Organize imports via code action
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { 'source.organizeImports' },
        diagnostics = {},
      },
    })
  end,
})
```

## Formatter Priority

When multiple formatters could apply, use this priority:

1. **LSP formatter** (biome for JS/TS, gopls for Go)
2. **External formatter** (stylua for Lua, black for Python)

To disable LSP formatting for specific servers:

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Disable ts_ls formatting (use biome instead)
    if client.name == 'ts_ls' then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})
```

## Key Findings

1. **Biome has LSP** - Use `biome lsp-proxy` as native LSP server
2. **gopls handles Go** - gofmt and goimports built into gopls
3. **Autocommands for others** - stylua, black, beautysh need autocommands
4. **stdin vs file** - Most formatters support stdin, markdownlint needs file
5. **Organize imports** - Use code action on save for TypeScript

## Required Tools Installation

```bash
# LSP servers with formatting
npm i -g @biomejs/biome
go install golang.org/x/tools/gopls@latest

# External formatters
brew install stylua
pip install black
pip install beautysh
npm i -g markdownlint-cli2
```

## References

- `:h vim.lsp.buf.format()`
- `:h formatprg`
- https://biomejs.dev/guides/getting-started/
