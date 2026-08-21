-- Portable Neovim. Not the repo dump (.config/nvim with Valet/host paths).
-- Host extras: ~/.config/nvim/local.lua (copy modules/editor/local.lua.example).

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.undofile = true

local overlay = vim.fn.stdpath("config") .. "/local.lua"
if vim.fn.filereadable(overlay) == 1 then
  dofile(overlay)
end
