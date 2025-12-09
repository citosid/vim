# Neovim Configuration Architecture

## System Architecture Overview

```mermaid
graph TB
    subgraph "Entry Point"
        Init["init.lua<br/>Lazy.nvim Bootstrap<br/>Leader Key Setup"]
    end
    
    subgraph "Core Configuration"
        Opts["options.lua<br/>Editor Settings"]
        Keys["keymaps.lua<br/>Key Bindings"]
        Auto["autocmds.lua<br/>Autocommands"]
        Utils["utils.lua<br/>Utilities"]
    end
    
    subgraph "Plugin Categories"
        AI["AI Plugins<br/>Copilot, Avante<br/>SuperMaven"]
        UI["UI Plugins<br/>Themes, Status Line<br/>Notifications"]
        LSP["LSP Plugins<br/>Language Servers<br/>Completion"]
        Tools["Tools<br/>Finder, Explorer<br/>Git, Terminal"]
        Features["Features<br/>Debug, Markdown<br/>Comments, Spell"]
    end
    
    subgraph "Plugin Manager"
        Lazy["Lazy.nvim<br/>48 Managed Plugins<br/>lazy-lock.json"]
    end
    
    subgraph "External Services"
        GitHub["GitHub Copilot<br/>Claude 3.7"]
        LSPServers["Language Servers<br/>bashls, lua_ls<br/>pyright, ts-tools"]
        Formatters["Formatters<br/>Stylua, Black<br/>Biome, Ruff"]
    end
    
    Init --> Core
    Init --> Lazy
    Core --> |refs| Plugin
    Lazy --> |manages| Plugin
    Lazy --> |connects to| External
    
    Core[Core Configuration]:::config
    Plugin[Plugin Categories]:::plugin
    External[External Services]:::external
    
    classDef config fill:#89b4fa,stroke:#1e1e2e,stroke-width:2px
    classDef plugin fill:#a6e3a1,stroke:#1e1e2e,stroke-width:2px
    classDef external fill:#fab387,stroke:#1e1e2e,stroke-width:2px
```

## Initialization Flow

```mermaid
sequenceDiagram
    participant User
    participant init as init.lua
    participant Lazy as Lazy.nvim
    participant Core as Core Config
    participant Plugins as Plugin Modules
    participant LSP as External Services
    
    User->>init: Launch Neovim
    init->>init: Bootstrap Lazy.nvim
    init->>init: Set leader key (spacebar)
    init->>Lazy: Load plugin specs
    Lazy->>Plugins: Load plugin modules
    Plugins->>Plugins: Load category inits
    Lazy->>Core: Load options, keymaps, autocmds
    Lazy->>LSP: Connect to language servers
    init->>User: Configuration complete
```

## Configuration Layering

```mermaid
graph TB
    subgraph "Layer 1: Bootstrap"
        B1["init.lua<br/>- Lazy.nvim setup<br/>- Leader key<br/>- Plugin directory"]
    end
    
    subgraph "Layer 2: Core Settings"
        B2a["options.lua<br/>- Editor behavior<br/>- UI settings<br/>- Performance"]
        B2b["keymaps.lua<br/>- User mappings<br/>- Custom shortcuts<br/>- Leader bindings"]
        B2c["autocmds.lua<br/>- Auto behaviors<br/>- Syntax highlighting<br/>- File-specific rules"]
    end
    
    subgraph "Layer 3: Plugin Categories"
        B3a["AI Plugins<br/>Code completion"]
        B3b["UI Plugins<br/>Visual theme"]
        B3c["LSP Plugins<br/>Language tools"]
        B3d["Tools<br/>Productivity"]
        B3e["Features<br/>Extensions"]
    end
    
    subgraph "Layer 4: External Integration"
        B4a["GitHub Copilot"]
        B4b["Language Servers"]
        B4c["Formatters"]
    end
    
    B1 --> B2a
    B1 --> B2b
    B1 --> B2c
    B2a --> B3a
    B2a --> B3b
    B2a --> B3c
    B3a --> B4a
    B3c --> B4b
    B3c --> B4c
```

## Plugin Architecture

### Plugin Discovery Pattern

