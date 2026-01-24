# Neovim Configuration

Personal Neovim configuration using native Neovim 0.11+ features with minimal plugins.

## Philosophy

This configuration prioritizes:
- **Native features** over plugins where possible
- **Minimal dependencies** - 18 plugins total
- **Fast startup** - uses `vim.pack.add()` instead of lazy.nvim
- **Neovim nightly** features (`vim.lsp.enable()`, `vim.lsp.completion`)

## Requirements

- **Neovim**: 0.12+ (nightly) - requires `vim.pack.add()`
- **Terminal**: Any terminal with true color support
- **Font**: Nerd Font (e.g., FiraCode Nerd Font)

### External Dependencies

```bash
# LSP servers
npm install -g typescript typescript-language-server
npm install -g bash-language-server
npm install -g pyright
npm install -g @biomejs/biome
go install golang.org/x/tools/gopls@latest
brew install lua-language-server  # or build from source

# Tools
brew install fzf ripgrep lazygit
```

## Directory Structure

```
config/vim/
├── init.lua              # Entry point
├── lua/
│   ├── options.lua       # Editor settings
│   ├── keymaps.lua       # Key mappings
│   ├── plugins.lua       # Plugin declarations (vim.pack.add)
│   ├── lsp.lua           # LSP setup and LspAttach autocmd
│   ├── completion.lua    # Native completion keymaps
│   └── ...               # Other modules
├── lsp/                  # LSP server overrides (merged with nvim-lspconfig)
│   ├── lua_ls.lua        # Neovim runtime settings
│   ├── ts_ls.lua         # Inlay hints
│   ├── bashls.lua        # Add zsh support
│   ├── pyright.lua       # Workspace diagnostics
│   └── gopls.lua         # Staticcheck, gofumpt
└── colors/               # Custom colorschemes
    └── prism.lua
```

## Plugins (19 total)

| Plugin | Purpose |
|--------|---------|
| nvim-lspconfig | LSP server defaults |
| fzf-lua | Fuzzy finder |
| copilot.vim | AI completion |
| gitsigns.nvim | Git signs and blame |
| nvim-treesitter | Syntax highlighting |
| lualine.nvim | Status line |
| noice.nvim | Enhanced UI |
| mini.files | File explorer |
| mini.icons | Icon provider |
| mini.bufremove | Buffer deletion |
| mini.pairs | Auto-pairs |
| mini.test | Testing framework |
| toggleterm.nvim | Terminal toggle |
| smart-splits.nvim | Split navigation |
| render-markdown.nvim | Markdown rendering |
| image.nvim | Image preview in markdown |
| nvim-colorizer.lua | Color highlighting |
| jwtools.nvim | Personal utilities |

## LSP Configuration

Uses **nvim-lspconfig** for robust defaults, with local `lsp/*.lua` overrides:

| Server | Override | Reason |
|--------|----------|--------|
| lua_ls | settings | Neovim runtime/workspace |
| ts_ls | init_options | Inlay hints |
| bashls | filetypes | Add zsh |
| pyright | settings | Workspace diagnostics |
| gopls | settings | Staticcheck, gofumpt |
| biome | (none) | Use lspconfig default |

## Keybindings

### Core

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>e` | File explorer |
| `<leader>/` | Toggle comment |
| `<leader>l` | Switch to last buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `jj` | Exit insert mode |

### Finders (fzf-lua)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fg` | Grep with filetype filter |
| `<leader>fd` | Diagnostics |
| `<leader>fs` | Document symbols |
| `<leader><space>` | Find buffers |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grn` | Rename |
| `gra` | Code action |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |

### Completion

| Key | Action |
|-----|--------|
| `<CR>` | Accept LSP completion |
| `<Up>/<Down>` | Navigate completion menu |
| `<C-Y>` | Accept Copilot suggestion |
| `<C-O>` | Accept Copilot word |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Lazygit |
| `<leader>gB` | Git blame |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>t` | Toggle terminal |
| `<C-h/j/k/l>` | Navigate splits (tmux-aware) |

### Spelling

| Key | Action |
|-----|--------|
| `<leader>sa` | Accept first suggestion |
| `<leader>sg` | Add to dictionary |
| `<leader>sd` | Remove from dictionary |
| `<leader>sn` | Next spelling error |
| `<leader>s?` | Show suggestions |

### Pandoc/LaTeX

| Key | Action |
|-----|--------|
| `<leader>pb` | Build PDF from markdown |
| `<leader>pl` | Build letter PDF |
| `<leader>hy/hg/hb/hr/ho` | Highlight (yellow/green/blue/red/orange) |

## Native Features Used

| Feature | Replaces |
|---------|----------|
| `vim.lsp.enable()` | Manual lspconfig setup |
| `vim.lsp.completion` | nvim-cmp, blink.cmp |
| `vim.pack.add()` | lazy.nvim |
| Native `gc` operator | Comment.nvim |
| LSP format-on-save | none-ls.nvim |

## Terminal Configuration

Using Ghostty with a Nerd Font:

```
font-family = "FiraCode Nerd Font Mono"
font-size = 14
background-opacity = 0.65
window-decoration = false
```

## Usage

```bash
# Launch with NVIM_APPNAME
NVIM_APPNAME=barebones nvim

# Or create an alias
alias bim='NVIM_APPNAME=barebones nvim'
bim <file>
```

## Screenshots

![Home](./screenshots/home.png)
![File Explorer](./screenshots/file_explorer.png)
![Markdown](./screenshots/markdown.png)
