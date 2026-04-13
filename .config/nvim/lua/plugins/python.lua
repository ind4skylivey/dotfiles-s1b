return {
  -- Pyright LSP (Python type checking and IntelliSense)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      }
    end,
  },

  -- Ruff (ultra-fast linting and formatting)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    cmd = { "VenvSelect", "VenvSelectCached" },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
    },
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select Python VirtualEnv" },
    },
  },

  -- Python debugging (DAP integration)
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
      
      -- Add custom configuration for Python scripts with arguments
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " ")
        end,
      })
    end,
    keys = {
      { "<leader>pr", function() require("dap-python").test_method() end, desc = "Run Python Test Method" },
      { "<leader>pc", function() require("dap-python").test_class() end, desc = "Run Python Test Class" },
    },
  },
}
