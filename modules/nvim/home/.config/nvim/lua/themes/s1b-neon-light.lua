-- s1b-neon-light: versión de día de s1b-neon (Belén, 2026-10-09)
-- v3: fondo rosado-lila, barra de estado lila, acentos magenta/violeta intensos.
local M = {}

M.base_30 = {
  white = "#2a2440",
  darker_black = "#efe1ef",
  black = "#f8eef6",
  black2 = "#f2e4f0",
  one_bg = "#ecdcec",
  one_bg2 = "#e4cfe6",
  one_bg3 = "#d9c0de",
  grey = "#b9aecb",
  grey_fg = "#9a90ae",
  grey_fg2 = "#8a80a0",
  light_grey = "#776d8f",
  red = "#e0175f",
  baby_pink = "#d4127a",
  pink = "#b8155f",
  line = "#e8d6ea",
  green = "#0f8f63",
  vibrant_green = "#0c7a54",
  nord_blue = "#3355c4",
  blue = "#2f5fd0",
  yellow = "#9a6400",
  sun = "#b07400",
  purple = "#7b2ff0",
  dark_purple = "#6630c0",
  teal = "#0b7f96",
  orange = "#c0520f",
  cyan = "#0a8aa8",
  statusline_bg = "#ecd4ea",
  lightbg = "#dfc2e2",
  pmenu_bg = "#d1245a",
  folder_bg = "#7a3fd6",
}

M.base_16 = {
  base00 = "#f8eef6", -- fondo
  base01 = "#f0e0ef",
  base02 = "#e6d2e8",
  base03 = "#9a90ae", -- comentarios
  base04 = "#776d8f",
  base05 = "#2a2440", -- texto
  base06 = "#1f1a33",
  base07 = "#140f24",
  base08 = "#2f5fd0", -- variables
  base09 = "#0f8f63", -- números / código inline
  base0A = "#9a6400", -- tipos
  base0B = "#a2269e", -- strings
  base0C = "#0b7f96", -- escapes / regex
  base0D = "#e0175f", -- funciones / títulos
  base0E = "#7b2ff0", -- keywords
  base0F = "#c0520f",
}

M.polish_hl = {
  defaults = {
    CursorLineNr = { fg = "#e0175f", bold = true },
    CursorLine = { bg = "#f6dcef" },
    LineNr = { fg = "#c3a9c9" },
    Visual = { bg = "#ead0f0" },
    Search = { bg = "#ffb3d1", fg = "#2a1a3a" },
    IncSearch = { bg = "#e0175f", fg = "#ffffff" },
    MatchParen = { bg = "#ead0f0", fg = "#d4127a", bold = true },
    FloatBorder = { fg = "#7b2ff0" },
    WinSeparator = { fg = "#e0175f" },
    -- v4: franjas pastel saturadas con texto oscuro del mismo tono (solo cuando render-markdown dibuja)
    RenderMarkdownH1Bg = { bg = "#ffd3e4" },
    RenderMarkdownH2Bg = { bg = "#e4d4ff" },
    RenderMarkdownH3Bg = { bg = "#ffe6b5" },
    RenderMarkdownH4Bg = { bg = "#c6eef6" },
    RenderMarkdownH5Bg = { bg = "#e4cfe6" },
    RenderMarkdownH6Bg = { bg = "#e4cfe6" },
    RenderMarkdownH1 = { fg = "#b80d4c", bold = true },
    RenderMarkdownH2 = { fg = "#5418c4", bold = true },
    RenderMarkdownH3 = { fg = "#7a4a00", bold = true },
    RenderMarkdownH4 = { fg = "#05596b", bold = true },
    RenderMarkdownCode = { bg = "#efdcf3" },
    RenderMarkdownCodeInline = { bg = "#d4f5e6", fg = "#06714d" },
    RenderMarkdownQuote = { fg = "#d4127a" },
    RenderMarkdownBullet = { fg = "#e0175f" },
    RenderMarkdownTableHead = { fg = "#7b2ff0", bold = true },
    RenderMarkdownTableRow = { fg = "#d9a6d6" },
    RenderMarkdownLink = { fg = "#0b7f96", underline = true },
    RenderMarkdownDash = { fg = "#e0175f" },
  },
  telescope = {
    TelescopeBorder = { fg = "#7b2ff0" },
    TelescopeTitle = { fg = "#ffffff", bg = "#e0175f", bold = true },
  },
  nvimtree = {
    NvimTreeOpenedFolderName = { fg = "#e0175f", bold = true },
  },
  treesitter = {
    ["@operator"] = { fg = M.base_30.pink },
    ["@punctuation.delimiter"] = { fg = M.base_30.light_grey },
    ["@punctuation.bracket"] = { fg = M.base_30.purple },
    ["@variable.parameter"] = { fg = M.base_30.orange },
    ["@comment"] = { fg = M.base_30.grey_fg, italic = true },
    ["@markup.raw"] = { fg = M.base_30.green },
    ["@markup.raw.markdown_inline"] = { fg = M.base_30.green },
    ["@markup.heading.1.markdown"] = { fg = "#b80d4c", bold = true },
    ["@markup.heading.2.markdown"] = { fg = "#5418c4", bold = true },
    ["@markup.heading.3.markdown"] = { fg = "#7a4a00", bold = true },
    ["@markup.heading.4.markdown"] = { fg = "#05596b", bold = true },
    ["@markup.strong"] = { fg = M.base_30.red, bold = true },
    ["@markup.italic"] = { fg = M.base_30.purple, italic = true },
    ["@markup.link.url"] = { fg = M.base_30.teal, underline = true },
    ["@markup.quote"] = { fg = M.base_30.baby_pink, italic = true },
  },
}

M.type = "light"

M = require("base46").override_theme(M, "s1b-neon-light")

return M
