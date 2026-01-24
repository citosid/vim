# Neovim Native Migration - TDD Workflow

## Testing Framework

**Framework**: mini.test (part of mini.nvim)
**Run Tests**: `bim --headless -c "lua require('mini.test').run()"`

## Why mini.test?

1. **No external dependencies** - Part of mini.nvim which we're already using
2. **Native Neovim integration** - Tests run in actual Neovim environment
3. **Simple API** - Easy to write and understand tests
4. **Async support** - Can test async operations

## TDD Cycle for Each Step

### 1. RED Phase: Write Tests First

- Define expected behavior in `tests/<module>_spec.lua`
- Tests should fail initially (no implementation)
- Use `describe()` and `it()` blocks
- Assert expected values, functions, and behavior

### 2. GREEN Phase: Implement Minimum Code

- Write only enough code to make tests pass
- Don't over-engineer
- Focus on functionality, not perfection

### 3. REFACTOR Phase: Clean Up

- Improve code structure
- Remove duplication
- Ensure tests still pass

### 4. MANUAL TEST Phase: Human Verification ⚠️ BLOCKING GATE

**AI STOPS HERE - WAITS FOR HUMAN**

- You test in actual Neovim (`bim` command)
- You verify keybindings work
- You check LSP attaches correctly
- You confirm completion works
- **You provide approval/feedback**

### 5. UPDATE STATUS Phase (ONLY AFTER HUMAN APPROVAL)

**AI RESUMES ONLY AFTER HUMAN SAYS "APPROVED"**

- Mark step complete in `implementation/plan.md`
- Update test count
- Document any issues or learnings

### 6. COMMIT Phase (ONLY AFTER HUMAN APPROVAL)

- Commit tests, implementation, and documentation
- Use clear commit messages
- Reference step number and phase

## Test Structure

```lua
-- tests/example_spec.lua
local T = MiniTest.new_set()

T['Module'] = MiniTest.new_set()

T['Module']['should have expected property'] = function()
  local module = require('module_name')
  MiniTest.expect.equality(module.property, expected_value)
end

T['Module']['should call function correctly'] = function()
  local module = require('module_name')
  local result = module.some_function()
  MiniTest.expect.equality(result, expected_result)
end

return T
```

## Test File Organization

```
config/bim/tests/
├── init.lua              # Test runner setup
├── options_spec.lua      # Options tests
├── keymaps_spec.lua      # Keymap tests
├── lsp_spec.lua          # LSP configuration tests
├── completion_spec.lua   # Completion tests
├── plugins_spec.lua      # Plugin loading tests
└── helpers.lua           # Test utilities
```

## Running Tests

```bash
# Run all tests
bim --headless -c "lua require('tests').run_all()"

# Run specific test file
bim --headless -c "lua require('mini.test').run_file('tests/options_spec.lua')"

# Run with verbose output
bim --headless -c "lua require('mini.test').run({ collect = { emulate_busted = true } })"

# Run interactively (see results in Neovim)
bim -c "lua require('mini.test').run()"
```

## Assertions Available (mini.test)

```lua
MiniTest.expect.equality(a, b)           -- Deep equality
MiniTest.expect.no_equality(a, b)        -- Not equal
MiniTest.expect.error(f)                 -- Function throws error
MiniTest.expect.no_error(f)              -- Function doesn't throw
MiniTest.expect.reference_equality(a, b) -- Same reference
```

## Test Helpers

```lua
-- tests/helpers.lua
local H = {}

-- Mock vim.fn functions
function H.mock_fn(name, return_value)
  local original = vim.fn[name]
  vim.fn[name] = function() return return_value end
  return function() vim.fn[name] = original end
end

-- Create temporary buffer for testing
function H.create_test_buffer(filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'filetype', filetype)
  return buf
end

-- Wait for LSP to attach
function H.wait_for_lsp(bufnr, timeout)
  timeout = timeout or 5000
  local start = vim.loop.now()
  while vim.loop.now() - start < timeout do
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then return true end
    vim.wait(100)
  end
  return false
end

return H
```

## Workflow Summary

```
┌─────────────────────────────────────────────────────────────┐
│ Step N Implementation                                        │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 1. RED: AI writes failing tests                              │
│    → Commit: "test(step-N): add unit tests"                 │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. GREEN: AI implements code to pass tests                   │
│    → Commit: "feat(step-N): implement feature"              │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. REFACTOR: AI cleans up code                               │
│    → Commit: "refactor(step-N): improve code structure"     │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 4. MANUAL TEST: HUMAN TESTS IN NEOVIM (bim)                  │
│    ⚠️  AI STOPS AND WAITS HERE                              │
│    → Human: "APPROVED" or "FAILED: [issue]"                │
└─────────────────────────────────────────────────────────────┘
                            ↓
        ┌───────────────────┴───────────────────┐
        ↓                                       ↓
    APPROVED                              FAILED
        ↓                                       ↓
┌──────────────────┐              ┌──────────────────┐
│ 5. UPDATE STATUS │              │ Fix issues       │
│ 6. COMMIT        │              │ Re-test          │
│ → Ready for      │              │ Loop back        │
│   next step      │              └──────────────────┘
└──────────────────┘
```

## Manual Testing Checklist Template

For each step, AI will provide a checklist like:

```markdown
## Manual Testing - Step N

Please test the following in `bim`:

- [ ] Feature 1 works as expected
- [ ] Feature 2 works as expected
- [ ] No errors in `:messages`
- [ ] `:checkhealth` passes for relevant components

**Test commands:**
- `bim somefile.lua` - Open a Lua file
- `:LspInfo` - Check LSP status
- `<leader>ff` - Test file finder

**Reply with:**
- "APPROVED" - All tests pass, proceed to next step
- "FAILED: [description]" - Issue found, needs fixing
```

## Current Test Coverage

| Step | Tests | Status |
|------|-------|--------|
| 1. Colorschemes | 0 | Complete (manual) |
| 2. Plugins | 16 | Complete |
| 3. mini.icons | 6 | Complete |
| 4. mini.files | 12 | Complete |
| 5. Buffers/Pairs | 6 | Complete |
| 6. LSP | 10 | Complete |
| 7. Completion | 6 | Complete |
| 8. fzf-lua | 6 | Complete |
| 9. Formatters | 10 | Complete |
| 10. Comments | 4 | Complete |
| 11. Copilot | 5 | Complete |
| 12. Gitsigns | 6 | Complete |
| 13. Terminal | 8 | Complete |
| 14. UI | 7 | Complete |
| 15. Extras | 3 | Complete |
| 16. Final | 6 | Complete |

## Notes

- Tests run in headless mode for CI/automation
- Manual testing required for visual/interactive features
- Each step should have both unit tests and manual verification
- Keep tests focused and fast
