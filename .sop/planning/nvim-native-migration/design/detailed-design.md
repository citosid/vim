# Neovim Native Migration - Detailed Design

## Overview

This document describes the design for migrating the Neovim configuration to a native-first approach
using Neovim nightly features. The goal is to minimize plugins while maintaining the same user experience.
The migrated configuration now lives at the root of this project (`config/vim/`).

## Detailed Requirements

### Core Requirements

1. **Build incrementally** - Add features one by one
2. **Don't modify `config/vim/`** - Keep current config untouched as fallback
3. **Maintain UX** - Same keybindings and workflow as current setup
4. **Minimize plugins** - Prefer native Neovim features over third-party plugins

### Keybinding Requirements

| Category | Key | Action |
|----------|-----|--------|
| **Files** | `<leader>ff` | Find files (fuzzy) |
| **Files** | `<leader><space>` | Find buffers |
| **Files** | `<leader>e` | Toggle file explorer |
| **Search** | `<leader>fw` | Live grep |
| **Search** | `<leader>fg` | Grep with pattern |
| **LSP** | `<leader>fd` | Diagnostics |
| **LSP** | `<leader>fs` | Document symbols |
| **LSP** | `<leader>f2` | Implementations |
| **Completion** | `<CR>` | Accept LSP completion |
| **Completion** | `<Up>/<Down>` | Navigate completion menu |
| **Completion** | `<Tab>` | Normal tab (no completion) |
| **Copilot** | `<C-Y>` | Accept full suggestion |
| **Copilot** | `<C-O>` | Accept partial (word) |
| **Comments** | `<leader>/` | Toggle comment |
| **Buffers** | `<leader>bd` | Delete buffer |
| **Terminal** | `<leader>t` | Toggle terminal |
| **Terminal** | `<leader>gg` | Open lazygit |
| **Git** | `<leader>gB` | Git blame |

### LSP Server Requirements

| Server | Languages | Install Method |
|--------|-----------|----------------|
| lua_ls | Lua | brew |
| ts_ls | TypeScript/JavaScript | npm |
| bashls | Bash/Shell | npm |
| pyright | Python | npm/pip |
| gopls | Go | go install |
| biome | JS/TS/JSON formatting | npm |

### Formatter Requirements

| Language | Tool | Method |
|----------|------|--------|
| JS/TS/JSON | biome | LSP |
| Go | gopls | LSP (built-in) |
| Lua | stylua | Autocommand |
| Python | black | Autocommand |
| Bash | beautysh | Autocommand |
| Markdown | markdownlint | Autocommand |
| TypeScript | organize imports | Code action on save |

---

## Architecture Overview

```
config/vim/
├── init.lua                 # Entry point
├── lua/
│   ├── options.lua          # Vim options
│   ├── keymaps.lua          # Key mappings
│   ├── plugins.lua          # Plugin declarations
│   ├── utils.lua            # Utility functions
│   ├── lsp.lua              # LSP configuration
│   ├── completion.lua       # Completion setup
│   └── formatters.lua       # Formatter autocommands
├── lsp/                     # LSP server configs
│   ├── lua_ls.lua
│   ├── ts_ls.lua
│   ├── bashls.lua
│   ├── pyright.lua
│   ├── gopls.lua
│   └── biome.lua
└── colors/                  # Colorschemes
    ├── prism.lua
    ├── color-wall.lua
    └── enterprise-desert.lua
```

---

## Components and Interfaces

### 1. Plugin Manager (Native vim.pack)

**Current:** Uses `vim.pack.add()` with nvim-lspconfig only.

**Design:** Expand to include all required plugins.

```lua
-- lua/plugins.lua
vim.pack.add({
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
  { src = "git@github.com:MunifTanjim/nui.nvim" },  -- noice dependency
  
  -- mini.nvim modules
  { src = "git@github.com:echasnovski/mini.files" },
  { src = "git@github.com:echasnovski/mini.icons" },
  { src = "git@github.com:echasnovski/mini.bufremove" },
  { src = "git@github.com:echasnovski/mini.pairs" },
  
  -- Tools
  { src = "git@github.com:akinsho/toggleterm.nvim" },
  { src = "git@github.com:mrjones2014/smart-splits.nvim" },
  
  -- Markdown
  { src = "git@github.com:MeanderingProgrammer/render-markdown.nvim" },
  { src = "git@github.com:3rd/image.nvim" },
  { src = "git@github.com:lervag/vim-latex" },
  
  -- Misc
  { src = "git@github.com:catgoose/nvim-colorizer.lua" },
  { dir = "~/code/personal/jwtools.nvim" },  -- Local plugin
})
```

### 2. LSP Configuration (Native)

**Design:** Use native `vim.lsp.config()` and `vim.lsp.enable()`.

```lua
-- lua/lsp.lua
local M = {}

function M.setup()
  -- Global defaults
  vim.lsp.config('*', {
    root_markers = { '.git' },
  })

  -- Enable all servers (configs in lsp/*.lua)
  vim.lsp.enable({
    'lua_ls',
    'ts_ls', 
    'bashls',
    'pyright',
    'gopls',
    'biome',
  })

  -- LspAttach autocmd for buffer-local setup
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buf = args.buf
      
      -- Enable native completion
      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      end
      
      -- Disable ts_ls formatting (use biome)
      if client.name == 'ts_ls' then
        client.server_capabilities.documentFormattingProvider = false
      end
      
      -- Format on save for LSP formatters
      if client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end,
  })
end

return M
```

### 3. Completion (Native)

