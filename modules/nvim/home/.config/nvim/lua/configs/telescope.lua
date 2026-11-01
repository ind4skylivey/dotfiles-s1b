local options = {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "vendor",
      ".git",
      "dist",
      "build",
    },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = function()
        return { "--hidden", "--no-ignore" }
      end,
    },
  },
}

return options