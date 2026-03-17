# Plan: Revert to Lazy.nvim Configuration

## Context

Commit `12d8f4a8` removed the entire Lazy.nvim setup in preparation for a
"barebones/native" migration. Since then, improvements were made on top of the
native config. The goal is to restore the Lazy.nvim setup while cherry-picking
those improvements.

---

## What the Lazy Config Looked Like (pre-`12d8f4a8`)

- `init.lua` — bootstraps Lazy.nvim, sets leader, loads `plugins/`, then
  `keymaps` + `autocmds`
- `lua/plugins/` — categorized plugin specs (ai, ui, lsp, tools, features)
- `lazy-lock.json` — pinned plugin revisions
- `lua/theme-loader.lua` — reads `~/.local/state/dotfiles/theme` and applies it

Plugin inventory (from parent of `12d8f4a8`):

| Category | Plugins |
|---|---|
| AI | copilot.vim, CopilotChat |
| UI | catppuccin, lualine, which-key, noice, snacks (notifier/zen/input/terminal) |
| LSP | mason, mason-lspconfig, nvim-lspconfig, blink.cmp, none-ls, mason-null-ls, none-ls-extras |
| Tools | telescope + fzf-native, neo-tree, gitsigns, toggleterm, smart-splits, obsidian |
| Features | render-markdown, image.nvim, mini.bufremove, mini.pairs, nvim-dap + dap-ui, nvim-treesitter |

---

## Improvements Made in the Native Config (to preserve)

These were added after `12d8f4a8` and must be carried forward:

### `lua/keymaps.lua`
- `<leader>of` — reveal file in Finder (`!open -R %`)
- `<leader>l` — switch to last buffer (`b#`)
- `<leader>pb` / `<leader>pl` — pandoc PDF build now uses `lualatex` (was
  `xelatex` in lazy era)
- `<leader>tw` — typewriter mode toggle (inline, not a plugin)
- Native commenting via `gcc`/`gc` remapped to `<leader>/` (replaces
  `comment.lua` plugin)
- `<Esc>` in insert mode added alongside `jj`
- `<leader>sd` / `<leader>sg` spelling keymaps added

### `lua/autocmds.lua`
- `ColorScheme` autocmd to re-apply highlight colors on theme switch
- Markdown `FileType` autocmd now also enables folding
  (`foldmethod=expr`) and calls `vim.treesitter.start()`
- `conceallevel`/`concealcursor` set in the markdown autocmd
- `notes_dirs` is now a list (two paths) instead of a single string
- Startup autocmd uses `fzf-lua` instead of telescope

### `lua/options.lua`
- `vim.g.autoformat = true` and `vim.g.root_spec` added
- `formatoptions`, `grepformat`, `grepprg`, `inccommand`, `sessionoptions`,
  `shiftround`, `shortmess`, `showcmd`, `showcmdloc`, `sidescrolloff`,
  `splitkeep`, `undolevels`, `virtualedit`, `wildmode`, `winminwidth` — all
  new or changed vs lazy-era options
- `vim.diagnostic.config({ virtual_text = true })` (was in `init.lua` in
  native config)

### `lua/theme-loader.lua`
- New themes added to `theme_map`: `aurora`, `crystals`, `headphones`,
  `tron-ares`, `ai-flower`, `ai-machine`, `aimachine`, `fantasy-autumn`,
  `color-wall`, `enterprise-desert`

### `colors/` directory
- New colorscheme files: `aurora.lua`, `crystals.lua`, `headphones.lua`,
  `tron-ares.lua`, `ai-flower.lua`, `ai-machine.lua`, `aimachine.lua`,
  `fantasy-autumn.lua`, `color-wall.lua` (enterprise-desert and prism existed
  before)

### `lua/plugins/ui/lualine/` themes
- New lualine themes for each new colorscheme (one file per theme)

### `lua/plugins/lsp/lsp-config.lua`
- `gopls` added to enabled servers
- LSP keymaps reorganized under `<leader>l*` prefix

### `lua/plugins/lsp/none-ls.lua`
- `gofmt`, `goimports`, `golangci_lint` added
- `biome` args updated: `--format-with-errors=true` flag, config path
  `--config-path=/Users/acruz/biome.json`
- `markdownlint-cli2` formatter uses `--fix` flag

### `lua/plugins/features/markdown.lua`
- `image.nvim` rendering disabled by default
  (`editor_only_render_when_focused = true`, `only_render_image_at_cursor = true`)

### `lua/plugins/tools/toggleterm.lua`
- Close mapping changed from `<C-j><C-j>` to `<C-l><C-l>`

### `spell/`
- `en.utf-8.add` — words `hlpn` and `hlq` added

