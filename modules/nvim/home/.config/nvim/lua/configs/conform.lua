local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "php-cs-fixer", "phpactor" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    python = { "black" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    bash = { "shfmt" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },

  -- Formateo automático al guardar
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options