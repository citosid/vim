# Plan: Revert to Lazy.nvim Configuration

## Context

Commit `12d8f4a8` removed the entire Lazy.nvim setup in preparation for a
"barebones/native" migration. Since then, improvements were made on top of the
native config. The goal is to restore the Lazy.nvim setup while cherry-picking
those improvements.

---

## Decisions

| # | Question | Answer |
|---|----------|--------|
| 1 | Telescope vs fzf-lua for startup/finder | **Telescope** — restore the lazy-era finder |
| 2 | `options.lua` strategy | **Merge** — lazy-era as base, add native-era additions |
| 3 | LSP keymaps prefix | **Keep `<leader>l*`** from native era |

---

## What the Lazy Config Looked Like (pre-`12d8f4a8`)

- `init.lua` — bootstraps Lazy.nvim, sets leader, loads `plugins/`, then
  `keymaps` + `autocmds`
- `lua/plugins/` — categorized plugin specs (ai, ui, lsp, tools, features)
- `lazy-lock.json` — pinned plugin revisions
- `lua/theme-loader.lua` — reads `~/.local/state/dotfiles/theme` and applies it

Plugin inventory (from parent of `12d8f4a8`):

| Category | Plugins |
|----------|---------|
| AI | copilot.vim, CopilotChat |
| UI | catppuccin, lualine, which-key, noice, snacks (notifier/zen/input/terminal) |
| LSP | mason, mason-lspconfig, nvim-lspconfig, blink.cmp, none-ls, mason-null-ls, none-ls-extras |
| Tools | telescope + fzf-native, neo-tree, gitsigns, toggleterm, smart-splits, obsidian |
| Features | render-markdown, image.nvim, mini.bufremove, mini.pairs, nvim-dap + dap-ui, nvim-treesitter |

---

## Improvements Made in the Native Config (to preserve)

These were added after `12d8f4a8` and must be carried forward.

> **Note**: Items marked _(already in lazy-era)_ were incorrectly identified as
> new in the original plan. They exist in the lazy-era source and do NOT need
> re-applying. They are listed here only for completeness.

### `lua/keymaps.lua`

- `<leader>of` — reveal file in Finder (`!open -R %`) **NEW**
- `<leader>l` — switch to last buffer (`b#`) **NEW**
- `<leader>pb` / `<leader>pl` — pandoc PDF build now uses `lualatex` (was
  `xelatex` in lazy era) **CHANGED**
- `<leader>tw` — typewriter mode toggle (inline, not a plugin) **NEW**
- Native commenting via `gcc`/`gc` remapped to `<leader>/` (replaces
  `comment.lua` plugin) **NEW**
- `<Esc>` in insert mode added alongside `jj` **NEW**
- `<leader>sd` / `<leader>sg` — _(already in lazy-era)_

### `lua/autocmds.lua`

- `ColorScheme` autocmd to re-apply highlight colors on theme switch **NEW**
- Markdown `FileType` autocmd now also enables folding
  (`foldmethod=expr`) and calls `vim.treesitter.start()` **NEW**
- `conceallevel`/`concealcursor` set in the markdown autocmd **NEW**
- `notes_dirs` is now a list (two paths) instead of a single string **CHANGED**
- Startup autocmd: **keep Telescope** (`require("telescope.builtin").find_files()`)
- Remove NeoTree highlight hack (top of file) — belongs in plugin config **REMOVE**
- Individual conceal `matchadd` calls replace grouped regex — **NEW**
  (lazy-era used `vim.fn.matchadd("Conceal", "\\\\hl[bgoqry]")` as one
  pattern; native era splits into per-prefix calls)

### `lua/options.lua`

Native-era options is **not** a strict superset. Both files have unique
content. Strategy: use lazy-era as base, then merge in native-era additions.

Native-era additions (not in lazy-era):

- `vim.g.autoformat = true`
- `vim.g.root_spec`
- `opt.showcmd = true`
- `opt.showcmdloc = "statusline"`

Lazy-era content missing from native-era (must keep):

- `opt.foldlevel = 20`
- `opt.foldmethod = "expr"`
- `opt.foldexpr = "nvim_treesitter#foldexpr()"`
- `opt.fillchars` with fold characters (`foldopen`, `foldclose`, `fold`,
  `foldsep`, `diff`)
- `opt.smoothscroll = true` (guarded by `nvim-0.10` check)
- `vim.g.markdown_recommended_style = 0`
- `vim.diagnostic.config` with custom sign text (⛔💡💁󱍼)
- `vim.g.markdown_highlight_colors` table (used by `autocmds.lua`)

### `lua/theme-loader.lua`

Use lazy-era version as base (better structure: exported `M.theme_map`,
`M.default_theme`, `M.state_file`, documented functions). Then add new
themes to `theme_map`:

- `aurora`, `crystals`, `headphones`, `tron-ares`
- `ai-flower`, `ai-machine`, `aimachine`, `fantasy-autumn`
- `color-wall`

> `enterprise-desert` already exists in the lazy-era version.

### `colors/` directory

