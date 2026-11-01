local lint = require("lint")

lint.linters_by_ft = {
  lua = { "luacheck" },
  php = { "phpstan", "psalm" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  python = { "ruff" },
  bash = { "shellcheck" },
  markdown = { "markdownlint" },
}

-- Ejecutar linters al guardar
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
