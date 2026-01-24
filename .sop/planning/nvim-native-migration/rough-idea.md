# Rough Idea: Neovim Native Migration

## Overview

Migrate the current Neovim configuration (`config/vim/`) to use native Neovim features available in the nightly
version, minimizing plugin dependencies while maintaining the same user experience.

## Context

- **Target Neovim Version:** Nightly (via `bob run nightly`)
- **NVIM_APPNAME:** `barebones` (accessed via `bim` alias)
- **Current Config Location:** `config/vim/`
- **Goal:** Use native Neovim features (package manager, LSP, etc.) instead of plugins where possible

## Key Requirements

1. **Minimize plugins** - Prefer native Neovim tools over third-party plugins
2. **Maintain UX** - Keep the same keybindings and workflow (e.g., `<leader>ff` for fuzzy file finding)
3. **Smooth migration** - Plan carefully to avoid breaking the development workflow
4. **Leverage nightly features** - Take advantage of cutting-edge Neovim capabilities

## Current Plugin Categories to Evaluate

Based on `config/vim/lua/plugins/`:

- **AI:** copilot.lua
- **Features:** comment, dap, markdown, mini, noice, silicon, snacks
- **LSP:** completion, lsp-config, none-ls, treesitter, typescript
- **Tools:** telescope, filemanager, gitsigns, obsidian, overseer, smart-splits, toggleterm
- **UI:** catppuccin, colorizer, icons, lualine, prism, rosepine, which-key

## Specific Concerns

- **Telescope replacement** - Need native or lighter alternative that maintains fuzzy finding experience
- **LSP configuration** - Native LSP vs lsp-config plugin
- **Completion** - Native completion vs nvim-cmp
- **Package management** - Native packages vs lazy.nvim