### `.stylua.toml`
- Added (new file, didn't exist in lazy era)

### `tests/`
- Entire test suite added (native-era only, not needed in lazy config but
  harmless to keep)

---

## Migration Steps

### Step 1 — Restore `init.lua`

Replace current `init.lua` with the Lazy bootstrap version, adding
`vim.diagnostic.config` at the end:

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("options")
require("lazy").setup({ spec = { import = "plugins" }, change_detection = { notify = false } })
require("keymaps")
require("autocmds")
require("theme-loader").apply()
vim.diagnostic.config({ virtual_text = true })
```

### Step 2 — Restore `lua/plugins/` category structure

Recreate the full category tree from the parent of `12d8f4a8`:

```
lua/plugins/
  ai/       init.lua  copilot.lua
  ui/       init.lua  catppuccin.lua  lualine.lua  lualine/  which-key.lua
            noice.lua  icons.lua  typewritter.lua  rosepine.lua
  lsp/      init.lua  lsp-config.lua  completion.lua  treesitter.lua
            none-ls.lua  typescript.lua
  tools/    init.lua  telescope.lua  telescope/multigrep.lua  filemanager.lua
            gitsigns.lua  toggleterm.lua  smart-splits.lua  obsidian.lua
            overseer.lua  pencil.lua  latex.lua  jwtools.lua
  features/ init.lua  comment.lua  dap.lua  markdown.lua  mini.lua
            noice.lua  silicon.lua  snacks.lua  spell.lua
```

Apply improvements noted above to each file as it is restored.

### Step 3 — Update `lua/keymaps.lua`

Use the lazy-era file as the base, then apply all improvements:
- Add `<leader>of`, `<leader>l`, `<leader>tw`
- Change pandoc engine to `lualatex`
- Add native comment remaps (`gcc`/`gc` → `<leader>/`)
- Add `<Esc>` insert-mode map
- Add `<leader>sd` / `<leader>sg`
- Remove plugin-based comment keymap (now native)

### Step 4 — Update `lua/autocmds.lua`

Use the lazy-era file as the base, then apply improvements:
- Add `ColorScheme` autocmd for highlight re-application
- Update markdown `FileType` autocmd (folding, treesitter, conceallevel)
- Expand `notes_dir` to `notes_dirs` list with two paths
- Change startup autocmd from `telescope.builtin.find_files` to `fzf-lua.files`
- Remove NeoTree highlight hack (top of file) — it belongs in the plugin config

### Step 5 — Update `lua/options.lua`

Merge the native-era options into the lazy-era base. The native config is a
strict superset — use it as-is, just remove `vim.g.mapleader` (set in
`init.lua`) and the `vim.diagnostic.config` call (moved to `init.lua`).

### Step 6 — Update `lua/theme-loader.lua`

Add all new theme entries to `theme_map`:
`aurora`, `crystals`, `headphones`, `tron-ares`, `ai-flower`, `ai-machine`,
`aimachine`, `fantasy-autumn`, `color-wall`

### Step 7 — Restore `colors/` files

Keep all colorscheme files from HEAD. They are additive and work with both
plugin managers.

### Step 8 — Restore `lua/plugins/ui/lualine/` themes

Keep all lualine theme files from HEAD. The lazy-era `lualine.lua` references
`require("plugins.ui.lualine.prism")` — ensure the default theme still points
to `prism` (or whichever is active via theme-loader).

### Step 9 — Update `lua/plugins/lsp/none-ls.lua`

Apply the biome args fix (`--format-with-errors=true`), gofmt/goimports/golangci,
and markdownlint `--fix` flag.

### Step 10 — Update `lua/plugins/tools/toggleterm.lua`

Change terminal close mapping from `<C-j><C-j>` to `<C-l><C-l>`.

### Step 11 — Clean up native-only files

The following files exist only in the native config and should be removed or
left as dead code (they won't be loaded by Lazy):

- `lsp/` top-level directory (native LSP configs — replaced by mason/lspconfig)
- `lua/completion.lua` (native completion — replaced by blink.cmp)
- `lua/lsp.lua` (native LSP setup — replaced by lsp-config.lua plugin)
- `lua/plugins.lua` (native pack loader — replaced by Lazy)
- `lua/plugins/buffers.lua`, `copilot.lua`, `extras.lua`, `files.lua`,
  `fzf.lua`, `gitsigns.lua`, `icons.lua`, `mason.lua`, `none-ls.lua`,
  `terminal.lua`, `ui.lua` (flat native plugin files — replaced by category
  structure)
- `nvim-pack-lock.json` (native lockfile — replaced by `lazy-lock.json`)

> These can be deleted once the Lazy config is verified working.

### Step 12 — Restore `lazy-lock.json`

Use the version from the parent of `12d8f4a8` as a starting point, then run
`:Lazy sync` to update to current plugin versions.

### Step 13 — Verify

```
:checkhealth
:Lazy status
:LspInfo
```

Confirm: LSP attaches, completions work, theme loads, fzf opens on startup.

---

## Files to Restore from `12d8f4a8^` (git source of truth)

```bash
git show 12d8f4a8b5eaefddbedf1730705fe08cc075473c^:lua/plugins/ai/copilot.lua
git show 12d8f4a8b5eaefddbedf1730705fe08cc075473c^:lua/plugins/ui/catppuccin.lua
git show 12d8f4a8b5eaefddbedf1730705fe08cc075473c^:lua/plugins/ui/which-key.lua
# ... etc for each plugin file
```

Or restore the entire tree at once and then apply improvements on top:

```bash
git checkout 12d8f4a8b5eaefddbedf1730705fe08cc075473c^ -- lua/plugins/
git checkout 12d8f4a8b5eaefddbedf1730705fe08cc075473c^ -- lazy-lock.json
git checkout 12d8f4a8b5eaefddbedf1730705fe08cc075473c^ -- init.lua
```

Then manually apply the improvements listed above before committing.

---

## Risk Notes

- `mini.pairs` toggle uses `require("lazy.core.util")` — this will work fine
  once Lazy is back.
- `snacks.nvim` terminal replaces `toggleterm` for the `<leader>T` binding;
  both can coexist but decide which owns `<leader>t` vs `<leader>T`.
- `image.nvim` requires a terminal with image protocol support (Kitty/Ghostty).
  Keep it disabled by default as in the native config.
- The `tests/` directory is native-era only and won't interfere with Lazy.
