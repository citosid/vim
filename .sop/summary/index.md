# Neovim Dotfiles Documentation Index

**Last Updated**: December 9, 2025

## Quick Navigation

This index provides a comprehensive guide to the Neovim configuration documentation. Use this file to quickly locate information relevant to your task.

### For AI Assistants

This documentation ecosystem is optimized for AI assistant context windows. Start here to understand the structure, then reference specific files based on your needs.

**Key insight**: Read this index first, then consult specific documentation files based on the metadata below. The index contains sufficient breadcrumbs to navigate the entire knowledge base efficiently.

---

## Documentation Files Overview

### 📋 **index.md** (This File)
- **Purpose**: Navigation hub for all documentation
- **Audience**: AI assistants, developers
- **Use When**: Looking for specific information or understanding overall structure
- **Key Sections**: File guide, metadata, quick-reference tables

### 🏗️ **architecture.md** (2,847 lines)
- **Purpose**: System architecture, design patterns, initialization flows
- **Key Topics**:
  - System architecture overview with Mermaid diagrams
  - Plugin loading workflows
  - Module dependency resolution
  - Layered configuration design
  - Extension points for customization
- **Use When**: 
  - Understanding how the system initializes
  - Adding new plugins or modules
  - Refactoring plugin architecture
  - Analyzing startup performance
- **Audience**: Architecture decisions, system design, performance optimization
- **Contains**: 8+ Mermaid diagrams showing flows and relationships

### 🔧 **components.md** (3,142 lines)
- **Purpose**: Detailed component specifications and responsibilities
- **Key Topics**:
  - Core bootstrap (init.lua)
  - Editor options (options.lua)
  - Key bindings (keymaps.lua)
  - Autocommands (autocmds.lua)
  - 11 major plugin component categories
  - Detailed component specs with code patterns
- **Use When**:
  - Understanding what a specific plugin does
  - Modifying component behavior
  - Adding new components
  - Understanding component responsibilities
- **Audience**: Feature development, plugin modification, troubleshooting
- **Component Categories**:
  1. Core Bootstrap (1 file)
  2. AI Plugins (4 files)
  3. UI Plugins (8 files)
  4. Development (6 files)
  5. Tools (11 files)
  6. Writing (4 files)
  7. Features (9 files)

### 🔌 **interfaces.md** (2,615 lines)
- **Purpose**: User interfaces, APIs, keybindings, integration points
- **Key Topics**:
  - Complete keymap reference table (20+ bindings)
  - LSP interface and configuration
  - Completion engine API
  - GitHub Copilot AI interface
  - File explorer operations
  - Finder/Telescope usage
  - Git integration commands
  - Spell check commands
  - Debug interface
  - Extension/customization interfaces
- **Use When**:
  - Learning available keybindings
  - Using LSP features
  - Interfacing with AI tools
  - Understanding APIs and integration points
  - Adding or modifying keybindings
- **Audience**: End users, plugin developers, API consumers
- **Contains**: 15+ operation tables with modes and descriptions

### 📊 **data_models.md** (2,489 lines)
- **Purpose**: Data structures, state models, configuration formats
- **Key Topics**:
  - Configuration data structures
  - Plugin specification model
  - Keymap entry model
  - LSP configuration model
  - Theme configuration model
  - Completion engine state
  - Git state model
  - Spell check state
  - Debugger state
  - LSP state
  - Buffer state
  - Status line state
- **Use When**:
  - Understanding data flow
  - Creating new plugins
  - Modifying state management
  - Debugging state issues
- **Audience**: Plugin developers, state management specialists
- **Contains**: 20+ state model diagrams and examples

### 🔄 **workflows.md** (2,756 lines)
- **Purpose**: User workflows, interaction patterns, process flows
- **Key Topics**:
  - 6 main user workflows with diagrams
  - Development workflows
  - Plugin loading workflows
  - LSP initialization workflows
  - Code formatting and linting workflows
  - Search and navigation workflows
  - Writing mode workflows
  - Error handling workflows
  - Extension workflows
- **Use When**:
  - Understanding how users interact with the system
  - Optimizing user experience
  - Debugging workflow issues
  - Adding new workflows
- **Audience**: UX improvement, workflow optimization, feature addition
- **Contains**: 12+ Mermaid sequence and state diagrams

### 📦 **dependencies.md** (2,891 lines)
- **Purpose**: External dependencies, tools, requirements, compatibility
- **Key Topics**:
  - System tool requirements (Git, Python, Node.js, ripgrep)
  - Plugin manager dependencies (Lazy.nvim)
  - Core plugin dependencies (plenary, nui, web-devicons)
  - Language server dependencies
  - Formatter and linter dependencies
  - External service dependencies (GitHub Copilot)
  - Optional feature dependencies (LaTeX, Pandoc, Silicon)
  - Dependency graphs and compatibility matrix
  - Troubleshooting missing dependencies
