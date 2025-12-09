# Neovim Dotfiles Configuration - Codebase Information

## Project Overview

**Repository**: Neovim configuration dotfiles  
**Location**: `/Users/acruz/Library/CloudStorage/Dropbox/Personal/dotfiles/config/vim`  
**Configuration Type**: Modular Lua with Lazy.nvim plugin manager  
**Total Files**: 45+ Lua files, 2 JSON files, multiple configuration files  
**Total Lines of Code**: 1,691+ lines of Lua  
**Primary Language**: Lua  
**Supported Languages**: Python, JavaScript/TypeScript, Bash, Lua, Markdown, LaTeX

## Project Statistics

| Metric | Value |
|--------|-------|
| Lua Source Files | 45+ |
| Configuration Files | 4 (options, keymaps, autocmds, utils) |
| Plugin Modules | 38 active plugins |
| Plugin Categories | 5 major categories |
| Entry Points | 1 primary (init.lua) |
| Plugin Manager | Lazy.nvim (48 managed plugins) |
| Lock File | lazy-lock.json |
| Git Status | Full git history tracked |

## Repository Structure

```
vim/
├── .git/                    # Version control
├── .gitattributes          # Git attributes
├── .gitignore              # Git ignore rules
├── init.lua                # Main entry point (bootstrap + config loading)
├── lazy-lock.json          # Lazy.nvim plugin manager lock file
├── README.md               # Project documentation
├── lua/
│   ├── options.lua         # Neovim editor options
│   ├── keymaps.lua         # Key bindings and mappings
│   ├── autocmds.lua        # Autocommands
│   ├── utils.lua           # Utility functions
│   └── plugins/            # Plugin configurations (38 files)
│       ├── ai/             # AI assistants (Copilot, Avante, SuperMaven)
│       ├── ui/             # UI themes and visual enhancements
│       ├── lsp/            # Language server configuration
│       ├── tools/          # Productivity tools
│       └── features/       # Additional features
├── screenshots/            # Demo screenshots
├── spell/                  # Spell checking dictionaries
└── .sop/                   # SOP documentation (generated)
```

## Technology Stack

### Plugin Manager
- **Lazy.nvim**: Modern async plugin manager with lazy loading

### UI/Visual
- **Catppuccin**: Primary color theme (Frappe, transparent background)
- **Lualine**: Status line with custom theming
- **Which-key**: Keymap explorer and help display
- **Noice**: UI for notifications and command messages
- **Colorizer**: Highlights color codes

### Language Server Protocol (LSP)
- **Mason**: LSP/formatter/linter installer
- **Mason-LSPConfig**: Auto-setup integration
- **nvim-lspconfig**: LSP configuration
- **Blink.cmp**: Completion engine with LSP support
- **None-LS**: Diagnostics and formatters

### Supported Language Servers
- **bashls**: Bash shell scripting
- **lua_ls**: Lua development
- **pyright**: Python development
- **TypeScript Tools**: JavaScript/TypeScript

### Formatters
- **Stylua**: Lua code formatting
- **Black**: Python formatting
- **Biome**: JavaScript/TypeScript/JSON
- **Beautysh**: Bash formatting
- **Ruff**: Python linting/formatting

### Syntax Highlighting
- **nvim-treesitter**: Tree-Sitter based syntax highlighting
- **Custom Tree-Sitter Parsers**: Markdown, LaTeX, regex, and auto-installed on demand

### AI Integration
- **GitHub Copilot** (Primary): Code completion and CopilotChat
- **SuperMaven**: Alternative AI completion (disabled by default)
- **Avante**: Alternative AI interface (disabled by default)

### Productivity Tools
- **Neo-tree**: File explorer with git integration
- **Telescope**: Fuzzy finder with fzf-native support
- **Gitsigns**: Git change indicators and blame
- **Overseer**: Task runner for build/test automation
- **Toggleterm**: Integrated terminal
- **Smart-splits**: Window navigation and resizing
- **Obsidian**: Note-taking integration

### Development Features
- **DAP** (Debug Adapter Protocol): Debugger with UI support
- **Silicon**: Code-to-image screenshots
- **Markdown Render**: Markdown rendering with images
- **LaTeX**: Full LaTeX support with compilation
- **Spell Check**: Multi-language spell checking

### Additional Features
- **Comment.nvim**: Toggle comments
- **Mini.nvim**: Mini utilities (buffer operations, auto-pairs)
- **Snacks.nvim**: UI improvements
- **Vim-Pencil**: Writing mode enhancements

## Configuration Organization

### Core Configuration (4 files, 289 lines)

1. **options.lua** (89 lines)
   - Line numbers and relative numbering
   - Folding with Tree-Sitter provider
   - Mouse support and clipboard sync
   - Indentation and formatting rules
   - Smooth scrolling and UI options

2. **keymaps.lua** (93 lines)
   - Buffer navigation (`<leader>bn`, `<leader>l`, `<leader>h`)
   - File operations (`<leader>w` for save)
   - Telescope/finder mappings (`<leader>ff`, `<leader>fw`, `<leader>fg`)
   - Spelling commands (`<leader>sa`, `<leader>sn`, `<leader>s?`, `<leader>s/`)
   - Comment toggle (`<leader>/`)
   - LSP rename (`<leader>ri`)
   - Note-taking (`<leader>ot` for Obsidian today)
   - Document conversion (`<leader>bp` for pandoc PDF)

