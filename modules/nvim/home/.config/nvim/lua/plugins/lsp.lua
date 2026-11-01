-- Configuración de plugins para LSP y herramientas relacionadas
return {
  -- LSP y herramientas
  { "neovim/nvim-lspconfig", lazy = false },
  { "mason-org/mason.nvim", lazy = false },
  { "mason-org/mason-lspconfig.nvim", lazy = false },
  { "stevearc/conform.nvim", lazy = false },
  { "mfussenegger/nvim-lint", lazy = false },
  { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },

  -- Completado avanzado
  { "hrsh7th/nvim-cmp", lazy = false },
  { "hrsh7th/cmp-nvim-lsp", lazy = false },
  { "hrsh7th/cmp-buffer", lazy = false },
  { "hrsh7th/cmp-path", lazy = false },
  { "L3MON4D3/LuaSnip", lazy = false },
  { "saadparwaiz1/cmp_luasnip", lazy = false },
}