- **Use When**:
  - Setting up development environment
  - Installing missing tools
  - Troubleshooting dependency issues
  - Understanding system requirements
  - Checking compatibility
- **Audience**: DevOps, system administrators, setup/troubleshooting
- **Contains**: Comprehensive dependency graphs and installation guides

### 📝 **codebase_info.md** (1,920 lines)
- **Purpose**: Project overview, statistics, file organization
- **Key Topics**:
  - Project statistics (45+ Lua files, 1,691 lines)
  - Repository structure
  - Technology stack overview
  - Configuration organization
  - Plugin manager details
  - Maintenance notes
  - Configuration entry points
  - Key features summary
- **Use When**:
  - Getting project overview
  - Understanding codebase scale
  - Learning project statistics
  - Understanding technology choices
- **Audience**: Project managers, new contributors, overview
- **Contains**: Comprehensive project metadata and statistics

---

## Quick Reference Tables

### Development Keybindings

| Binding | Mode | Action | Context |
|---------|------|--------|---------|
| `<leader>ff` | n | Find files | Fuzzy finder |
| `<leader>fw` | n | Live grep | Text search |
| `<leader>fg` | n | Multi-grep | Advanced search |
| `<leader>fd` | n | Find diagnostics | LSP diagnostics |
| `<leader>p` | n | Toggle explorer | File browser |
| `<leader>ri` | n,x | Rename | LSP refactoring |
| `<leader>w` | n | Save file | File operations |

See **interfaces.md** for complete keybinding reference.

### Plugin Categories

| Category | Files | Purpose | Location |
|----------|-------|---------|----------|
| AI | 4 | Copilot, Claude, SuperMaven | lua/plugins/ai/ |
| UI | 8 | Themes, Status line, Icons | lua/plugins/ui/ |
| LSP | 6 | Language servers, Completion | lua/plugins/lsp/ |
| Tools | 11 | Finder, Explorer, Terminal | lua/plugins/tools/ |
| Features | 9 | Debug, Markdown, Comments | lua/plugins/features/ |

See **components.md** for detailed specifications.

### Language Server Support

| Language | Server | LSP | Formatter | Linter |
|----------|--------|-----|-----------|--------|
| Python | pyright | ✓ | black | pylint |
| JavaScript/TS | ts-tools | ✓ | biome | biome |
| Bash | bashls | ✓ | beautysh | - |
| Lua | lua_ls | ✓ | stylua | - |

See **dependencies.md** for installation details.

### System Requirements

| Tool | Version | Required | Purpose |
|------|---------|----------|---------|
| Git | 2.0+ | ✓ | Version control |
| Python | 3.8+ | ✓ | LSP, formatters |
| Node.js | 14+ | ✓ | TS/JS tools |
| ripgrep | 13+ | ✓ | Fast searching |
| LaTeX | TeX Live | Optional | Document compilation |
| Pandoc | 2.0+ | Optional | Format conversion |

See **dependencies.md** for full compatibility matrix.

---

## File Statistics

| Category | Count | Details |
|----------|-------|---------|
| Total Lua Files | 45+ | 1,691+ lines of code |
| Configuration Files | 4 | options, keymaps, autocmds, utils |
| Plugin Files | 38+ | Organized in 5 categories |
| Core Module Loaders | 5 | Lazy loading via init.lua |
| External Plugins | 48 | Pinned in lazy-lock.json |
| Documentation Files | 7 | This ecosystem |

---

## Quick Search Guide

### "How do I...?"

- **Add a new keybinding?** → See **interfaces.md** > "Configuration Modification Interface"
- **Add a new plugin?** → See **architecture.md** > "Extension Points"
- **Debug an issue?** → See **workflows.md** > "Error Handling Workflows"
- **Use AI completions?** → See **interfaces.md** > "AI Completion Interface"
- **Configure LSP?** → See **components.md** > "LSP Configuration"
- **Understand the startup process?** → See **architecture.md** > "Initialization Flow"
- **Find where X is configured?** → See **components.md** for component specs
- **Understand data flow?** → See **data_models.md** for state diagrams
- **Set up the environment?** → See **dependencies.md** for requirements

### "What's the...?"

- **System architecture?** → **architecture.md**
- **Complete keymap reference?** → **interfaces.md** > "Key Binding Interface"
- **LSP configuration?** → **components.md** > "8a. LSP Configuration"
- **Plugin list?** → **codebase_info.md** > "Plugin Statistics"
- **Project structure?** → **codebase_info.md** > "Repository Structure"
- **Startup workflow?** → **architecture.md** > "Initialization Flow"
- **Data models?** → **data_models.md** > "Configuration Data Structures"
- **User workflows?** → **workflows.md** > "User Workflows"

