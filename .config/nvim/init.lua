-- Neovim entrypoint for NvChad-based personal config

-- Silence noisy deprecation notices as early as possible
pcall(require, "configs.suppress-warnings")

-- Redirect cache and shada inside the config directory to avoid sandbox permission issues
local cfg_dir = vim.fn.stdpath("config")
local cache_dir = cfg_dir .. "/.cache"
vim.env.XDG_CACHE_HOME = cache_dir
vim.fn.mkdir(cache_dir .. "/nvim/luac", "p")

-- Keep shada inside the config directory
local shada_dir = cfg_dir .. "/shada"
vim.fn.mkdir(shada_dir, "p")
vim.opt.shadafile = shada_dir .. "/main.shada"

-- Avoid writing compiled Lua cache outside the redirected cache path
pcall(function()
  vim.loader.disable()
end)

-- Leader keys must be set before any mappings load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Base46 uses this cache directory for compiled highlights
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

-- Bootstrap lazy.nvim if it is not installed yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specification and lazy.nvim options
require("lazy").setup({
  spec = {
    {
      "NvChad/NvChad",
      lazy = false,
      branch = "v2.5",
      import = "nvchad.plugins",
    },
    { import = "configs.lazy" },   -- Extra UI/productivity plugins
    { import = "plugins" },        -- Personal plugins and overrides
  },
  defaults = { lazy = false },     -- Load core immediately; events set inside specs
  install = { colorscheme = { "nvchad", "catppuccin" } },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Load compiled theme highlights (recommended by NvChad UI docs)
pcall(dofile, vim.g.base46_cache .. "defaults")
pcall(dofile, vim.g.base46_cache .. "statusline")

-- Core options, autocmds, and keymaps (with personal extensions)
require "options"
require "nvchad.autocmds"
require "mappings"
