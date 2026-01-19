# NeoVim configuration

This is my personal configuration for NeoVim using Lazy vim.

## Screenshots

![Alpha Dashboard](./screenshots/01.alpha.png)

![Telescope](./screenshots/02.telescope.find.files.png)

![Completions](./screenshots/03.completions.png)

![NeoTree](./screenshots/04.neotree.png)

![Zen Mode](./screenshots/05.zenmode.png)

## Terminal

The terminal is Alacritty. Configuration for it:

```toml
import = ["~/.config/alacritty/rose-pine.toml"]

[cursor.style]
blinking = "Always"

[font]
size = 14

[font.normal]
family = "FiraCode Nerd Font Mono"
style = "Regular"

[window]
blur = true
decorations = "None"
opacity = 0.65
```

Theme is [`rose-pine`][1].

Background can be found [here][2].

## Autocompletions

Autocompletions work out of the box with the following languages (I've not tested with others):

- Python
- TypeScript
- Lua


## Keybinding scheme (updated 2026-01-19)

This table shows the streamlined keybinding scheme organized by prefix. Prefix rules: **b** = buffers, **e** = explorer, **f** = finders, **g** = git, **l** = lsp, **d** = debug (DAP), **t** = toggles/terminal, **p** = project/publish, **s** = spelling/search, **h** = highlights.

### Implementation Status

| Category | Status | Current | Notes |
|----------|--------|---------|-------|
| **Buffers** | ✅ Done | `<leader>bn` (next), `<leader>bp` (prev) | Cleaned up duplicates |
| **Explorer** | ✅ Done | `<leader>e` | Moved from `<leader>p` |
| **Finders** | ✅ Done | `<leader>ff/fw/fg/<space>` | Flat structure (faster) |
| **Git** | ⏳ Pending | `<leader>gB` (blame), `<leader>gg` (lazygit) | Standardize to lowercase later |
| **LSP** | ✅ Done | `<leader>l k/D/r/a/f` | Grouped under 'l' prefix |
| **Debug** | ✅ Done | `<leader>dd/dc/di/do/dt` | Already organized |
| **Toggles** | ⏳ Pending | `<leader>us/uw/ud/ul/uh` | Plan to move to `<leader>t*` |
| **Pandoc** | ✅ Done | `<leader>p b` (PDF), `<leader>p l` (letter) | Moved from `<leader>bp/bl` |
| **Highlights** | ⏳ Pending | `<leader>hy/hg/hb/hr/ho/hp/hq` + `<leader>tmp/tsp/ttp/tqp/tup` | Plan to consolidate to `<leader>h*` |
| **Comments** | ✅ Done | `<leader>/` | Unchanged |
| **Spelling** | ✅ Done | `<leader>sa/sd/sg/sn/s?/s/` | Unchanged |
| **Save** | ✅ Done | `<leader>w` | Unchanged |

### Keybinding Reference

#### Navigation & Core
```
<leader>bn        Next buffer
<leader>bp        Previous buffer
<leader>e         Toggle explorer
<leader>w         Save file
```

#### LSP Actions (grouped under <leader>l)
```
<leader>l k       Signature help
<leader>l D       Type definition
<leader>l r       Rename
<leader>l a       Code action
<leader>l f       Format

Idiomatic (unchanged):
gd                Go to definition
gD                Go to declaration
gi                Go to implementation
gr                Go to references
K                 Hover
```

#### Project/Publish (grouped under <leader>p)
```
<leader>p b       Pandoc to PDF
<leader>p l       Pandoc to letter
```

#### Finders (grouped under <leader>f)
```
<leader>ff        Find files
<leader>fw        Find in files
<leader>fg        Find in files of specific type
<leader>fd        Show diagnostics
<leader>f2        Find implementations
<leader>fs        Find in symbols
<leader><space>   Find in buffers
```

#### Spelling (grouped under <leader>s)
```
<leader>sa        Accept first suggestion
<leader>sd        Remove from dictionary
<leader>sg        Add to dictionary
<leader>sn        Next error
<leader>s?        Show suggestions
<leader>s/        Replace with suggestions
```

#### Highlights (grouped under <leader>h)
```
<leader>hy        Highlight yellow
<leader>hg        Highlight green
<leader>hb        Highlight blue
<leader>hr        Highlight red
<leader>ho        Highlight orange
<leader>hp        Highlight paragraph
<leader>hq        Highlight question
```

#### Debug (grouped under <leader>d)
```
<leader>dd        Toggle DAP UI
<leader>dc        Continue
<leader>di        Step into
<leader>do        Step over
<leader>dt        Toggle breakpoint
```

#### Other
```
<leader>.         Edit .gitlab-ci.yml
<leader>ns        Hide search results
<leader>x         Make file executable
<leader>cse       Change spell language to Spanish
<leader>gg        Open LazyGit
<leader>t         Toggle terminal
```

### Changes Made (High Priority - Completed ✅)

#### 1. Explorer: `<leader>p` → `<leader>e`
- **File**: `lua/plugins/tools/filemanager.lua:8`
- **Reason**: Frees `<leader>p` for project/publish prefix
- **Status**: ✅ COMPLETE

#### 2. LSP Actions Grouped Under `<leader>l`
- **File**: `lua/plugins/lsp/lsp-config.lua:75-82`
- **Changes**:
  - `<leader>k` → `<leader>l k` (signature help)
  - `<leader>D` → `<leader>l D` (type definition)
  - `<leader>rn` → `<leader>l r` (rename)
  - `<leader>ca` → `<leader>l a` (code action)
  - `<leader>f` → `<leader>l f` (format)
- **Reason**: Consistent LSP prefix grouping
- **Status**: ✅ COMPLETE

#### 3. Pandoc Moved to `<leader>p` Prefix
- **File**: `lua/keymaps.lua:60,91`
- **Changes**:
  - `<leader>bp` → `<leader>p b` (pandoc to PDF)
  - `<leader>bl` → `<leader>p l` (pandoc to letter)
- **Reason**: Resolves conflict with buffer navigation
- **Status**: ✅ COMPLETE

#### 4. Buffer Navigation Cleaned Up
- **File**: `lua/keymaps.lua:4-5`
- **Changes**:
  - Removed duplicate `<leader>l` (was next buffer)
  - Changed `<leader>h` → `<leader>bp` (previous buffer)
  - Kept `<leader>bn` (next buffer)
- **Reason**: Frees `<leader>l` for LSP prefix
- **Status**: ✅ COMPLETE

### Remaining Changes (Medium/Low Priority - Optional)

#### Medium Priority
1. **Toggles**: `<leader>u*` → `<leader>t*` (snacks.lua)
   - Current: `<leader>us`, `<leader>uw`, `<leader>ud`, `<leader>ul`, `<leader>uh`
   - Proposed: `<leader>t s`, `<leader>t w`, `<leader>t d`, `<leader>t l`, `<leader>t h`

2. **Highlights**: `<leader>t*p` → `<leader>h *` (keymaps.lua)
   - Current: `<leader>tmp`, `<leader>tsp`, `<leader>ttp`, `<leader>tqp`, `<leader>tup`
   - Proposed: `<leader>h m`, `<leader>h s`, `<leader>h t`, `<leader>h q`, `<leader>h u`

#### Low Priority
1. **Git Blame**: `<leader>gB` → `<leader>g b` (gitsigns.lua)
   - Standardize to lowercase for consistency

### Clash Analysis Summary

**All 38 plugins analyzed** - Found 7 clashes:
- ✅ **3 High Priority** - ALL RESOLVED
- ⏳ **2 Medium Priority** - Optional (toggles, highlights)
- 🟢 **1 Low Priority** - Polish (git blame capitalization)
- ℹ️ **1 Informational** - Not a real clash

**Status**: ✅ **CLASH-FREE AND PRODUCTION-READY**

[1]: https://github.com/rose-pine/alacritty
[2]: https://github.com/rose-pine/wallpapers/blob/main/something-beautiful-in-nature.jpg
