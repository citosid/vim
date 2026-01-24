# Neovim Native Migration - Implementation Plan

## TDD Workflow

**See `tests/TDD-WORKFLOW.md` for detailed testing methodology.**

Each step follows the TDD cycle:
1. **RED** - Write failing tests
2. **GREEN** - Implement to pass tests
3. **REFACTOR** - Clean up code
4. **MANUAL TEST** - ⚠️ Human verification (BLOCKING)
5. **UPDATE STATUS** - Mark complete (after approval)
6. **COMMIT** - Commit changes

## Test Coverage

| Step | Unit Tests | Manual | Status |
|------|------------|--------|--------|
| 1 | 0 | ✅ | Complete |
| 2 | 16 | ✅ | Complete |
| 3 | 6 | ✅ | Complete |
| 4 | 12 | ✅ | Complete |
| 5 | 6 | ✅ | Complete |
| 6 | 10 | ✅ | Complete |
| 7 | 6 | ✅ | Complete |
| 8 | 6 | ✅ | Complete |
| 9 | 10 | ✅ | Complete |
| 10 | 4 | ✅ | Complete |
| 11 | 5 | ✅ | Complete |
| 12 | 6 | ✅ | Complete |
| 13 | 8 | ✅ | Complete |
| 14 | 7 | ✅ | Complete |
| 15 | 3 | ✅ | Complete |
| 16 | 6 | ✅ | Complete |

---

## Implementation Checklist

- [x] Step 1: Copy colorschemes and verify base config
- [x] Step 2: Set up plugin declarations with vim.pack.add()
- [x] Step 3: Configure mini.icons
- [x] Step 4: Configure mini.files (file explorer)
- [x] Step 5: Configure mini.bufremove and mini.pairs
- [x] Step 6: Set up native LSP configuration
- [x] Step 7: Configure native completion
- [x] Step 8: Set up fzf-lua (fuzzy finder)
- [x] Step 9: Configure formatters (LSP + autocommands)
- [x] Step 10: Set up native commenting
- [x] Step 11: Configure Copilot
- [x] Step 12: Configure gitsigns
- [x] Step 13: Configure toggleterm and smart-splits
- [x] Step 14: Configure UI (lualine, noice, treesitter)
- [x] Step 15: Configure remaining plugins (markdown, colorizer, jwtools)
- [x] Step 16: Final keymaps consolidation and testing

---

## Step 1: Copy Colorschemes and Verify Base Config

**Objective:** Establish the foundation by copying colorschemes and verifying the existing base configuration works.

**Implementation Guidance:**

1. Copy colorschemes to `colors/`
2. Add colorscheme loading to init.lua
3. Verify `bim` command launches Neovim with correct NVIM_APPNAME
4. Test that options.lua and basic keymaps work

**Test Requirements:**

- Run `bim` and verify it opens without errors
- Verify colorscheme loads with `:colorscheme prism`
- Check options are applied (`:set number?` should show `number`)

**Integration:**

- This establishes the base that all subsequent steps build upon

**Demo:**

- Open `bim`, see the Prism colorscheme applied, line numbers visible, basic editing works

---

## Step 2: Set Up Plugin Declarations

**Objective:** Configure vim.pack.add() with all required plugins.

**Implementation Guidance:**

1. Expand `lua/plugins.lua` with all plugin declarations
2. Run `:packlock` to generate lock file
3. Verify plugins are downloaded to correct location

**Test Requirements:**

- Run `bim` and check `:scriptnames` shows plugins loaded
- Verify `nvim-pack-lock.json` is updated

**Integration:**

- Plugins are now available for configuration in subsequent steps

**Demo:**

- Open `bim`, run `:lua print(vim.inspect(vim.pack))` to see loaded plugins

---

## Step 3: Configure mini.icons

**Objective:** Set up icon provider with custom icons for toml and pem files.

**Implementation Guidance:**

1. Create mini.icons setup in plugins.lua or separate file
2. Add custom icons for toml and pem extensions
3. Call `MiniIcons.mock_nvim_web_devicons()` for compatibility

**Test Requirements:**

- Run `:lua print(MiniIcons.get('extension', 'lua'))` - should return icon
- Verify custom toml/pem icons work

**Integration:**

- Icons will be used by fzf-lua, mini.files, and lualine

**Demo:**

- Open a directory with various file types, see icons displayed correctly

---

## Step 4: Configure mini.files (File Explorer)

**Objective:** Set up file explorer with custom keybindings.

**Implementation Guidance:**