**Design:** Use `vim.lsp.completion.enable()` with custom keymaps.

```lua
-- lua/completion.lua
local M = {}

function M.setup()
  -- Completion options
  vim.opt.completeopt = "menu,menuone,noselect"
  
  -- Enter to accept completion
  vim.keymap.set('i', '<CR>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    else
      return '<CR>'
    end
  end, { expr = true, noremap = true })
  
  -- Arrow keys to navigate
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
  
  -- Tab does NOT interact with completion (normal behavior)
end

return M
```

### 4. Formatters (Autocommands)

**Design:** LSP formatters via LspAttach, external formatters via BufWritePre.

```lua
-- lua/formatters.lua
local M = {}

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
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup('Formatters', { clear = true })
  
  -- Lua: stylua
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*.lua',
    callback = function() format_with_cmd('stylua -') end,
  })
  
  -- Python: black
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = '*.py',
    callback = function() format_with_cmd('black --quiet -') end,
  })
  
  -- Bash: beautysh
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = { '*.sh', '*.bash' },
    callback = function() format_with_cmd('beautysh -') end,
  })
  
  -- TypeScript: organize imports on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    pattern = { '*.ts', '*.tsx' },
    callback = function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { 'source.organizeImports' }, diagnostics = {} },
      })
    end,
  })
end

return M
```

### 5. Keymaps

**Design:** Expand existing keymaps.lua with all required bindings.

```lua
-- lua/keymaps.lua (additions)
local map = require("utils").map

-- Fuzzy finder (fzf-lua)
local fzf = require('fzf-lua')
map('n', '<leader>ff', fzf.files, { desc = 'Find files' })
map('n', '<leader><space>', fzf.buffers, { desc = 'Find buffers' })
map('n', '<leader>fw', fzf.live_grep, { desc = 'Live grep' })
map('n', '<leader>fg', fzf.grep, { desc = 'Grep pattern' })
map('n', '<leader>fd', fzf.diagnostics_document, { desc = 'Diagnostics' })
map('n', '<leader>fs', fzf.lsp_document_symbols, { desc = 'Document symbols' })
map('n', '<leader>f2', fzf.lsp_implementations, { desc = 'Implementations' })

-- File explorer (mini.files)
map('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Toggle Explorer' })

-- Comments (native gc)
map('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment' })
map('v', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment' })

-- Buffers (mini.bufremove)
map('n', '<leader>bd', function()
  local bd = require('mini.bufremove').delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 1 then vim.cmd.write(); bd(0)
    elseif choice == 2 then bd(0, true) end
  else bd(0) end
end, { desc = 'Delete Buffer' })
```

---

## Data Models

### LSP Server Configuration Schema

Each `lsp/*.lua` file returns:

```lua
return {
  cmd = { 'server-binary', 'args...' },
  filetypes = { 'filetype1', 'filetype2' },
  root_markers = { 'marker1', 'marker2' },
  settings = { ... },  -- Server-specific settings
}
```

### Plugin Declaration Schema

```lua
{
  src = "git@github.com:user/repo",  -- Remote repository
  -- OR
  dir = "~/path/to/local/plugin",    -- Local directory
}
```

---

## Error Handling

1. **Missing LSP servers** - Check if binary exists before enabling
2. **Missing formatters** - Silently skip if formatter not installed
3. **Plugin load failures** - Log error but continue loading other plugins

---

## Testing Strategy

1. **Incremental testing** - Test each component after adding
2. **Keybinding verification** - Verify each keybinding works as expected
3. **LSP verification** - Use `:checkhealth vim.lsp` after setup
4. **Formatter verification** - Test format-on-save for each language

---

## Appendices

### A. Plugin Count Comparison

| Category | Previous | Current |
|----------|----------|---------|
| Package manager | lazy.nvim | Native vim.pack |
| LSP | nvim-lspconfig + Mason (3) | Native (0) |
| Completion | blink.cmp (1) | Native (0) |
| Fuzzy finder | Telescope + deps (3) | fzf-lua (1) |
| File explorer | neo-tree + deps (2) | mini.files (1) |
| Icons | nvim-web-devicons (1) | mini.icons (1) |
| Formatters | none-ls + deps (3) | Native (0) |
| Comments | Comment.nvim (1) | Native (0) |
| **Total plugins** | ~30+ | **17** |

### B. Native Features Used

| Feature | Neovim Version | Replaces |
|---------|----------------|----------|
| `vim.lsp.config()` | 0.11+ | nvim-lspconfig |
| `vim.lsp.enable()` | 0.11+ | nvim-lspconfig |
| `vim.lsp.completion` | 0.11+ | nvim-cmp, blink.cmp |
| `vim.pack.add()` | 0.11+ | lazy.nvim |
| Native `gc` commenting | 0.10+ | Comment.nvim |
| Built-in LSP keymaps | 0.10+ | Manual setup |

### C. Research Findings Summary

See `research/` directory for detailed findings:
- `native-lsp.md` - LSP configuration patterns
- `native-completion.md` - Completion setup
- `fzf-lua.md` - Fuzzy finder configuration
- `native-formatters.md` - Formatter setup
- `native-commenting.md` - Comment keybindings
- `mini-nvim.md` - mini.nvim module configuration

### D. Alternative Approaches Considered

1. **mini.pick instead of fzf-lua** - Rejected: fzf-lua more feature-complete
2. **Native completion only** - Accepted: Try native first, fallback to mini.completion
3. **oil.nvim instead of mini.files** - Rejected: mini.files matches user preference
4. **Drop all formatters** - Rejected: User needs format-on-save workflow
