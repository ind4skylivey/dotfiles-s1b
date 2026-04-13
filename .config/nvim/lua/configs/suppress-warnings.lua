-- Suppress all deprecation warnings globally
-- This runs before any plugins load

-- Save original notify
local original_notify = vim.notify

-- Override vim.notify to filter deprecation warnings
vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
    local lower = msg:lower()
    
    -- List of patterns to suppress
    local suppress_patterns = {
      "deprecat",
      "lspconfig",
      "framework",
      "typstfmt",
      "rustfmt",
      "rome",
      "biome",
      "feature will be removed",
      "use vim%.lsp%.config",
      "press enter",
    }
    
    -- Check if message matches any suppress pattern
    for _, pattern in ipairs(suppress_patterns) do
      if lower:match(pattern) then
        return -- Suppress this message
      end
    end
  end
  
  -- Call original notify for non-suppressed messages
  return original_notify(msg, level, opts)
end

-- Also suppress vim.deprecate calls
local original_deprecate = vim.deprecate or function() end
vim.deprecate = function(...)
  -- Silently ignore all deprecation warnings
  return
end

return {}
