

-- add yours here!

local o = vim.o

-- Keep shada inside the config folder to avoid sandbox permission issues
local shada_dir = vim.fn.stdpath("config") .. "/shada"
vim.fn.mkdir(shada_dir, "p")
o.shadafile = shada_dir .. "/main.shada"

-- o.cursorlineopt ='both' -- to enable cursorline!
