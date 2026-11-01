return {
  -- PHPActor LSP (complete refactoring support)
  {
    "phpactor/phpactor",
    build = "composer install --no-dev --optimize-autoloader",
    ft = "php",
  },
  {
    "gbprod/phpactor.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = "php",
    opts = {
      install = {
        path = vim.fn.stdpath("data") .. "/phpactor",
        branch = "master",
        bin = vim.fn.stdpath("data") .. "/phpactor/bin/phpactor",
      },
      lspconfig = {
        enabled = true,
        options = {},
      },
    },
  },

  -- Laravel.nvim (Laravel navigation and tools)
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related" },
      { "<leader>lc", ":Laravel make controller<cr>", desc = "Make Controller" },
      { "<leader>lmo", ":Laravel make model<cr>", desc = "Make Model" },
      { "<leader>lmi", ":Laravel make migration<cr>", desc = "Make Migration" },
    },
    opts = {
      lsp_server = "phpactor",
      features = {
        null_ls = { enable = false },
        route_info = { enable = true },
      },
    },
  },

  -- Blade syntax highlighting
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },

  -- Optional: Intelephense (alternative or complement to PHPActor)
  -- Requires premium license ($15) for advanced refactoring features
  -- Uncomment if you purchase the license:
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       intelephense = {
  --         settings = {
  --           intelephense = {
  --             stubs = {
  --               "apache", "bcmath", "bz2", "calendar", "com_dotnet",
  --               "Core", "ctype", "curl", "date", "dba", "dom",
  --               "exif", "fileinfo", "filter", "ftp", "gd", "gettext",
  --               "hash", "iconv", "imap", "intl", "json", "ldap",
  --               "libxml", "mbstring", "mcrypt", "mysqli", "oci8",
  --               "openssl", "pcntl", "pcre", "PDO", "pdo_mysql",
  --               "Phar", "posix", "pspell", "readline", "Reflection",
  --               "session", "shmop", "SimpleXML", "soap", "sockets",
  --               "sodium", "SPL", "sqlite3", "standard", "superglobals",
  --               "tokenizer", "xml", "xmlreader", "xmlwriter", "yaml",
  --               "zip", "zlib", "wordpress", "phpunit", "laravel"
  --             },
  --             licenceKey = vim.env.INTELEPHENSE_KEY,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
