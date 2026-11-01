require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Mason shortcuts
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Open Mason" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Package Manager (Mason)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Tema s1b-neon: alternar noche/día
map("n", "<leader>tt", function() require("base46").toggle_theme() end, { desc = "Toggle s1b-neon dark/light" })
