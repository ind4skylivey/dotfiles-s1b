return {
  {
    "williamboman/mason.nvim",
    version = "1.11.0",
    opts = {
      ensure_installed = {
        -- PHP/Laravel
        "phpactor",
        "php-debug-adapter",
        
        -- Python
        "pyright",
        "ruff",
        "debugpy",
        
        -- Rust
        "rust-analyzer",
        "codelldb",
        
        -- Web
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        
        -- Shell
        "bash-language-server",
        "shellcheck",
        "shfmt",
        
        -- C/C++ (for exploits)
        "clangd",
        "clang-format",
        
        -- General
        "lua-language-server",
        "stylua",
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim", version = "1.32.0" },
}
