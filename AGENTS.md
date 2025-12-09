# AGENTS.md - Neovim Configuration Guide for AI Assistants

**Last Updated**: December 9, 2025  
**Scope**: Complete Neovim dotfiles configuration (45+ Lua files, 38 active plugins, 1,691+ lines of code)  
**Documentation Size**: 4,000+ lines across 7 comprehensive files

---

## Table of Contents

1. [Quick Start for AI Assistants](#quick-start-for-ai-assistants)
2. [Project Structure & Organization](#project-structure--organization)
3. [Architecture & Design Patterns](#architecture--design-patterns)
4. [Core Components & Specifications](#core-components--specifications)
5. [Plugin Categories](#plugin-categories)
6. [Configuration Patterns & Development](#configuration-patterns--development)
7. [Key Interfaces & APIs](#key-interfaces--apis)
8. [Common Tasks & How-To](#common-tasks--how-to)
9. [Data Models & State Management](#data-models--state-management)
10. [User Workflows & Interactions](#user-workflows--interactions)
11. [System Dependencies](#system-dependencies)
12. [Troubleshooting & Common Issues](#troubleshooting--common-issues)

---

## Quick Start for AI Assistants

### Understanding This Codebase in 60 Seconds

**The Neovim configuration is a Lua-based, modular editor setup with:**
- **Bootstrap**: `init.lua` loads Lazy.nvim plugin manager
- **Organization**: 5 plugin categories (AI, UI, LSP, Tools, Features) + 4 core config files
- **Plugin System**: 48 managed plugins (Lazy.nvim), 38 actively configured
- **Language Support**: Python (pyright), JavaScript/TypeScript (ts-tools), Bash (bashls), Lua (lua_ls)
- **AI Integration**: GitHub Copilot (primary) with Claude 3.7 Sonnet model
- **Completion**: Blink.cmp merges LSP, AI, snippets, and buffer sources

### Directory Structure at a Glance

```
vim/
├── init.lua                    # Entry point (bootstrap + plugin loading)
├── lazy-lock.json             # 48 plugins pinned to exact commits
├── README.md                  # Project documentation
├── lua/
│   ├── options.lua            # Editor settings (89 lines)
│   ├── keymaps.lua            # All keybindings (93 lines, ~20 bindings)
│   ├── autocmds.lua           # Auto-behaviors (99 lines)
│   ├── utils.lua              # Helper functions (8 lines)
│   └── plugins/               # Plugin configuration (38 files)
│       ├── ai/                # Copilot, Avante, SuperMaven (4 files)
│       ├── ui/                # Catppuccin, Lualine, Which-Key (8 files)
│       ├── lsp/               # LSP, Completion, TreeSitter (6 files)
│       ├── tools/             # Finder, Explorer, Terminal (11 files)
│       └── features/          # Debug, Markdown, Comments (9 files)
├── spell/                     # Spell check dictionaries (6 files)
├── screenshots/               # Demo images (5 PNG)
└── .sop/summary/              # Generated documentation (7 files)
```

### How to Navigate This Documentation

**Use this flow:**
1. **Understand overall structure** → This section
2. **Find specific component** → See "Plugin Categories" below or index.md
3. **Understand how to modify** → See "Configuration Patterns"
4. **Learn keybindings** → See "Key Interfaces & APIs"
5. **For deep dives** → Consult specific .sop/summary files

---

## Project Structure & Organization

### File Organization

```
Total Files: 45+ Lua files + 2 JSON + 6 spell files
Total Lines: 1,691+ Lua (289 core + 1,402 plugins)

Breakdown:
- Core Config: 4 files (289 lines)
- Plugin Code: 38 files (1,402 lines)
- Loaders: 5 files (~100 lines)
```

### Core Configuration Files

| File | Lines | Purpose | Modification Frequency |
|------|-------|---------|----------------------|
| `init.lua` | ~30 | Bootstrap, leader key, plugin loading | Rarely |
| `lua/options.lua` | 89 | Editor settings (line numbers, folding, mouse) | Monthly |
| `lua/keymaps.lua` | 93 | All custom keybindings | Frequently |
| `lua/autocmds.lua` | 99 | Auto-behaviors (markdown highlighting, telescope) | Occasionally |
| `lua/utils.lua` | 8 | Helper functions (keymap wrapper) | Rarely |

### Plugin Organization

Each category has this structure:
```
lua/plugins/[category]/
├── init.lua              # Loads all plugins in category
├── plugin1.lua           # Individual plugin spec
├── plugin2.lua
└── ...
```

**Example**: `lua/plugins/ai/init.lua` loads all AI plugins (copilot, avante, supermaven)

### Plugin Categories (5 Total)

| Category | Files | Purpose | Motivation |
|----------|-------|---------|-----------|
| **AI** | 4 | Code completion, AI chat | GitHub Copilot (primary), alternatives available |
| **UI** | 8 | Themes, status line, icons | Polished visual experience |
| **LSP** | 6 | Language servers, completion, formatters | Professional development |
| **Tools** | 11 | Finder, explorer, git, terminal | Productivity features |
| **Features** | 9 | Debug, markdown, comments | Extended functionality |

---

## Architecture & Design Patterns

### Initialization Sequence

```
1. nvim command → init.lua
   ├── Lazy.nvim bootstrap (auto-install if needed)
   ├── Leader key set to spacebar
   └── Load plugins from lua/plugins/

2. Lazy.nvim plugin loading
   ├── Reads all lua/plugins/*/init.lua
   ├── Each init.lua returns plugin specs
   └── Lazy loads based on events/commands

3. Core configuration loading
   ├── options.lua → Apply editor settings
   ├── keymaps.lua → Register keybindings
   ├── autocmds.lua → Register auto-behaviors
   └── Ready for user
```

### Plugin Loading Strategy

**Events-driven lazy loading:**
- `VimEnter`: UI plugins (theme, status line)
- `BufReadPre`: LSP plugins (language servers)
- `InsertEnter`: Completion engine
- `FileType`: Language-specific plugins
- Command-based: Specific plugins on command invocation

**Benefits:**
- Fast startup (plugins load on-demand)
- Low memory usage (inactive plugins unloaded)
- Responsive user experience

### Module Loading Pattern

Each plugin category follows this pattern:

```lua
-- lua/plugins/[category]/init.lua
return {
  require('plugins.[category].plugin1'),
  require('plugins.[category].plugin2'),
  -- Auto-loaded by Lazy.nvim
}
```

**Key insight**: Each plugin returns a Lazy.nvim spec table:
```lua
{
  "author/plugin-name",
  version = "*",
  event = "VimEnter",
  config = function()
    require("plugin-name").setup({...})
  end,
  dependencies = {...}
}
```

### Configuration Isolation

- **No global state pollution**: Each plugin isolated
- **Shared libraries**: plenary, nui, web-devicons (reused)
- **Clear dependencies**: Specified in plugin specs
- **Easy debugging**: Enable/disable categories in init.lua

---

## Core Components & Specifications

### 1. Bootstrap Component (init.lua)

**Responsibility**: Main entry point  
**Key Actions**:
```lua
vim.g.mapleader = " "  -- Set leader to spacebar
require("lazy-bootstrap").setup()  -- Bootstrap Lazy.nvim
require("lazy").setup("plugins", opts)  -- Load plugins
```

### 2. Editor Options (lua/options.lua)

**Responsibility**: Configure Neovim behavior  
**Key Settings**:
- Line numbering (relative + absolute)
- Folding via Tree-Sitter
- Mouse support in all modes
- System clipboard sync
- 2-space indentation

### 3. Key Bindings (lua/keymaps.lua)

**Responsibility**: All custom keybindings  
**Convention**: All use `<leader>` (spacebar) prefix  
**Count**: ~20 custom bindings

**Example keybindings**:
- `<leader>w`: Save file
- `<leader>ff`: Find files (Telescope)
- `<leader>p`: Toggle file explorer
- `<leader>/`: Toggle comment
- `jj`: Escape (insert mode)

### 4. Auto-behaviors (lua/autocmds.lua)

**Responsibility**: Automatic behaviors on events  
**Key Behaviors**:
- Custom markdown syntax highlighting
- Virtual indentation for organized notes
- Telescope auto-open on startup
- File-specific settings

### 5. Utilities (lua/utils.lua)

**Responsibility**: Shared helper functions  
**Main Export**: `map()` - keymap creation helper

**Usage in keymaps.lua**:
```lua
local map = require("utils").map
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
```

---

## Plugin Categories

### Category 1: AI Plugins (lua/plugins/ai/)

**Purpose**: AI-powered code completion and chat

**Files**:
- `copilot.lua` (Primary) - GitHub Copilot with Claude 3.7
- `supermaven.lua` - Alternative AI completion (disabled)
- `avante.lua` - Alternative Claude UI (disabled)
- `init.lua` - Category loader

**Key Integrations**:
- **Primary**: GitHub Copilot + CopilotChat
- **Completion**: Integrated via Blink.cmp
- **Chat**: Interactive AI assistance
- **Model**: Claude 3.7 Sonnet

**Keybindings**:
- `:CopilotChat` - Open AI chat
- Via completions: AI suggestions in completion menu

---

### Category 2: UI Plugins (lua/plugins/ui/)

**Purpose**: Visual appearance and interface

**Files**:
1. `catppuccin.lua` - Color theme (Frappe, transparent)
2. `lualine.lua` - Status line with custom layout
3. `lualine/theme.lua` - Custom lualine colors
4. `which-key.lua` - Keymap explorer/help
5. `colorizer.lua` - Highlight color codes
6. `icons.lua` - Web devicons setup
7. `typewritter.lua` - Distraction-free mode
8. `rosepine.lua` - Alternative theme (disabled)
9. `init.lua` - Category loader

**Key Features**:
- **Theme**: Catppuccin Frappe (dark, transparent background)
- **Status Line**: Mode, file info, git branch, LSP status
- **Icons**: File type indicators
- **Keymap Help**: Display available keybindings on timeout

---

### Category 3: LSP Plugins (lua/plugins/lsp/)

**Purpose**: Language server protocol, completions, diagnostics

**Files**:
1. `lsp-config.lua` - Mason, LSPConfig setup
2. `completion.lua` - Blink.cmp configuration
3. `treesitter.lua` - Syntax parsing
4. `none-ls.lua` - Formatters and diagnostics
5. `typescript.lua` - TypeScript-specific setup
6. `init.lua` - Category loader

**Installed Language Servers** (via Mason):
- `bashls` - Bash scripting
- `lua_ls` - Lua development
- `pyright` - Python with type checking
- `ts-tools` - JavaScript/TypeScript

**Formatters** (via None-LS):
- `stylua` - Lua formatting
- `black` - Python formatting
- `biome` - JS/TS/JSON formatting
- `beautysh` - Bash formatting
- `ruff` - Python linting

**Completion Sources** (priority order):
1. LSP (language server completions)
2. Copilot (AI suggestions)
3. Snippets (code templates)
4. Buffer (surrounding text)

---

### Category 4: Tools (lua/plugins/tools/)

**Purpose**: Productivity tools and utilities

**Files**:
1. `telescope.lua` - Fuzzy finder with FZF native
2. `telescope/multigrep.lua` - Multi-type search
3. `filemanager.lua` - Neo-tree file explorer
4. `gitsigns.lua` - Git change indicators
5. `toggleterm.lua` - Integrated terminal
6. `smart-splits.lua` - Window navigation
7. `obsidian.lua` - Note-taking integration
8. `overseer.lua` - Task automation
9. `pencil.lua` - Writing mode
10. `latex.lua` - LaTeX compilation
11. `jwtools.lua` - Custom utilities
12. `init.lua` - Category loader

**Key Tools**:
- **Finder**: `<leader>ff`, `<leader>fw`, `<leader>fg`
- **Explorer**: `<leader>p` (toggle file tree)
- **Git**: Gutter signs + blame information
- **Terminal**: Floating/split terminal
- **Notes**: Obsidian vault integration

---

### Category 5: Features (lua/plugins/features/)

**Purpose**: Extended editor functionality

**Files**:
1. `comment.lua` - Toggle comments (`<leader>/`)
2. `dap.lua` - Debugger (Python, JavaScript)
3. `markdown.lua` - Markdown rendering with images
4. `mini.lua` - Mini.nvim utilities (buffer ops, pairs)
5. `noice.lua` - Better UI for commands/messages
6. `silicon.lua` - Code to image screenshots
7. `snacks.lua` - UI improvements
8. `spell.lua` - Multi-language spell checking
9. `init.lua` - Category loader

**Key Features**:
- **Debugging**: Breakpoints, variable inspection
- **Comments**: `<leader>/` to toggle
- **Markdown**: Rendering with syntax highlighting
- **Spell Check**: English and Spanish (see `spell/` dir)
- **Notifications**: Better UI for messages

---

## Configuration Patterns & Development

### Pattern 1: Adding a New Plugin

**File**: Create `lua/plugins/[category]/[newplugin].lua`

```lua
return {
  {
    "author/plugin-name",
    event = "VimEnter",  -- or other event
    dependencies = {
      "dependency/plugin"
    },
    config = function(plugin, opts)
      require("plugin-name").setup({
        -- configuration
      })
    end,
    opts = {
      -- default options
    }
  }
}
```

**Auto-loading**: The category's `init.lua` automatically loads it

### Pattern 2: Adding New Keybindings

**File**: Edit `lua/keymaps.lua`

```lua
local map = require("utils").map

map("n", "<leader>xx", "<cmd>command<CR>", {
  noremap = true,
  silent = true,
  desc = "Description of what it does"
})
```

**Conventions**:
- Use `<leader>` (spacebar) for all custom bindings
- Mode: "n" (normal), "i" (insert), "v" (visual), "x" (selection)
- Always include `desc` for documentation

### Pattern 3: Adding New Options

**File**: Edit `lua/options.lua`

```lua
vim.opt.newOption = value
vim.opt.booleanOption = true
vim.opt.numberOption = 42
```

### Pattern 4: Adding New Auto-behaviors

**File**: Edit `lua/autocmds.lua`

```lua
vim.api.nvim_create_autocmd("EventName", {
  group = vim.api.nvim_create_augroup("GroupName", { clear = true }),
  pattern = "*.ext",
  callback = function()
    -- do something
  end
})
```

### Pattern 5: Customizing Theme

**File**: Edit `lua/plugins/ui/catppuccin.lua`

```lua
require("catppuccin").setup({
  flavour = "frappe",
  transparent_background = true,
  color_overrides = {
    frappe = {
      -- custom colors
    }
  }
})
```

### Coding Conventions

**Lua Style**:
- All configuration in Lua (no Vim script)
- Consistent indentation (2 spaces)
- Clear separation between categories
- Each plugin in separate file
- Shared utilities centralized

**File Organization**:
- Core config files in `lua/`
- Plugin files organized by category
- Each category has `init.lua` loader
- No cross-category dependencies

---

## Key Interfaces & APIs

### Keybindings Interface

**Complete Reference** (see lua/keymaps.lua):

| Binding | Mode | Action | Category |
|---------|------|--------|----------|
| `<leader>bn` / `<leader>l` | n | Next buffer | Navigation |
| `<leader>h` | n | Previous buffer | Navigation |
| `<leader>w` | n | Save file | File ops |
| `<leader>p` | n | Toggle explorer | File ops |
| `<leader>ff` | n | Find files | Finder |
| `<leader>fw` | n | Live grep | Finder |
| `<leader>fg` | n | Multi-grep | Finder |
| `<leader>fd` | n | Find diagnostics | LSP |
| `<leader>/` | n,v | Toggle comment | Editor |
| `<leader>ri` | n,x | Rename (LSP) | LSP |
| `<leader>sa` | n | Add to dictionary | Spell |
| `<leader>sn` | n | Next spelling error | Spell |
| `<leader>s?` | n | Spell suggestions | Spell |
| `<leader>s/` | n | Fuzzy spell search | Spell |
| `<leader>ot` | n | Obsidian today | Notes |
| `<leader>bp` | n | Pandoc to PDF | Docs |
| `jj` | i | Escape | Insert mode |

### LSP Interface

**Available LSP Commands**:
```lua
vim.lsp.buf.rename()          -- Rename symbol
vim.lsp.buf.code_action()     -- Code actions
vim.lsp.buf.definition()      -- Go to definition
vim.lsp.buf.hover()           -- Show hover info
vim.lsp.buf.references()      -- Find references
vim.lsp.buf.format()          -- Format code
```

**Key LSP Servers**:
- bashls (Bash)
- lua_ls (Lua)
- pyright (Python)
- ts-tools (TypeScript/JavaScript)

### Completion Interface

**Completion Sources** (in priority order):
1. **LSP**: Language server completions
2. **Copilot**: GitHub AI suggestions
3. **Snippets**: Code templates
4. **Buffer**: Surrounding text

**Completion Keys**:
- `<Tab>`: Select/confirm
- `<S-Tab>`: Previous item
- `<C-E>`: Cancel

### File Explorer Interface (Neo-tree)

**Key Operations**:
| Action | Key | Purpose |
|--------|-----|---------|
| Toggle | `<leader>p` | Show/hide explorer |
| Navigate | `j/k` | Up/down |
| Enter | `<CR>` | Open/expand |
| Create File | `a` | New file |
| Create Dir | `A` | New directory |
| Delete | `d` | Delete item |
| Rename | `r` | Rename item |
| Copy | `c` | Copy item |
| Move | `m` | Move item |

### Telescope Finder Interface

**Available Finders**:
| Binding | Command | Purpose |
|---------|---------|---------|
| `<leader>ff` | find_files | Find files |
| `<leader>fw` | live_grep | Live text search |
| `<leader>fg` | multigrep | Multi-type search |
| `<leader>fd` | diagnostics | Find diagnostics |

**Telescope Navigation**:
- `<C-j/k>`: Move down/up
- `<C-x>`: Open in split
- `<C-v>`: Open in vsplit
- `<C-t>`: Open in tab
- `<CR>`: Select
- `<ESC>`: Close

---

## Common Tasks & How-To

### Task 1: Add a New Keybinding

**Steps**:
1. Open `lua/keymaps.lua`
2. Add mapping: `map(mode, lhs, rhs, opts)`
3. Save and reload Neovim
4. Test keybinding

**Example**:
```lua
map("n", "<leader>xx", "<cmd>SomeCommand<CR>", { desc = "Do something" })
```

### Task 2: Install a Missing Language Server

**Steps**:
1. Open Neovim
2. Run `:Mason`
3. Search for server (e.g., "ruby")
4. Press `i` to install
5. Server auto-attaches to files

**Or manually in config**:
Add to `lua/plugins/lsp/lsp-config.lua` servers table

### Task 3: Change the Color Theme

**Steps**:
1. Edit `lua/plugins/ui/catppuccin.lua`
2. Change `flavour` to: "latte", "frappe", "macchiato", "mocha"
3. Or uncomment `lua/plugins/ui/rosepine.lua` for Rose Pine
4. Reload Neovim

### Task 4: Add a Formatter for Language X

**Steps**:
1. Install formatter via `:Mason` or package manager
2. Add to `lua/plugins/lsp/none-ls.lua` formatters
3. Configure formatting on save (optional)

**Example** for Python (black):
```lua
none_ls.builtins.formatting.black
```

### Task 5: Enable Spell Checking

**Default**: Spell check disabled  
**To Enable**:
1. Press `:set spell`
2. Or add `vim.opt.spell = true` to `lua/options.lua`
3. Use `<leader>s*` commands for spell operations

### Task 6: Configure Git Blame

**Built-in**: Gitsigns already configured  
**To Use**:
- Gutter signs show changed lines
- Run `:Gitsigns blame_line` to see blame

### Task 7: Debug Python Code

**Setup**:
1. Ensure `nvim-dap-python` configured
2. Set breakpoint: `:DapToggleBreakpoint`
3. Run `:DapContinue` to start debugging
4. Use `:DapStepOver`, `:DapStepInto`, etc.

### Task 8: Use AI Completions

**Built-in**: GitHub Copilot primary  
**To Use**:
1. Type code and trigger completion (auto-trigger)
2. AI suggestions appear in completion menu
3. Select with `<Tab>`
4. Or use `:CopilotChat` for conversational AI

### Task 9: Convert Markdown to PDF

**Built-in**: Pandoc integration  
**To Use**:
1. Open `.md` file
2. Press `<leader>bp` (Pandoc build PDF)
3. Output PDF generated

### Task 10: Take Code Screenshot

**Built-in**: Silicon plugin  
**To Use**:
1. Select code in visual mode
2. Run `:Silicon`
3. Image saved to clipboard/file

---

## Data Models & State Management

### Configuration Data Model

```lua
-- Core Neovim options
vim.opt.number = true              -- Line numbers
vim.opt.relativenumber = true       -- Relative numbering
vim.opt.expandtab = true            -- Spaces not tabs
vim.opt.shiftwidth = 2              -- Indent width
vim.opt.mouse = "a"                 -- Mouse in all modes
vim.opt.clipboard = "unnamedplus"  -- System clipboard
```

### Plugin Specification Model

```lua
{
  "plugin-author/plugin-name",
  version = "*",
  event = "VimEnter",
  lazy = true,
  config = function(plugin, opts)
    require("plugin-name").setup(opts)
  end,
  opts = { /* default options */ },
  dependencies = { /* other plugins */ }
}
```

### Keymap Data Model

```lua
{
  mode = "n",
  lhs = "<leader>w",
  rhs = "<cmd>w<CR>",
  opts = {
    noremap = true,
    silent = true,
    desc = "Save file"
  }
}
```

### LSP Configuration State

```lua
{
  servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } }
        }
      }
    },
    pyright = {},
    ts_tools = {}
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}
```

---

## User Workflows & Interactions

### Workflow 1: Basic Editing Session

```
1. Launch: nvim file.lua
2. Edit: Type code (insert mode)
3. Complete: Trigger completions (auto or <C-Space>)
4. Save: <leader>w
5. Format: Auto on save (via LSP/formatter)
```

### Workflow 2: Code Search & Navigation

```
1. Find: <leader>ff (find files)
2. Search: <leader>fw (grep text)
3. Navigate: <leader>fd (find diagnostics)
4. Open: Select with <CR>
```

### Workflow 3: Git-Aware Development

```
1. Open file: Gitsigns shows changes
2. View blame: :Gitsigns blame_line
3. Stage: :Gitsigns stage_hunk
4. Commit: External git tool
```

### Workflow 4: AI-Assisted Coding

```
1. Type code: Trigger completions
2. See suggestions: LSP + AI suggestions
3. Select: <Tab> to accept
4. Chat: :CopilotChat for conversational AI
```

### Workflow 5: Documentation & Writing

```
1. Open markdown: Auto-rendering active
2. Write: Markdown-aware editing
3. Spell check: <leader>s* commands
4. Convert: <leader>bp for PDF (Pandoc)
5. Take screenshot: :Silicon for code images
```

---

## System Dependencies

### Required Tools

| Tool | Version | Purpose | How to Check |
|------|---------|---------|--------------|
| Git | 2.0+ | Version control | `git --version` |
| Python | 3.8+ | LSP, formatters | `python3 --version` |
| Node.js | 14+ | TS/JS tools | `node --version` |
| ripgrep | 13+ | Fast searching | `rg --version` |

### Optional Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| LaTeX | Document compilation | `brew install mactex` or `sudo apt-get install texlive` |
| Pandoc | Format conversion | `brew install pandoc` or `sudo apt-get install pandoc` |
| Silicon | Code screenshots | `brew install silicon` or cargo |

### Installation

```bash
# macOS (Homebrew)
brew install git python3 node ripgrep
brew install --cask mactex
brew install pandoc

# Ubuntu/Debian
sudo apt-get install git python3 nodejs npm ripgrep
sudo apt-get install texlive pandoc

# Check installations
git --version
python3 --version
node --version
npm --version
rg --version
```

---

## Troubleshooting & Common Issues

### Issue: LSP Not Attaching

**Solution**:
1. Open Neovim: `:checkhealth`
2. Check LSP section for errors
3. Install server: `:Mason`
4. Search and install missing server
5. Restart Neovim

### Issue: Completions Not Showing

**Solution**:
1. Check LSP is attached: `:LspInfo`
2. Ensure Blink.cmp enabled: Check `lua/plugins/lsp/completion.lua`
3. Test trigger: Type and wait or press `<C-Space>`
4. Check dependencies: Python/Node.js installed

### Issue: Telescope Finder Slow

**Solution**:
1. Ensure ripgrep installed: `rg --version`
2. Check FZF native compiled: `:checkhealth`
3. Disable large dirs: Configure in `lua/plugins/tools/telescope.lua`
4. Update plugins: `:Lazy sync`

### Issue: Keybindings Not Working

**Solution**:
1. Check keymap defined: `:verbose map <leader>xx`
2. Verify syntax in `lua/keymaps.lua`
3. Reload config: `:source ~/.config/nvim/init.lua`
4. Check for conflicts with terminal settings

### Issue: Theme/Colors Not Applying

**Solution**:
1. Check theme configured: `:Catppuccin`
2. Ensure terminal supports colors: Check terminal settings
3. Set background: `vim.opt.background = "dark"`
4. Reload Neovim

### Issue: Git Signs Not Showing

**Solution**:
1. Ensure repository initialized: `git init`
2. Gitsigns needs git: Check `git status` works
3. Check enabled: `:Gitsigns toggle_signs`
4. Verify gutter visible

### Issue: Performance / Slow Startup

**Solution**:
1. Check plugin load times: `:Lazy profile`
2. Disable unused plugins in `lua/plugins/*/init.lua`
3. Check autocmds: `:autocmd`
4. Profile: `:checkhealth`

### Issue: Python Completions Missing

**Solution**:
1. Install pyright: `:Mason` → search "pyright" → install
2. Check Python installed: `python3 --version`
3. Ensure Blink.cmp enabled
4. Restart Neovim: `:wq` and reopen

### Issue: Spell Check Not Working

**Solution**:
1. Enable spell: `:set spell`
2. Check language: `:set spelllang`
3. Verify dict files exist: `ls spell/`
4. Add to options: `vim.opt.spell = true`

---

## Reference Documentation

For more detailed information, consult:

- **architecture.md**: System design, initialization, extension points
- **components.md**: Detailed component specifications
- **interfaces.md**: All keybindings, APIs, user interfaces
- **data_models.md**: State structures, data flow
- **workflows.md**: User interaction patterns
- **codebase_info.md**: Project statistics, overview
- **dependencies.md**: System requirements, compatibility

---

## Development Patterns Summary

### Pattern: Modular Organization
- Each plugin in separate file
- Categories organize by function
- Auto-loading via category init.lua
- No shared state between plugins

### Pattern: Event-Driven Loading
- Lazy loading minimizes startup time
- Plugins load on-demand (events, commands)
- Tree-Sitter provides efficient parsing
- Blink.cmp efficiently manages completions

### Pattern: Configuration Centralization
- All keybindings in keymaps.lua
- All options in options.lua
- All auto-behaviors in autocmds.lua
- All utilities in utils.lua

### Pattern: Clear Dependencies
- Lazy.nvim handles plugin deps
- Shared libraries centralized
- No circular dependencies
- Easy to trace plugin relationships

---

## Key Statistics

| Metric | Value |
|--------|-------|
| Total Files | 45+ Lua files |
| Total Lines | 1,691+ lines |
| Plugin Files | 38 files |
| Plugin Count | 48 (managed) |
| Configuration Files | 4 (+ 5 loaders) |
| Categories | 5 (AI, UI, LSP, Tools, Features) |
| Keybindings | 20+ custom bindings |
| Language Servers | 4 (bash, lua, python, typescript) |
| Formatters | 5+ (stylua, black, biome, etc.) |

---

## Quick Command Reference

```bash
# Installation
nvim                          # Launch editor
:Mason                        # Install language servers
:Lazy sync                    # Update plugins
:checkhealth                  # Diagnose issues

# Editing
jj                           # Escape to normal mode
<leader>w                    # Save file
<leader>/<Space>             # Toggle comment

# Navigation
<leader>ff                   # Find files
<leader>fw                   # Search text
<leader>p                    # Toggle file explorer

# LSP & Completion
<leader>ri                   # Rename symbol
<Tab>                        # Accept completion
<C-Space>                    # Trigger completion

# Git
:Gitsigns blame_line         # Show git blame
:Gitsigns stage_hunk         # Stage change

# Special
:CopilotChat                 # AI chat
:Silicon                     # Code screenshot
<leader>bp                   # Pandoc to PDF
```

---

## Final Notes for AI Assistants

### How to Help Users Effectively

1. **Always reference file paths**: e.g., `lua/plugins/ai/copilot.lua:line 10`
2. **Use Mermaid diagrams**: For complex architecture, see architecture.md
3. **Check .sop/summary files**: For detailed specifications
4. **Verify keybindings**: Reference interfaces.md for complete keymap list
5. **Suggest patterns**: Follow existing patterns in codebase

### Common Modifications

- **Add plugin**: Create file in `lua/plugins/[category]/`
- **Add keybinding**: Edit `lua/keymaps.lua`
- **Change theme**: Edit `lua/plugins/ui/catppuccin.lua`
- **Configure LSP**: Edit `lua/plugins/lsp/lsp-config.lua`
- **Add formatter**: Update `lua/plugins/lsp/none-ls.lua`

### Testing Changes

```bash
# Reload config
:source ~/.config/nvim/init.lua

# Verify plugins
:Lazy status

# Check syntax
:checkhealth
```

---

**Generated**: December 9, 2025  
**Documentation Version**: 1.0  
**Scope**: Complete Neovim dotfiles configuration ecosystem