```mermaid
graph LR
    subgraph "Plugin Categories"
        AI["lua/plugins/ai/"]
        UI["lua/plugins/ui/"]
        LSP["lua/plugins/lsp/"]
        Tools["lua/plugins/tools/"]
        Features["lua/plugins/features/"]
    end
    
    subgraph "Module Structure"
        AI1["avante.lua"]
        AI2["copilot.lua"]
        AI3["supermaven.lua"]
        AI_Init["init.lua<br/>(loader)"]
    end
    
    subgraph "Plugin Manager"
        Lazy["Lazy.nvim<br/>Spec Loading"]
    end
    
    AI --> AI1
    AI --> AI2
    AI --> AI3
    AI --> AI_Init
    AI_Init --> |loads| AI1
    AI_Init --> |loads| AI2
    AI_Init --> |loads| AI3
    Lazy -.-> AI1
    Lazy -.-> AI2
    Lazy -.-> AI3
```

### Plugin Dependencies

```mermaid
graph TD
    subgraph "Core Dependencies"
        Plenary["plenary.nvim<br/>Lua utilities"]
        Nui["nvim-nui<br/>UI components"]
        Icons["nvim-web-devicons<br/>File icons"]
    end
    
    subgraph "LSP Stack"
        Mason["Mason<br/>Tool installer"]
        LSPConfig["nvim-lspconfig<br/>LSP setup"]
        Blink["Blink.cmp<br/>Completions"]
        TreeSitter["nvim-treesitter<br/>Syntax"]
    end
    
    subgraph "UI Stack"
        Catppuccin["Catppuccin<br/>Theme"]
        Lualine["Lualine<br/>Status line"]
        WhichKey["Which-key<br/>Keymaps"]
    end
    
    subgraph "Tools Stack"
        Telescope["Telescope<br/>Finder"]
        NeoTree["Neo-tree<br/>Explorer"]
        Gitsigns["Gitsigns<br/>Git info"]
    end
    
    Plenary --> |used by| Mason
    Plenary --> |used by| Telescope
    Nui --> |used by| WhichKey
    Icons --> Lualine
    Icons --> NeoTree
    
    Mason --> LSPConfig
    LSPConfig --> Blink
    TreeSitter --> Blink
    
    Catppuccin --> Lualine
```

## Data Flow: Code Completion Example

```mermaid
sequenceDiagram
    participant User
    participant Blink as Blink.cmp
    participant LSP as LSP Server
    participant GitHub as GitHub Copilot
    
    User->>Blink: Type character (trigger completion)
    Blink->>LSP: Request completions from language server
    Blink->>GitHub: Request AI suggestions
    LSP-->>Blink: LSP completions
    GitHub-->>Blink: AI suggestions
    Blink->>User: Display merged completion menu
    User->>Blink: Select completion
    Blink->>User: Insert selected text
```

## Directory Structure Mapping

```mermaid
graph TB
    subgraph "lua/"
        Options["options.lua<br/>89 lines"]
        Keymaps["keymaps.lua<br/>93 lines"]
        Autocmds["autocmds.lua<br/>99 lines"]
        Utils["utils.lua<br/>8 lines"]
        Plugins["plugins/<br/>38 files"]
    end
    
    subgraph "lua/plugins/"
        AI["ai/<br/>4 files"]
        UI["ui/<br/>8 files"]
        LSP["lsp/<br/>6 files"]
        Tools["tools/<br/>11 files"]
        Features["features/<br/>9 files"]
    end
    
    subgraph "lua/plugins/ai/"
        Avante["avante.lua"]
        Copilot["copilot.lua"]
        SuperMaven["supermaven.lua"]
        AI_Init["init.lua"]
    end
    
    subgraph "External"
        Root["Root Directory<br/>init.lua<br/>lazy-lock.json<br/>README.md"]
    end
    
    Root --> Options
    Root --> Keymaps
    Root --> Autocmds
    Root --> Utils
    Root --> Plugins
    Plugins --> AI
    Plugins --> UI
    Plugins --> LSP
    Plugins --> Tools
    Plugins --> Features
    AI --> Avante
    AI --> Copilot
    AI --> SuperMaven
    AI --> AI_Init
```

## Configuration Loading Sequence

1. **Neovim Start**
   - User launches `nvim` command
   
2. **init.lua Execution**
   - Lazy.nvim bootstrap code
   - Leader key set to spacebar
   - Plugin spec directory specified
   
3. **Lazy.nvim Plugin Loading**
   - Reads all `lua/plugins/*/init.lua` files
   - Each init.lua returns specs for its category
   - Lazy loads plugins based on events/commands
   