New colorscheme files (keep all from HEAD): `aurora.lua`, `crystals.lua`,
`headphones.lua`, `tron-ares.lua`, `ai-flower.lua`, `ai-machine.lua`,
`aimachine.lua`, `fantasy-autumn.lua`, `color-wall.lua`. (`enterprise-desert`
and `prism` existed before.)

### `lua/plugins/ui/lualine/` themes

New lualine themes for each new colorscheme (one file per theme). Also
restore `theme.lua` (catppuccin-based) from the lazy-era — it exists in
`12d8f4a8^` but not at HEAD.

### `lua/plugins/lsp/lsp-config.lua`

- `gopls` — _(already in lazy-era)_
- LSP keymaps reorganized under `<leader>l*` prefix — **keep** this layout

### `lua/plugins/lsp/none-ls.lua`

Most items listed in the original plan already existed in the lazy-era:

- `gofmt`, `goimports`, `golangci_lint` — _(already in lazy-era)_
- `--config-path=/Users/acruz/biome.json` — _(already in lazy-era)_
- `markdownlint-cli2` formatter with `--fix` flag — _(already in lazy-era)_

Actual native-era improvement to apply:

- `--format-with-errors=true` added to biome args **NEW**
- `client:supports_method` syntax (colon, not dot) — Neovim 0.11+ API **NEW**

### `lua/plugins/features/markdown.lua`

- `image.nvim` rendering disabled by default — _(already in lazy-era)_
  (the lazy-era file already has `editor_only_render_when_focused = true`,
  `only_render_image_at_cursor = true`)

### `lua/plugins/tools/toggleterm.lua`

- Close mapping changed from `<C-j><C-j>` to `<C-l><C-l>` **CHANGED**

### `spell/`

- `en.utf-8.add` — words `hlpn` and `hlq` added

### `.stylua.toml`

