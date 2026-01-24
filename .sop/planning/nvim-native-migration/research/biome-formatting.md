# Biome 2.x Formatting Research

## Problem

Biome 2.x LSP only advertises `documentOnTypeFormattingProvider`, not `documentFormattingProvider`.
This means native LSP format-on-save doesn't work.

## Solution (Working)

Use `biome check` via stdin with these args:

```lua
{
  "biome",
  "check",
  "--config-path=/Users/acruz/biome.json",
  "--write",
  "--unsafe",
  "--formatter-enabled=true",
  "--format-with-errors=true",
  "--stdin-file-path=" .. filename,
}
```

Key flags:
- `--write` — outputs formatted code to stdout when used with `--stdin-file-path`
- `--unsafe` — applies unsafe fixes
- `--format-with-errors=true` — format even if file has syntax errors

## Implementation

See `lua/formatters/biome.lua`

---

## Research Notes

```lua
{
  documentOnTypeFormattingProvider = {
    firstTriggerCharacter = "}",
    moreTriggerCharacter = { "]", ")" }
  },
  positionEncoding = "utf-8",
  textDocumentSync = { ... },
  workspace = { ... }
}
-- NOTE: No documentFormattingProvider!
```

## CLI Approaches Tested

### 1. `biome check --write` (File-based)

```lua
-- BufWritePost approach
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    vim.fn.system("biome check --write " .. vim.fn.shellescape(filepath))
    vim.cmd("edit!") -- or checktime
  end,
})
```

**Result:** File doesn't reload properly. Shows as externally modified.

### 2. `biome format --stdin-file-path` (Stdin-based)

```lua
-- Using vim.fn.system
local result = vim.fn.system("biome format --stdin-file-path=" .. filename, content)
```

**Result:** Adds weird text at top of file.

### 3. `biome format --stdin-file-path --colors=off` (Stdin with vim.system)

```lua
local result = vim.system({
  "biome",
  "format",
  "--stdin-file-path=" .. filename,
  "--colors=off",
}, { stdin = content, text = true }):wait()
```

**Result:** Does not format (needs investigation).

## What Works in config/vim (none-ls)

```lua
nls.builtins.formatting.biome.with({
  filetypes = { "javascript", "typescript", ... },
  args = {
    "check",
    "--config-path=/Users/acruz/biome.json",
    "--write",
    "--unsafe",
    "--formatter-enabled=true",
    "--stdin-file-path=$FILENAME",
  },
})
```

**Note:** This uses `--write` with `--stdin-file-path` which is contradictory.
none-ls likely handles this differently (maybe writes to temp file?).

## Potential Solutions to Investigate

### 1. Check if biome needs explicit config path

```bash
biome format --config-path=/Users/acruz/biome.json --stdin-file-path=test.ts --colors=off
```

### 2. Use conform.nvim

Lightweight formatter plugin that handles stdin/stdout properly.

### 3. Debug vim.system call

```lua
local result = vim.system({ "biome", "format", "--help" }, { text = true }):wait()
print(vim.inspect(result))
```

### 4. Check biome binary location

```bash
which biome
biome --version
```

### 5. Test biome CLI directly

```bash
echo "const x=1" | biome format --stdin-file-path=test.ts --colors=off
```

## References

- Biome docs: https://biomejs.dev/
- none-ls biome source: https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/formatting/biome.lua
- conform.nvim biome: https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/biome.lua