1. Configure mini.files with user's custom mappings:
   - `permanent_delete = false`
   - `<CR>` → go_in_plus
   - Swap h/H and l/L
   - `,` → reset, `.` → reveal_cwd, `s` → synchronize
2. Add `<leader>e` keymap to open explorer

**Test Requirements:**

- `<leader>e` opens mini.files
- `<CR>` on file opens it and closes explorer
- `h` goes to parent and closes, `H` just goes to parent
- File operations work (create, delete, rename)

**Integration:**

- Replaces neo-tree functionality

**Demo:**

- Press `<leader>e`, navigate directories, open a file with `<CR>`, explorer closes

---

## Step 5: Configure mini.bufremove and mini.pairs

**Objective:** Set up buffer deletion and auto-pairs.

**Implementation Guidance:**

1. Configure mini.bufremove with confirmation for modified buffers
2. Configure mini.pairs with toggle keymap
3. Add keymaps: `<leader>bd`, `<leader>bD`, `<leader>up`

**Test Requirements:**

- `<leader>bd` on modified buffer shows confirmation
- `<leader>bD` force-deletes buffer
- `<leader>up` toggles auto-pairs
- Typing `(` auto-inserts `)`

**Integration:**

- Buffer management and editing enhancements

**Demo:**

- Edit a file, modify it, press `<leader>bd`, see confirmation dialog

---

## Step 6: Set Up Native LSP Configuration

**Objective:** Configure LSP servers using native vim.lsp.config() and vim.lsp.enable().

**Implementation Guidance:**

1. Create `lua/lsp.lua` with global defaults and LspAttach autocmd
2. Create LSP config files in `lsp/` directory:
   - `ts_ls.lua`, `bashls.lua`, `pyright.lua`, `gopls.lua`, `biome.lua`
3. Enable all servers with vim.lsp.enable()
4. Disable ts_ls formatting (use biome instead)

**Test Requirements:**

- Open a Lua file, `:checkhealth vim.lsp` shows lua_ls attached
- Open a TypeScript file, ts_ls and biome attach
- Hover with `K` shows documentation
- `gd` goes to definition

**Integration:**

- LSP provides completion source, diagnostics, and code actions

**Demo:**

- Open `init.lua`, hover over a function with `K`, see documentation popup

---

## Step 7: Configure Native Completion

**Objective:** Set up native LSP completion with custom keybindings.

**Implementation Guidance:**

1. Create `lua/completion.lua`
2. Enable completion in LspAttach with `vim.lsp.completion.enable()`
3. Configure keymaps:
   - `<CR>` accepts completion
   - `<Up>/<Down>` navigate menu
   - `<Tab>` does nothing special

**Test Requirements:**