- New file (didn't exist in lazy era). Keep it.

### `lua/.luarc.json`

- Deleted in `12d8f4a8`. Restore it — needed for `lua_ls` to recognize
  `vim` globals.

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

Restore the full category tree from `12d8f4a8^`:

```bash
git checkout 12d8f4a8^ -- lua/plugins/ai/ lua/plugins/ui/ lua/plugins/lsp/ \
  lua/plugins/tools/ lua/plugins/features/
```

This recreates:

```text
lua/plugins/
  ai/       init.lua  copilot.lua
  ui/       init.lua  catppuccin.lua  lualine.lua  lualine/  which-key.lua
            noice.lua  icons.lua  typewritter.lua  rosepine.lua  colorizer.lua
            prism.lua
  lsp/      init.lua  lsp-config.lua  completion.lua  treesitter.lua
            none-ls.lua  typescript.lua
  tools/    init.lua  telescope.lua  telescope/multigrep.lua  filemanager.lua
            gitsigns.lua  toggleterm.lua  smart-splits.lua  obsidian.lua
            overseer.lua  latex.lua  jwtools.lua
  features/ init.lua  comment.lua  dap.lua  markdown.lua  mini.lua
            noice.lua  silicon.lua  snacks.lua
```

Then apply per-file improvements in later steps.

### Step 3 — Restore `lua/.luarc.json`

```bash
git checkout 12d8f4a8^ -- lua/.luarc.json
```

### Step 4 — Update `lua/keymaps.lua`

Use the lazy-era file as the base, then apply **only actual new** improvements:

- Add `<leader>of` (reveal in Finder)
- Add `<leader>l` (switch to last buffer)
- Add `<leader>tw` (typewriter mode toggle)
- Change pandoc `--pdf-engine` from `xelatex` to `lualatex`
- Add native comment remaps (`gcc`/`gc` → `<leader>/`)
- Add `<Esc>` insert-mode map alongside `jj`

**Do NOT** re-add `<leader>sd` / `<leader>sg` — they already exist in the
lazy-era file.

### Step 5 — Update `lua/autocmds.lua`

Use the lazy-era file as the base, then apply improvements:

- **Remove** NeoTree highlight hack at top of file
- **Add** `ColorScheme` autocmd for highlight re-application
- **Update** markdown `FileType` autocmd:
  - Use `nvim_create_autocmd` (not `vim.cmd augroup`)
  - Add `vim.opt_local.foldmethod = "expr"`
  - Add `vim.treesitter.start()`
  - Add `vim.opt_local.conceallevel = 2`
  - Add `vim.opt_local.concealcursor = "nc"`
- **Expand** `notes_dir` → `notes_dirs` list with two paths
- **Keep** startup autocmd as `require("telescope.builtin").find_files()`
- **Split** conceal `matchadd` patterns into individual calls (native-era
  approach, more maintainable)

### Step 6 — Update `lua/options.lua`

Use lazy-era as base, then merge in native-era additions:

1. Keep all lazy-era content (folding, fillchars, smoothscroll, diagnostic
   signs, markdown highlight colors, `markdown_recommended_style`)
2. Add from native-era: `vim.g.autoformat`, `vim.g.root_spec`,
   `opt.showcmd`, `opt.showcmdloc`
3. **Remove** `vim.g.mapleader` (set in `init.lua`)
4. **Move** `vim.diagnostic.config({ virtual_text = true })` to `init.lua`
   (keep the sign config in options)

### Step 7 — Update `lua/theme-loader.lua`

Use lazy-era version as base (has `M.theme_map`, `M.default_theme`,
`M.state_file`, `M.get_current_theme()`, `M.get_colorscheme()`). Then add
new theme entries:

```lua
["aurora"] = "aurora",
["crystals"] = "crystals",
["headphones"] = "headphones",
["tron-ares"] = "tron-ares",
["ai-flower"] = "ai-flower",
["ai-machine"] = "ai-machine",
["aimachine"] = "aimachine",
["fantasy-autumn"] = "fantasy-autumn",
["color-wall"] = "color-wall",
```

### Step 8 — Keep `colors/` files

All colorscheme files at HEAD are additive. No action needed.

### Step 9 — Keep and merge `lua/plugins/ui/lualine/` themes

After Step 2 restores the lazy-era lualine themes (`prism.lua`, `theme.lua`,
`color-wall.lua`, `enterprise-desert.lua`), the native-era themes already
at HEAD under `lua/plugins/ui/lualine/` will have been overwritten by the
`git checkout`. Copy the native-era-only themes back:

New themes to ensure exist (from HEAD): `aurora.lua`, `crystals.lua`,
`headphones.lua`, `tron-ares.lua`, `ai-flower.lua`, `ai-machine.lua`,
`aimachine.lua`, `fantasy-autumn.lua`.

### Step 10 — Update `lua/plugins/lsp/none-ls.lua`

Only one actual change vs lazy-era:

- Add `--format-with-errors=true` to biome `args` list
- Update `on_attach`: change `current_client.supports_method` to
  `current_client:supports_method` (Neovim 0.11+ colon syntax)

Everything else (gofmt, goimports, golangci, config-path, markdownlint
`--fix`) already exists in the lazy-era file.

### Step 11 — Update `lua/plugins/lsp/lsp-config.lua`

The lazy-era file already has `gopls` and `<leader>l*` keymaps. No changes
needed — just verify the restored file matches expectations.

### Step 12 — Update `lua/plugins/tools/toggleterm.lua`

Change terminal close mapping from `<C-j><C-j>` to `<C-l><C-l>`.

### Step 13 — Clean up native-only files

Delete files that exist only in the native config:

- `lsp/` top-level directory (native LSP configs — replaced by
  mason/lspconfig)
- `lua/completion.lua` (native completion — replaced by blink.cmp)
- `lua/lsp.lua` (native LSP setup — replaced by lsp-config.lua plugin)
- `lua/plugins.lua` (native pack loader — replaced by Lazy)
- `lua/plugins/buffers.lua`, `copilot.lua`, `extras.lua`, `files.lua`,
  `fzf.lua`, `gitsigns.lua`, `icons.lua`, `mason.lua`, `none-ls.lua`,
  `terminal.lua`, `ui.lua` (flat native plugin files — replaced by category
  structure)
- `lua/plugins/lualine/prism.lua` (duplicate — the canonical path is
  `lua/plugins/ui/lualine/prism.lua`)
- `nvim-pack-lock.json` (native lockfile — replaced by `lazy-lock.json`)

> Delete after the Lazy config is verified working.

### Step 14 — Restore `lazy-lock.json`

Use the version from `12d8f4a8^` as a starting point, then run `:Lazy sync`
to update to current plugin versions.

```bash
git checkout 12d8f4a8^ -- lazy-lock.json
```

### Step 15 — Verify

```text
:checkhealth
:Lazy status
:LspInfo
```

Confirm: LSP attaches, completions work, theme loads, Telescope opens on
startup, format-on-save works, `<leader>l*` keymaps work.

---

## Files to Restore from `12d8f4a8^` (git source of truth)

Bulk restore:

```bash
git checkout 12d8f4a8^ -- \
  init.lua \
  lazy-lock.json \
  lua/.luarc.json \
  lua/plugins/ai/ \
  lua/plugins/ui/ \
  lua/plugins/lsp/ \
  lua/plugins/tools/ \
  lua/plugins/features/
```

Then manually apply improvements (Steps 4–12) before committing.

---

## Risk Notes

- `mini.pairs` toggle uses `require("lazy.core.util")` — works once Lazy is
  back.
- `snacks.nvim` terminal replaces `toggleterm` for the `<leader>T` binding;
  both can coexist but decide which owns `<leader>t` vs `<leader>T`.
- `image.nvim` requires a terminal with image protocol support
  (Kitty/Ghostty). Already disabled by default in lazy-era config.
- The `tests/` directory is native-era only and won't interfere with Lazy.
- `client:supports_method` (colon syntax) requires Neovim 0.11+. The lazy-era
  used `client.supports_method` (dot). Must update for current Neovim.
- `lua/plugins/features/markdown.lua` — lazy-era already has image.nvim
  disabled by default. No changes needed.
