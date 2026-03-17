-- Custom Red Team Cyberpunk Lualine Configuration
local colors = {
  bg = "#0b1021",
  fg = "#c8d3f5",
  red = "#ff5c8d",
  orange = "#ff9e64",
  yellow = "#ffb86c",
  green = "#9ece6a",
  cyan = "#7aa2f7",
  blue = "#82aaff",
  purple = "#c792ea",
  magenta = "#ff007c",
  black = "#0c1222",
  gray = "#3b4261",
  dark_gray = "#1f2a44",
}

local red_team_theme = {
  normal = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.red },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.cyan, fg = colors.black, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.cyan },
  },
  visual = {
    a = { bg = colors.purple, fg = colors.black, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.purple },
  },
  replace = {
    a = { bg = colors.orange, fg = colors.black, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.orange },
  },
  command = {
    a = { bg = colors.green, fg = colors.black, gui = "bold" },
    b = { bg = colors.dark_gray, fg = colors.green },
  },
  inactive = {
    a = { bg = colors.black, fg = colors.gray },
    b = { bg = colors.black, fg = colors.gray },
    c = { bg = colors.black, fg = colors.gray },
  },
}

-- Custom Components

-- 1. File Size with Hacker Style
local function filesize()
  local file = vim.fn.expand("%:p")
  if file == nil or #file == 0 then return "" end
  local size = vim.fn.getfsize(file)
  if size <= 0 then return "" end
  local sufixes = { "b", "k", "m", "g" }
  local i = 1
  while size > 1024 do
    size = size / 1024
    i = i + 1
  end
  return string.format("[ %.1f%s ]", size, sufixes[i])
end

-- 2. Tech Clock
local function clock()
  return " " .. os.date("%H:%M:%S")
end

-- 3. Custom Progress Bar
local function progress_bar()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "░", "▒", "▓", "█" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

require("lualine").setup({
  options = {
    theme = red_team_theme,
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" }, -- Powerline hard dividers for tech look
    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icon = "", -- Skull icon
        fmt = function(str) return " " .. str .. " " end,
        separator = { right = "" },
      },
    },
    lualine_b = {
      {
        "branch",
        icon = "",
        color = { fg = colors.magenta, gui = "bold" },
        separator = { right = "" },
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        separator = { right = "" },
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
        symbols = {
          modified = " ⚡",      -- Lightning for modified
          readonly = " ",      -- Lock for readonly
          unnamed = " [No Name]",
        },
        color = { fg = colors.cyan, gui = "bold" },
      },
      {
        filesize,
        color = { fg = colors.gray },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
          hint = { fg = colors.green },
        },
      },
      {
        function() return "GPU: ON" end, -- Fake GPU status for hacker feel
        color = { fg = colors.green, gui = "bold" },
      },
    },
    lualine_y = {
      {
        "filetype",
        colored = true,
        icon_only = true,
        separator = { left = "" },
      },
      {
        "encoding",
        fmt = string.upper,
        color = { fg = colors.orange, gui = "bold" },
      },
    },
    lualine_z = {
      {
        clock,
        separator = { left = "" },
        color = { bg = colors.blue, fg = colors.black, gui = "bold" },
      },
      {
        "location",
        separator = { left = "" },
      },
      {
        "progress",
        fmt = function() return progress_bar() end,
        color = { fg = colors.black, bg = colors.green }, -- Green progress block
      },
    },
  },
  extensions = { "nvim-tree", "quickfix", "toggleterm" },
})