3. **autocmds.lua** (99 lines)
   - Markdown syntax highlighting with custom colors
   - Virtual indentation for organized documents
   - Telescope startup behavior
   - Markdown specific settings

4. **utils.lua** (8 lines)
   - Keymap helper function

### Plugin Configuration (38 files organized in 5 categories)

1. **AI Plugins** (lua/plugins/ai/)
   - avante.lua: Claude-based AI interface
   - copilot.lua: GitHub Copilot integration
   - supermaven.lua: SuperMaven AI completion
   - init.lua: Module loader

2. **UI Plugins** (lua/plugins/ui/)
   - catppuccin.lua: Color theme configuration
   - lualine.lua: Status line setup
   - lualine/theme.lua: Custom lualine colors
   - colorizer.lua: Color highlighting
   - icons.lua: Web devicons setup
   - which-key.lua: Keymap explorer
   - typewritter.lua: Distraction-free mode
   - rosepine.lua: Alternative theme (commented out)

3. **LSP Plugins** (lua/plugins/lsp/)
   - completion.lua: Blink.cmp configuration
   - lsp-config.lua: Mason and LSP server setup
   - none-ls.lua: Formatters and diagnostics
   - treesitter.lua: Tree-Sitter configuration
   - typescript.lua: TypeScript-specific LSP
   - init.lua: Module loader

4. **Tools** (lua/plugins/tools/)
   - filemanager.lua: Neo-tree explorer
   - gitsigns.lua: Git indicators
   - telescope.lua: Fuzzy finder
   - telescope/multigrep.lua: Multi-type search
   - obsidian.lua: Note-taking integration
   - overseer.lua: Task automation
   - toggleterm.lua: Terminal integration
   - smart-splits.lua: Window management
   - pencil.lua: Writing mode
   - latex.lua: LaTeX support
   - jwtools.lua: Custom utilities

5. **Features** (lua/plugins/features/)
   - comment.lua: Comment toggling
   - dap.lua: Debugging support
   - markdown.lua: Markdown rendering
   - mini.lua: Mini utilities
   - noice.lua: UI notifications
   - silicon.lua: Code screenshots
   - snacks.lua: UI improvements
   - spell.lua: Spell checking
   - init.lua: Module loader

## Key Features

### Development Workflow
- Full LSP support with intelligent code completion
- Integrated debugging with DAP
- Git integration with change indicators and blame
- Task automation with Overseer
- Terminal integration with Toggleterm
- Fuzzy finding across files, text, and diagnostics

### Writing & Documentation
- Markdown rendering with image support
- LaTeX compilation support
- Custom markdown syntax highlighting
- Pandoc integration for PDF generation
- Obsidian integration for note-taking
- Multi-language spell checking

### Code Quality
- Multiple formatter support (Stylua, Black, Biome)
- Real-time diagnostics
- Linting with multiple backends
- Tree-Sitter based syntax analysis

### AI Integration
- GitHub Copilot with Claude 3.7 Sonnet
- CopilotChat for conversational coding
- Alternative AI options (SuperMaven, Avante)

### Visual Polish
- Transparent Catppuccin theme
- Custom highlighting for markdown markup
- Icon support for file types
- Status line with modular components
- Emoji-based diagnostic signs

## Configuration Entry Points

1. **init.lua** - Main entry point
   - Lazy.nvim bootstrap
   - Leader key setup (spacebar)
   - Plugin directory loading
   
2. **lua/plugins/init.lua** - Plugin loader
   - Auto-loads all plugin configuration files
   
3. **lua/plugins/*/init.lua** - Category loaders
   - Each category has an init.lua that loads all plugins in that category

## External Dependencies

### Required Tools
- **Git**: For version control and gitsigns
- **ripgrep (rg)**: For grep operations
- **make**: For building telescope-fzf-native
- **Node.js**: For various language servers
- **Python 3**: For Python LSP and formatters

### Optional Tools
- **LaTeX distribution**: For LaTeX compilation
- **Pandoc**: For document conversion
- **Alacritty**: Recommended terminal with FiraCode Nerd Font

## Development Patterns

### Modular Organization
- Each plugin category in its own directory
- Each plugin in its own file
- Category init.lua files for module loading
- Clear separation of concerns

### Configuration Style
- Lua-based configuration (no vim script)
- Lazy loading for most plugins
- Conditional loading based on file type
- Custom helper functions in utils.lua

### Key Binding Conventions
- Spacebar as leader key
- `<leader>` prefix for most custom bindings
- Two-character mnemonics where possible (e.g., `<leader>ff` for find files)
- Insert mode `jj` for escape key

## File Statistics

| Category | File Count | Lines of Code |
|----------|-----------|---------------|
| Core Configuration | 4 | 289 |
| AI Plugins | 4 | ~150 |
| UI Plugins | 8 | ~500 |
| LSP Plugins | 6 | ~400 |
| Tools | 11 | ~600 |
| Features | 9 | ~400 |
| Init/Entry Points | 5 | ~100 |
| **Total** | **47** | **1,691+** |

## Plugin Manager Details

**Lazy.nvim** configuration:
- 48 total managed plugins
- Lock file: `lazy-lock.json`
- Plugins pinned to specific commits
- Lazy loading for most plugins
- Some plugins eagerly loaded (priority = 100)

## Maintenance Notes

- Configuration follows Lua best practices
- Modular structure enables easy plugin addition/removal
- Each plugin has its own configuration file
- Custom keybindings centralized in keymaps.lua
- Options and autocmds separate from plugin configuration
- Version control via git with full history maintained
