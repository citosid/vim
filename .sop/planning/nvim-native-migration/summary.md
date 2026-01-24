# Neovim Native Migration - Project Summary

## Project Overview

This project migrates the Neovim configuration from a plugin-heavy setup to a native-first approach
using Neovim nightly features. The goal is to minimize plugins while maintaining the same user
experience. The migrated configuration now lives at the root of this project (`config/vim/`).

## Directory Structure

```
.sop/planning/nvim-native-migration/
├── rough-idea.md              # Initial concept
├── idea-honing.md             # Requirements clarification (15 Q&A)
├── research/
│   ├── native-lsp.md          # vim.lsp.config() patterns
│   ├── native-completion.md   # vim.lsp.completion setup
│   ├── fzf-lua.md             # Fuzzy finder configuration
│   ├── native-formatters.md   # Formatter setup
│   ├── native-commenting.md   # Native gc operator
│   └── mini-nvim.md           # mini.nvim modules
├── design/
│   └── detailed-design.md     # Architecture and components
├── implementation/
│   └── plan.md                # 16-step implementation plan
└── summary.md                 # This document

tests/
├── TDD-WORKFLOW.md            # TDD methodology and testing guide
├── init.lua                   # Test runner setup
└── *_spec.lua                 # Unit tests per step
```

## Key Design Decisions

### Plugins Kept (18 total)

| Plugin | Purpose |
|--------|---------|
| nvim-lspconfig | LSP server defaults (merged with local overrides) |
| fzf-lua | Fuzzy finder (replaces Telescope) |
| copilot.vim | AI completion |
| gitsigns.nvim | Git signs and blame |
| nvim-treesitter | Syntax highlighting |
| lualine.nvim | Status line |
| noice.nvim | Enhanced UI |
| mini.files | File explorer |
| mini.icons | Icon provider |
| mini.bufremove | Buffer deletion |
| mini.pairs | Auto-pairs |
| toggleterm.nvim | Terminal toggle |
| smart-splits.nvim | Split navigation |
| render-markdown.nvim | Markdown rendering |
| image.nvim | Image preview |
| vim-latex | LaTeX support |
| nvim-colorizer.lua | Color highlighting |
| jwtools.nvim | Personal plugin |

### LSP Configuration Strategy

Uses nvim-lspconfig for robust defaults, with local `lsp/*.lua` overrides for customization:

| Server | Override | Reason |
|--------|----------|--------|
| lua_ls | `settings` | Neovim runtime/workspace for plugin development |
| ts_ls | `init_options` | Inlay hint preferences |
| bashls | `filetypes` | Add zsh support |
| pyright | `settings` | Use workspace diagnosticMode |
| gopls | `settings` | Enable staticcheck, gofumpt, unusedparams |
| biome | (none) | nvim-lspconfig default is better |

**How it works:**
1. nvim-lspconfig provides `lsp/*.lua` defaults (cmd, filetypes, root_dir, handlers)
2. Local `lsp/*.lua` files override only specific settings needed
3. `vim.lsp.enable()` merges both and starts servers

### Native Replacements

| Was | Now |
|-----|-----|
| nvim-lspconfig + Mason | nvim-lspconfig (defaults) + `vim.lsp.enable()` |
| blink.cmp | Native `vim.lsp.completion` |
| Comment.nvim | Native `gc` operator |
| none-ls.nvim | LSP formatters + autocommands |
| lazy.nvim | Native `vim.pack.add()` |
| Telescope | fzf-lua (lighter) |
| neo-tree | mini.files (lighter) |
| nvim-web-devicons | mini.icons |

### Dropped Plugins

- CopilotChat.nvim
- nvim-dap (all debugging)
- which-key.nvim
- obsidian.nvim
- overseer.nvim
- nvim-silicon
- typescript-tools.nvim
- Theme plugins (catppuccin, rosepine)
- snacks.nvim

## Implementation Plan Summary

The implementation is divided into 16 incremental steps:

1. **Foundation** - Copy colorschemes, verify base config
2. **Plugins** - Set up vim.pack.add() declarations
3. **Icons** - Configure mini.icons
4. **Explorer** - Configure mini.files
5. **Buffers** - Configure mini.bufremove and mini.pairs
6. **LSP** - Native LSP configuration
7. **Completion** - Native completion with custom keymaps
8. **Fuzzy Finder** - fzf-lua setup
9. **Formatters** - LSP + autocommand formatters
10. **Comments** - Native gc with `<leader>/` mapping
11. **Copilot** - AI completion setup
12. **Git** - gitsigns configuration
13. **Terminal** - toggleterm and smart-splits
14. **UI** - lualine, noice, treesitter
15. **Extras** - markdown, colorizer, jwtools
16. **Final** - Keymaps consolidation and testing

## Current Status

✅ **MIGRATION COMPLETE** - All 16 steps implemented and tested.

| Metric | Value |
|--------|-------|
| Steps completed | 16/16 |
| Unit tests | 108 |
| Plugins | 18 (down from 30+) |
| Native features | LSP, completion, commenting, formatting |

## Key Keybindings

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader><space>` | Find buffers |
| `<leader>fw` | Live grep |
| `<leader>e` | File explorer |
| `<leader>/` | Toggle comment |
| `<leader>bd` | Delete buffer |
| `<leader>t` | Toggle terminal |
| `<leader>gg` | Lazygit |
| `<leader>l` | Switch to last buffer |
| `<leader>bn/bp` | Next/previous buffer |
| `<CR>` | Accept LSP completion |
| `<C-Y>` | Accept Copilot suggestion |
| `<C-O>` | Accept Copilot word |

## Additional Features

### Pandoc/LaTeX Highlights

| Key | Action |
|-----|--------|
| `<leader>hy` | Highlight yellow |
| `<leader>hg` | Highlight green |
| `<leader>hb` | Highlight blue |
| `<leader>hr` | Highlight red |
| `<leader>ho` | Highlight orange |
| `<leader>pb` | Build PDF from markdown |
| `<leader>pl` | Build letter PDF |

### Markdown Features

- Obsidian-style callouts (`> [!NOTE]`, `> [!QUOTE]`, etc.)
- Pandoc highlight rendering (`\hlb{}`, `\hlg{}`, etc.)
- Virtual indentation for notes directory
- Spell checking enabled by default

## Next Steps

~~1. Review the detailed design document at `design/detailed-design.md`~~
~~2. Check the implementation plan and checklist at `implementation/plan.md`~~
~~3. Begin implementation following the checklist~~

Migration complete! To use:
```bash
bim <file>  # or just 'bim' to open file picker
```

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-01-24 | Initial design complete |
| 2.0 | 2026-01-24 | Migration complete - all 16 steps implemented |
| 2.1 | 2026-01-24 | Add nvim-lspconfig for better defaults, local overrides only |
