# Requirements Clarification

This document captures the Q&A process for refining the Neovim native migration requirements.

---

## Q1: Migration Strategy

**Question:** Should the `barebones` config be a completely fresh start, or do you want to migrate your existing
`config/vim/` configuration incrementally (keeping what works, replacing plugins one by one)?

**Answer:** Build up `config/bim/` incrementally using the existing foundation there, without modifying `config/vim/`.
The config is already symlinked to the correct location (`~/.config/barebones/`).

**Current state of `config/bim/`:**

- `init.lua` - loads options, keymaps, plugins; enables lua_ls and ts_ls via native `vim.lsp.enable()`
- `lua/options.lua` - comprehensive vim options already configured
- `lua/keymaps.lua` - basic keymaps (Q disabled, save, jj escape)
- `lua/plugins.lua` - uses native `vim.pack.add()` with nvim-lspconfig
- `lsp/lua_ls.lua` - lua_ls configuration
- `nvim-pack-lock.json` - native package lock file

---

## Q2: Must-Have Features

**Question:** Looking at your current `config/vim/` plugins, which features are absolute must-haves that you cannot
work without? (e.g., fuzzy file finding, git signs, completion, specific LSP servers, etc.)

**Answer:** All current functionality should be migrated to native equivalents where possible. For plugins that must
be removed (like snacks), need a clear inventory of what functionality would be lost before deciding.

**Current Telescope keybindings to preserve:**

- `<leader><space>` - Find in open buffers
- `<leader>fd` - Show diagnostics / LSP definitions
- `<leader>fg` - Multi-grep (find in files of specific type)
- `<leader>ff` - Find files
- `<leader>f2` - Find implementations
- `<leader>fs` - Find document symbols
- `<leader>fw` - Live grep (find in files)

**Current Snacks functionality:**

- `input` - Enhanced input UI
- `notifier` - Fancy notifications
- `picker` - Picker UI (enabled but unclear if used)
- `quickfile` - Quick file operations
- `statuscolumn` - Custom status column
- `terminal` - Terminal toggle (`<leader>T`)
- `words` - Word highlighting
- `zen` - Zen mode (`<leader>z`)
- `gitbrowse` - Open file in browser (`<leader>gb`)
- `lazygit` - Lazygit integration (`<leader>gf`)
- Toggle options: spell, wrap, diagnostics, line numbers, inlay hints

---

## Q3: Telescope Replacement

**Question:** Neovim nightly has a native `vim.ui.select` and there are lightweight alternatives like `fzf-lua` or
`mini.pick`. For fuzzy finding, would you prefer:

1. **Native-first** - Use `vim.ui.select` + custom Lua functions wrapping `fzf` CLI (most minimal, but more manual work)
2. **mini.pick** - Part of mini.nvim, very lightweight, native-feeling
3. **fzf-lua** - More feature-complete, still lighter than Telescope, excellent performance

**Answer:** Use **fzf-lua** as a pragmatic middle ground:

- Single plugin (vs Telescope's 3+ dependencies)
- Uses existing `fzf` binary
- Drop-in keybinding compatibility
- Can replace individual pickers with custom Lua later if desired

---

## Q4: Completion Strategy

**Question:** You're currently using `blink.cmp` with LSP, path, snippets, and buffer sources. Neovim nightly has
improved native completion (`vim.lsp.completion`), but it's more basic. Options:

1. **Native completion** - Use `vim.lsp.completion.enable()` + omnifunc (minimal, no snippets without extra work)
2. **mini.completion** - Lightweight, integrates with LSP
3. **blink.cmp** - Keep current (it's already lightweight and fast)

Given blink.cmp is already minimal and performant, do you want to keep it, or try native completion first?

**Answer:** Try native completion first. Requirements:

- No snippets needed
- **Enter** to select highlighted option
- **Arrow keys** to navigate options
- **Tab** does NOT navigate or select
- **AI completion (Copilot):**
  - `Ctrl-O` accepts partial suggestion
  - `Ctrl-Y` accepts whole suggestion

---

## Q5: AI Completion (Copilot)

**Question:** You're using `copilot.vim` + `CopilotChat.nvim`. These are the official/community plugins with no native
alternative. Do you want to:

1. **Keep both** - copilot.vim for inline suggestions, CopilotChat for chat
2. **Keep copilot.vim only** - Drop CopilotChat (do you use it?)
3. **Evaluate alternatives** - There's also `copilot.lua` (Lua rewrite) but copilot.vim is official

**Answer:** Keep `copilot.vim` only. Drop CopilotChat.

---

## Q6: File Explorer

**Question:** You're using `neo-tree.nvim` with `<leader>e` to toggle. Options:

1. **Native netrw** - Built-in, no plugins needed, but less polished UI
2. **mini.files** - Lightweight, modal file manipulation
3. **oil.nvim** - Edit filesystem like a buffer (very native-feeling)
4. **Keep neo-tree** - It works, but has dependencies (plenary.nvim)

Which approach appeals to you?

**Answer:** Use `mini.files` with custom configuration:

- Files not deleted permanently (use trash)
- `<CR>` → go_in_plus (open file and close explorer)
- Swap `go_out` and `go_out_plus` (h goes to parent and closes, H just goes to parent)
- `,` → reset
- `.` → reveal_cwd
- `s` → synchronize

---

## Q7: Git Integration

**Question:** You're using `gitsigns.nvim` for git signs in gutter and inline blame. Options:

1. **Keep gitsigns.nvim** - No native alternative, it's lightweight and standalone (no dependencies)
2. **mini.diff** - Part of mini.nvim, shows diff signs but less feature-rich than gitsigns
3. **Native only** - Just use `:Git` commands, no gutter signs

Gitsigns is already minimal. Keep it or try mini.diff?

**Answer:** Keep `gitsigns.nvim` - it's already lightweight with no dependencies.

---

## Q8: Treesitter

**Question:** You're using `nvim-treesitter` for syntax highlighting and indentation. Neovim nightly bundles
treesitter parsers and has native treesitter support, but `nvim-treesitter` plugin still provides:

- Auto-install of parsers
- `:TSUpdate` command
- Easy `ensure_installed` config

Options:

1. **Keep nvim-treesitter** - Convenient parser management
2. **Native treesitter** - Manual parser installation via `:edit` + compile, or pre-install parsers

The plugin is lightweight. Keep it for convenience?

**Answer:** Keep `nvim-treesitter` - the convenience of auto-install and `:TSUpdate` outweighs the minimal overhead.
Native route would require manual compilation for non-bundled parsers (latex, regex).

---

## Q9: UI Components

**Question:** You have several UI plugins:

1. **lualine.nvim** - Status line with custom Prism theme, icons, mode indicators
2. **which-key.nvim** - Shows keybinding hints on `<leader>?`
3. **noice.nvim** - Enhanced UI for messages, cmdline, popups

Options for each:

**Status line:**
- Keep lualine (feature-rich)
- Use `mini.statusline` (lighter)
- Native `statusline` option (manual, basic)

**Which-key:**
- Keep which-key (no native alternative)
- Drop it (rely on memory / `:map` command)

**Noice:**
- Keep noice (fancy UI)
- Drop it (use native messages)

Which do you want to keep/drop?

**Answer:**

- **lualine.nvim** - Keep (mini.statusline can't match the Prism theme, icons, separators without significant work)
- **which-key.nvim** - Drop (rely on memory)
- **noice.nvim** - Keep

---

## Q10: Colorscheme

**Question:** You have custom colorschemes in `config/vim/colors/` (prism.lua, color-wall.lua, enterprise-desert.lua).
These are native Lua colorschemes - no plugin needed.

You also have theme plugins: catppuccin, rosepine, prism (plugin version).

For the barebones config, do you want to:

1. **Copy your custom colorschemes** to `config/bim/colors/` (native, no plugins)
2. **Keep theme plugins** for variety
3. **Both** - custom themes + plugins

**Answer:** Copy custom colorschemes to `config/bim/colors/` - native, no theme plugins needed.

---

## Q11: Remaining Plugins

**Question:** Here are the remaining plugins to decide on:

1. **Comment.nvim** - Toggle comments with `<leader>/`
   - Native alternative: Neovim 0.10+ has built-in `gc` commenting (via treesitter)

2. **nvim-dap + dap-ui + dap-python + vscode-js-debug** - Debugging
   - No native alternative - keep or drop?

3. **mini.bufremove** - Delete buffers gracefully (`<leader>bd`)
   - Native: `:bdelete` works but less graceful with unsaved changes

4. **mini.pairs** - Auto-close brackets/quotes
   - Native: None, but simple to live without

5. **toggleterm.nvim** - Terminal toggle (`<leader>t`) + lazygit (`<leader>gg`)
   - Native: `:terminal` exists but no toggle behavior

6. **smart-splits.nvim** - Navigate splits with `<C-h/j/k/l>`, integrates with tmux
   - Native: `<C-w>h/j/k/l` works but no tmux integration

Which do you want to keep/drop/replace?

**Answer:**

1. **Comment.nvim** - Drop, use native `gc` but map `<leader>/` to same functionality
2. **nvim-dap** - Drop (all debugging plugins)
3. **mini.bufremove** - Keep
4. **mini.pairs** - Keep
5. **toggleterm.nvim** - Keep
6. **smart-splits.nvim** - Keep

---

## Q12: LSP Servers

**Question:** Your current setup uses Mason for LSP server installation. You have:

- bashls, lua_ls, pyright, gopls enabled
- ts_ls (TypeScript) configured separately
- biome for formatting

Your `config/bim/` already uses native `vim.lsp.enable()` with lua_ls and ts_ls.

Options:

1. **Keep Mason** - Convenient auto-install of LSP servers
2. **Manual installation** - Install servers via brew/npm/pip, configure with native `vim.lsp.config()`

Which LSP servers do you actually need, and do you want Mason or manual installation?

**Answer:** Manual installation - drop Mason. Install servers via brew/npm/pip and configure with native
`vim.lsp.config()`. Need to maintain same functionality including:

- bashls
- lua_ls
- pyright
- gopls
- ts_ls
- biome (formatting)

---

## Q13: Additional Plugins Found

**Question:** I found more plugins we haven't discussed:

**Formatting/Linting:**
- **none-ls.nvim** + mason-null-ls - Formatters: biome, stylua, black, gofmt, beautysh, markdownlint
- **typescript-tools.nvim** - TypeScript enhancements

**Markdown/Docs:**
- **render-markdown.nvim** - Pretty markdown rendering
- **image.nvim** - Image display in terminal
- **obsidian.nvim** - Obsidian integration (`<leader>ot`, `<leader>oc`)
- **vim-latex** - LaTeX support

**Utilities:**
- **overseer.nvim** - Task runner
- **nvim-silicon** - Code screenshots
- **jwtools.nvim** - Your personal plugin (`<leader>jf`)
- **nvim-colorizer.lua** - Color highlighting
- **nvim-web-devicons** - File icons (dependency for lualine, etc.)

Which do you want to keep/drop?

**Answer:**

**Formatting/Linting:**
- **none-ls.nvim** - Drop, migrate to native:
  - biome → LSP server
  - stylua, black, beautysh → autocommands with `vim.fn.system()`
  - gofmt/goimports → gopls handles natively
  - markdownlint → LSP mode
- **typescript-tools.nvim** - Drop, use native ts_ls + autocommand for organize imports on save

**Markdown/Docs:**
- **render-markdown.nvim** - Keep
- **image.nvim** - Keep
- **obsidian.nvim** - Drop
- **vim-latex** - Keep

**Utilities:**
- **overseer.nvim** - Drop
- **nvim-silicon** - Drop
- **jwtools.nvim** - Keep
- **nvim-colorizer.lua** - Keep (no native alternative)
- **nvim-web-devicons** - Replace with `mini.icons` (supports custom overrides)

---

## Q14: Requirements Complete?

**Question:** I believe we've covered all plugins. Here's the summary of decisions:

**Keep (plugins):**
- fzf-lua (Telescope replacement)
- copilot.vim
- gitsigns.nvim
- nvim-treesitter
- lualine.nvim
- noice.nvim
- mini.files
- mini.bufremove
- mini.pairs
- mini.icons
- toggleterm.nvim
- smart-splits.nvim
- render-markdown.nvim
- image.nvim
- vim-latex
- nvim-colorizer.lua
- jwtools.nvim

**Native replacements:**
- Native `vim.lsp.enable()` + `vim.lsp.config()` (drop nvim-lspconfig, Mason)
- Native `vim.lsp.completion` (drop blink.cmp)
- Native `gc` commenting (drop Comment.nvim)
- Native formatters via LSP + autocommands (drop none-ls)
- Native colorschemes from `colors/` directory (drop theme plugins)

**Drop entirely:**
- CopilotChat.nvim
- nvim-dap (all debugging)
- which-key.nvim
- obsidian.nvim
- overseer.nvim
- nvim-silicon
- typescript-tools.nvim
- catppuccin, rosepine, prism (theme plugins)
- snacks.nvim

Does this look complete? Any adjustments?

**Answer:** Confirmed - requirements complete!

---

## Research Completed

The following research documents have been created in `research/`:

1. **native-lsp.md** - Native `vim.lsp.config()` and `vim.lsp.enable()` patterns, LspAttach autocmds, built-in keymaps
2. **native-completion.md** - `vim.lsp.completion.enable()`, custom keymaps for Enter/Arrow navigation, Copilot
   integration
3. **fzf-lua.md** - Configuration to match Telescope experience, keybinding migration, LSP integration
4. **native-formatters.md** - Biome LSP, autocommand-based formatters (stylua, black, beautysh), organize imports
5. **native-commenting.md** - Built-in `gc` operator, mapping `<leader>/` to native commenting
6. **mini-nvim.md** - mini.files, mini.icons, mini.bufremove, mini.pairs configuration

---

## Q15: Completion Keybinding Clarification

**Question:** Native completion uses `<C-y>` to accept, but you also want `<C-Y>` for Copilot. Options:

1. Use `<CR>` for LSP completion, `<C-Y>` for Copilot (keeps them separate)
2. Use `<C-y>` for both and let context determine behavior

**Answer:** Option 1 - Use `<CR>` for LSP completion accept, `<C-Y>` for Copilot full accept. Keeps them separate.
