# Treesitter Fix — Workaround for Neovim 0.12+

## The Bug

Since Neovim 0.12+, the `vim.treesitter.get_range()` function behavior changed:

**Before (Neovim < 0.12):**
```lua
vim.treesitter.get_range(node, metadata)  -- Returns: {start_row, start_col, end_row, end_col}
-- Type: table/list of 4 integers
```

**Now (Neovim >= 0.12):**
```lua
vim.treesitter.get_range(node, metadata)  -- Returns: {id = node, metadata = metadata}
-- Type: table with `id` and `metadata` fields (NOT the ranges)
```

This breaks many plugins that depend on the old behavior, such as:
- `nvim-treesitter` (for queries)
- Plugins using `get_range()` to get node positions

### Symptoms

- Error: `attempt to index a 'userdata' value`
- Error: `attempt to call method 'range' (a nil value)`
- Syntax highlighting partially or incorrectly on certain files
- Errors when opening markdown files with fenced code blocks

---

## The Workaround

The file `lua/plugins/treesitter-fix.lua` applies a patch that:

1. **Intercepts** `vim.treesitter.get_range` before any plugin uses it
2. **Handles nil nodes gracefully** - returns nil range instead of crashing
3. **Unwraps lists** when Neovim returns capture groups as lists
4. **Loads early** in the Neovim startup process to ensure availability for all plugins

### Patch Code

```lua
-- lua/plugins/treesitter-fix.lua
ts.get_range = function(node, metadata, ...)
    -- Handle nil node gracefully - return nil range instead of crashing
    if node == nil then
        return nil
    end

    -- Handle list of nodes (Neovim 0.12+ capture format)
    if type(node) == "table" and #node > 0 then
        node = node[1]
    end

    return orig_get_range(node, metadata, ...)
end
```

---

## How to Verify It's Working

### 1. Open a Markdown File with Code Blocks

```bash
nvim ~/.config/nvim/treesitter-fix-README.md
```

### 2. Check for Errors

- No errors in `:messages`
- No errors in `vim.NlspLog`
- Treesitter queries should execute without errors

### 3. Verify with a Test Script

```lua
-- Run in Neovim with :lua
local parser = vim.treesitter.get_parser(0, "markdown")
local tree = parser:parse()[1]
local root = tree:root()

-- If working, this should return a list of 4 numbers
local range = vim.treesitter.get_range(root)
print(vim.inspect(range))
-- Expected output: {0, 0, 10, 0} (or similar, 4 integers)
```

### 4. Check Error Logs

```bash
nvim --startuptime /tmp/nvim.log test.md 2>&1
grep -i "treesitter\|parser\|error" /tmp/nvim.log
```

---

## Note About nvim-treesitter

**The `nvim-treesitter/nvim-treesitter` plugin is ARCHIVED** (read-only, no active maintenance).

This happened on April 3, 2026. This workaround exists because the upstream fix will not be merged.

### Recommended Alternatives

| Alternative | Description |
|-------------|-------------|
| Community fork | Find a maintained fork of nvim-treesitter |
| Neovim 0.12+ built-ins | Use native `vim.treesitter.*` API |

### Commit Pinning Recommendation

To prevent updates that might break the configuration, **pin the specific commit** in `lazy-lock.json`:

```json
{
  "nvim-treesitter/nvim-treesitter": {
    "commit": "cf12346a3414fa1b06af75c79faebe7f76df080a"
  }
}
```

---

## Resources

- [Neovim 0.12 Release Notes](https://github.com/neovim/neovim/releases/tag/v0.12.0)
- [Treesitter API Changes Discussion](https://github.com/neovim/neovim/discussions/30919)
- [vim.treesitter API Documentation](https://neovim.io/doc/user/treesitter.html)

---

## Maintenance

This workaround is a temporary solution until plugins update for Neovim 0.12+.

If the bug is resolved upstream, consider:
1. Remove `treesitter-fix.lua`
2. Update affected plugins
3. Verify everything works without the patch
