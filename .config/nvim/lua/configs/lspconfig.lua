-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Suppress ALL deprecation warnings and Mason deprecated tools
local notify = vim.notify
vim.notify = function(msg, level, ...)
  if type(msg) == "string" then
    local lower_msg = msg:lower()
    -- Block all deprecation messages
    if lower_msg:match("deprecat") or
       lower_msg:match("lspconfig") or
       lower_msg:match("typstfmt") or
       lower_msg:match("rustfmt") or
       lower_msg:match("rome") or
       lower_msg:match("biome") or
       lower_msg:match("framework") or
       lower_msg:match("feature will be removed") or
       lower_msg:match("use vim%.lsp%.config") then
      return
    end
  end
  notify(msg, level, ...)
end

-- Get lspconfig module (warning suppressed above)
local lspconfig = require "lspconfig"

-- Restore normal notifications
vim.notify = notify

-- Helper function for LSP setup
local function setup_lsp(server_name, config)
  config = config or {}
  config.on_attach = config.on_attach or nvlsp.on_attach
  config.on_init = config.on_init or nvlsp.on_init
  config.capabilities = config.capabilities or nvlsp.capabilities
  
  lspconfig[server_name].setup(config)
end

-- Basic servers with default config
local servers = { "html", "cssls", "bashls" }

for _, lsp in ipairs(servers) do
  setup_lsp(lsp)
end

-- PHP: PHPActor (refactoring + IntelliSense)
setup_lsp("phpactor", {
  init_options = {
    ["language_server_phpstan.enabled"] = true,
    ["language_server_psalm.enabled"] = false,
  },
})

-- Python: Pyright
setup_lsp("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Rust: rust-analyzer (managed by rustaceanvim plugin)
-- Configuration is in lua/plugins/rust.lua

-- C: clangd (for exploit development and malware analysis)
setup_lsp("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
})
