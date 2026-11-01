local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

local nvlsp_ok, nvlsp = pcall(require, "nvchad.configs.lspconfig")
local defaults_ok = nvlsp_ok and type(nvlsp.defaults) == "function" and pcall(nvlsp.defaults)
if not defaults_ok then
  vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
  })
end

local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      },
    },
  },
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
  },
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
  },
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_markers = { ".git" },
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = { format = { enable = true } },
    },
  },
}

for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
  vim.lsp.enable(name)
  if vim.fn.executable(cfg.cmd[1]) == 0 then
    vim.notify("LSP '" .. name .. "' falta el binario. Mason lo instala al arrancar.", vim.log.levels.WARN)
  end
end