4. **Core Configuration Loading**
   - `lua/options.lua` applied
   - `lua/keymaps.lua` mapped
   - `lua/autocmds.lua` registered
   
5. **Plugin Initialization**
   - Each plugin's setup() function called
   - External services connected (LSP, GitHub Copilot)
   - Lazy loading triggers when needed
   
6. **Ready for User**
   - Configuration complete
   - All keybindings available
   - LSP servers connected

## Module Loading Pattern

Each plugin category follows this pattern:

```
lua/plugins/[category]/
├── init.lua          # Loads all plugins in category
├── plugin1.lua       # Individual plugin specs
├── plugin2.lua
└── ...

-- init.lua example:
return {
  require('plugins.[category].plugin1'),
  require('plugins.[category].plugin2'),
  -- ...
}
```

## Configuration Isolation

```mermaid
graph TB
    subgraph "Isolated Concerns"
        Opts["Editor Options<br/>options.lua<br/>No plugins"]
        Keys["Key Mappings<br/>keymaps.lua<br/>Mostly core"]
        Auto["Auto Commands<br/>autocmds.lua<br/>Markdown specific"]
    end
    
    subgraph "Plugin Isolation"
        AIGroup["AI Plugins<br/>Isolated configs<br/>No interference"]
        UIGroup["UI Plugins<br/>Independent themes<br/>No conflicts"]
        LSPGroup["LSP Plugins<br/>Separate setup<br/>No coupling"]
    end
    
    Opts -.-> |independent of| AIGroup
    Keys -.-> |independent of| UIGroup
    Auto -.-> |independent of| LSPGroup
```

## Extension Points

Configuration can be extended by:

1. **Adding new plugin files**
   - Create `lua/plugins/[category]/[plugin].lua`
   - Add return statement with plugin spec
   - Category init.lua auto-loads it

2. **Adding new keybindings**
   - Edit `lua/keymaps.lua`
   - Follow existing conventions

3. **Adding new options**
   - Edit `lua/options.lua`
   - Apply Neovim option settings

4. **Adding new autocommands**
   - Edit `lua/autocmds.lua`
   - Register auto behaviors

5. **Creating new category**
   - Create `lua/plugins/[newcategory]/` directory
   - Create `init.lua` with plugin specs
   - Create individual plugin files

## Performance Architecture

```mermaid
graph TD
    subgraph "Startup Optimization"
        B1["Lazy Loading<br/>Plugins load on demand"]
        B2["Event-based<br/>Load only when needed"]
        B3["Conditional Loading<br/>Filetype specific"]
    end
    
    subgraph "Runtime Optimization"
        C1["Tree-Sitter Folding<br/>Efficient parsing"]
        C2["Telescope FZF Native<br/>Fast searching"]
        C3["Blink.cmp Cache<br/>Fast completions"]
    end
    
    subgraph "Memory Management"
        D1["Plugin Isolation<br/>Minimal globals"]
        D2["Lazy Unloading<br/>Remove unused"]
        D3["Smart Parsing<br/>Incremental"]
    end
```

## Integration Points

```mermaid
graph LR
    subgraph "Neovim Core"
        NV["Neovim<br/>0.10+"]
    end
    
    subgraph "LSP Ecosystem"
        Mason["Mason<br/>Installer"]
        Servers["Language Servers<br/>bashls, lua_ls<br/>pyright, ts-tools"]
    end
    
    subgraph "AI Services"
        Copilot["GitHub Copilot<br/>Claude 3.7"]
    end
    
    subgraph "External Tools"
        Formatters["Formatters<br/>Stylua, Black<br/>Biome, Ruff"]
        Telescope["ripgrep<br/>FZF<br/>Git"]
    end
    
    NV --> Mason
    NV --> Copilot
    NV --> Formatters
    NV --> Telescope
    Mason --> Servers
```

## Summary

The Neovim configuration follows a **layered, modular architecture** with:

- **Clean separation**: Bootstrap → Core Config → Plugins → External Services
- **Lazy initialization**: Plugins load on-demand via Lazy.nvim
- **Modular organization**: Each plugin in its own file, grouped by category
- **Extension-friendly**: Easy to add new plugins or configuration
- **Performance-focused**: Lazy loading, conditional loading, efficient tools
- **Well-integrated**: LSP, Git, AI, and development tools seamlessly connected

This architecture enables maintainability, extensibility, and high performance in a complex configuration with 48+ managed plugins.
