return {
  { "mason-org/mason.nvim", lazy = false },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "lua_ls", "bashls", "jsonls", "yamlls" },
    },
    config = function(_, opts)
      local mason_opts = {}
      local ok, nv_mason = pcall(require, "nvchad.configs.mason")
      if ok then
        mason_opts = nv_mason
      end
      require("mason").setup(mason_opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}