- Type in a Lua file, completion menu appears
- `<Down>` moves to next item
- `<CR>` accepts selected item
- `<Tab>` inserts tab character (doesn't interact with menu)

**Integration:**

- Works with LSP servers configured in Step 6

**Demo:**

- Open `init.lua`, type `vim.`, see completion menu, navigate with arrows, accept with Enter

---

## Step 8: Set Up fzf-lua (Fuzzy Finder)

**Objective:** Configure fzf-lua to match Telescope keybindings.

**Implementation Guidance:**

1. Configure fzf-lua with ivy-like theme (bottom panel)
2. Set up keymaps matching current Telescope bindings:
   - `<leader>ff` → files
   - `<leader><space>` → buffers
   - `<leader>fw` → live_grep
   - `<leader>fg` → grep
   - `<leader>fd` → diagnostics
   - `<leader>fs` → document_symbols
   - `<leader>f2` → implementations

**Test Requirements:**

- `<leader>ff` opens file picker at bottom
- `<leader>fw` opens live grep
- `<leader>fd` shows diagnostics
- Navigation with `<C-j>/<C-k>` works

**Integration:**

- Uses mini.icons for file icons
- LSP integration for diagnostics/symbols

**Demo:**

- Press `<leader>ff`, type to filter files, select with Enter, file opens

---

## Step 9: Configure Formatters

**Objective:** Set up format-on-save using LSP and autocommands.

**Implementation Guidance:**

1. Create `lua/formatters.lua`
2. LSP formatters (biome, gopls) handled in LspAttach
3. Add autocommands for external formatters:
   - Lua → stylua
   - Python → black
   - Bash → beautysh
4. Add TypeScript organize imports on save

**Test Requirements:**

- Save a Lua file, stylua formats it
- Save a TypeScript file, biome formats and imports organized
- Save a Python file, black formats it

**Integration:**

- Works with LSP from Step 6

**Demo:**

- Open a messy Lua file, save it, see it formatted automatically

---

## Step 10: Set Up Native Commenting

**Objective:** Map `<leader>/` to native gc commenting.

**Implementation Guidance:**

1. Add keymaps in keymaps.lua:
   - Normal: `<leader>/` → `gcc`
   - Visual: `<leader>/` → `gc`

**Test Requirements:**

- `<leader>/` on a line comments it
- `<leader>/` again uncomments it
- Visual select + `<leader>/` comments selection

**Integration:**

- Uses treesitter for context-aware commenting

**Demo:**

- Place cursor on a line, press `<leader>/`, line is commented

---

## Step 11: Configure Copilot

**Objective:** Set up GitHub Copilot with custom keybindings.

**Implementation Guidance:**

1. Configure copilot.vim
2. Set keymaps:
   - `<C-Y>` → accept full suggestion
   - `<C-O>` → accept word
3. Disable tab mapping (`copilot_no_tab_map = true`)
4. Set model to claude-3.7-sonnet-thought

**Test Requirements:**

- Copilot suggestions appear as ghost text
- `<C-Y>` accepts full suggestion
- `<C-O>` accepts next word
- `<Tab>` does NOT accept suggestion

**Integration:**

- Independent from LSP completion (different keybindings)

**Demo:**

- Start typing a function, see Copilot suggestion, accept with `<C-Y>`

---

## Step 12: Configure gitsigns

**Objective:** Set up git signs in gutter with blame.

**Implementation Guidance:**

1. Configure gitsigns.nvim
2. Enable current_line_blame
3. Add `<leader>gB` for full blame view
4. Set custom highlight colors

**Test Requirements:**

- Git changes show in sign column
- Inline blame appears after delay
- `<leader>gB` opens blame view

**Integration:**

- Works in any git repository

**Demo:**

- Open a file in a git repo, see change indicators in gutter, inline blame on current line

---

## Step 13: Configure toggleterm and smart-splits

**Objective:** Set up terminal toggle and split navigation.

**Implementation Guidance:**

1. Configure toggleterm with float direction
2. Add keymaps:
   - `<leader>t` → toggle terminal
   - `<leader>gg` → lazygit
   - `<C-j><C-j>` in terminal → close
3. Configure smart-splits for `<C-h/j/k/l>` navigation

**Test Requirements:**

- `<leader>t` opens floating terminal
- `<leader>gg` opens lazygit
- `<C-h/j/k/l>` navigates between splits
- Works with tmux if running inside tmux

**Integration:**

- Terminal for running commands
- Split navigation for multi-pane workflow

**Demo:**

- Press `<leader>t`, terminal opens, type commands, press `<C-j><C-j>` to close

---

## Step 14: Configure UI (lualine, noice, treesitter)

**Objective:** Set up status line, notifications, and syntax highlighting.

**Implementation Guidance:**

1. Configure lualine with Prism theme (copy from config/vim/)
2. Configure noice for enhanced messages
3. Configure nvim-treesitter with auto_install

**Test Requirements:**

- Status line shows mode, file, diagnostics
- Command line appears in floating window (noice)
- Syntax highlighting works for various languages

**Integration:**

- Uses mini.icons for file type icons in lualine
- Treesitter provides commenting context

**Demo:**

- Open various file types, see syntax highlighting, status line updates with mode changes

---

## Step 15: Configure Remaining Plugins

**Objective:** Set up markdown rendering, colorizer, and jwtools.

**Implementation Guidance:**

1. Configure render-markdown.nvim for markdown files
2. Configure image.nvim for image preview
3. Configure nvim-colorizer for color highlighting
4. Configure jwtools.nvim with `<leader>jf` keymap

**Test Requirements:**

- Open markdown file, see rendered headings/lists
- Color codes in CSS/config files are highlighted
- `<leader>jf` triggers JWToolsFetchScripture

**Integration:**

- Markdown rendering in preview and editing

**Demo:**

- Open a markdown file, see formatted rendering with checkboxes and headers

---

## Step 16: Final Keymaps Consolidation and Testing

**Objective:** Consolidate all keymaps and perform comprehensive testing.

**Implementation Guidance:**

1. Review all keymaps in keymaps.lua
2. Ensure no conflicts between mappings
3. Add remaining keymaps from config/vim/ that weren't migrated
4. Create a keymaps reference comment block

**Test Requirements:**

- All keymaps from requirements work
- No keymap conflicts
- `:checkhealth` passes for all components

**Integration:**

- Final integration of all components

**Demo:**

- Complete workflow: open file with `<leader>ff`, edit with completion, comment with `<leader>/`, format on save,
  commit with `<leader>gg`