### "Where's...?"

- **The keymap configuration?** → `lua/keymaps.lua` (referenced in **components.md**)
- **The LSP setup?** → `lua/plugins/lsp/lsp-config.lua` (referenced in **components.md**)
- **The AI configuration?** → `lua/plugins/ai/copilot.lua` (referenced in **components.md**)
- **The theme?** → `lua/plugins/ui/catppuccin.lua` (referenced in **components.md**)
- **Custom highlights?** → `lua/autocmds.lua` (referenced in **components.md**)

---

## For Different Roles

### Software Developer
1. Start with **architecture.md** to understand system organization
2. Read **components.md** for plugin details
3. Reference **interfaces.md** for keybindings and LSP
4. Consult **workflows.md** for interaction patterns
5. Use **dependencies.md** to set up environment

### AI Assistant (You!)
1. This index provides complete navigation
2. Use metadata tags above to find relevant files
3. Reference specific sections for detailed info
4. Use Mermaid diagrams in architecture.md to understand flows
5. Check data_models.md for state information

### DevOps/System Administrator
1. Review **dependencies.md** for system requirements
2. Check **codebase_info.md** for project overview
3. Reference installation guides in **dependencies.md**
4. Use troubleshooting section for common issues

### Plugin Developer
1. Start with **architecture.md** > "Extension Points"
2. Study **components.md** > "Plugin Configuration Models"
3. Review **data_models.md** > "Plugin Specification Model"
4. Check **interfaces.md** for available APIs
5. Reference **workflows.md** for integration patterns

### Writer/Markdown User
1. Check **components.md** > "Writing Components"
2. Review **workflows.md** > "Writing Mode Workflows"
3. Reference **interfaces.md** > "Spell Checking Interface"
4. See **dependencies.md** for optional LaTeX/Pandoc

---

## Key Insights

### Architecture
- **Modular Design**: 5 plugin categories + core configuration
- **Lazy Loading**: Plugins load on-demand via events
- **Plugin Manager**: Lazy.nvim with 48 managed plugins
- **Entry Point**: `init.lua` bootstraps entire system

### Configuration Patterns
- **Lua-based**: All configuration in Lua, no Vim script
- **File Organization**: Each plugin in separate file, categories in subdirectories
- **Centralized Keymaps**: All keybindings in `lua/keymaps.lua`
- **Separated Concerns**: Options, keymaps, autocmds, utilities all isolated

### Performance
- **Lazy Loading**: Most plugins load on-demand
- **Eager Loading**: Only essential plugins load at startup
- **FZF Native**: Telescope uses compiled fzf for speed
- **Tree-Sitter**: Efficient syntax parsing and folding

### AI Integration
- **Primary Tool**: GitHub Copilot with Claude 3.7 Sonnet
- **Alternative Options**: SuperMaven and Avante available
- **Integration Point**: Blink.cmp merges multiple completion sources
- **Model**: Claude 3.7 Sonnet via GitHub API

---

## Documentation Maintenance

### File Relationships
```
index.md (navigation hub)
    ├── architecture.md (system design)
    ├── components.md (detailed specs)
    ├── interfaces.md (APIs and keybindings)
    ├── data_models.md (state and structures)
    ├── workflows.md (user interactions)
    ├── dependencies.md (requirements)
    └── codebase_info.md (project overview)
```

### How to Use This Documentation

1. **For Quick Answers**: Use this index to find relevant files
2. **For Deep Dives**: Start with referenced files, follow cross-links
3. **For Code Navigation**: Use file paths in component specs (e.g., `lua/plugins/ai/copilot.lua`)
4. **For Visual Understanding**: Reference Mermaid diagrams in relevant sections
5. **For Implementation**: Check both components.md and interfaces.md

---

## Last Updated

- **Date**: December 9, 2025
- **Coverage**: Complete Neovim dotfiles configuration
- **Scope**: 45+ Lua files, 38 active plugins, 1,691+ lines of code
- **Consolidation Status**: All documentation consolidated in root AGENTS.md

---

## Next Steps

1. **For Development**: Refer to specific component in **components.md**
2. **For New Plugin**: Follow extension guide in **architecture.md**
3. **For Environment Setup**: Use installation guide in **dependencies.md**
4. **For Troubleshooting**: Check **workflows.md** > "Error Handling"
5. **For Questions**: Use Quick Search Guide above

---

**Note**: This documentation is optimized for AI assistant context windows. All files are cross-referenced and organized for easy navigation and information retrieval. Start with this index, then jump to specific files based on your needs.
