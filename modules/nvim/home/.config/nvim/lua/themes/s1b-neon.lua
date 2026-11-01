-- s1b-neon: tema propio de Belén (S1BGr0uP), 2026-10-09
-- Base azul noche calmada, texto claro, acentos rojo/magenta y púrpura, código en menta.
local M = {}

M.base_30 = {
  white = "#d6dcf0",
  darker_black = "#090c15",
  black = "#0d111c",
  black2 = "#131826",
  one_bg = "#171d2d",
  one_bg2 = "#1e2538",
  one_bg3 = "#262e44",
  grey = "#3a4258",
  grey_fg = "#4a5370",
  grey_fg2 = "#58627f",
  light_grey = "#68728f",
  red = "#ff4f7b",
  baby_pink = "#ff6fae",
  pink = "#ff3d8b",
  line = "#1e2538",
  green = "#72f1b8",
  vibrant_green = "#8affc8",
  nord_blue = "#6b8cff",
  blue = "#7aa8ff",
  yellow = "#ffcc66",
  sun = "#ffd88a",
  purple = "#b48cff",
  dark_purple = "#9a6cf5",
  teal = "#5ccfe6",
  orange = "#ff9466",
  cyan = "#61e2ff",
  statusline_bg = "#111624",
  lightbg = "#1e2538",
  pmenu_bg = "#ff4f7b",
  folder_bg = "#b48cff",
}

M.base_16 = {
  base00 = "#0d111c", -- fondo
  base01 = "#171d2d",
  base02 = "#1e2538",
  base03 = "#4a5370", -- comentarios
  base04 = "#68728f",
  base05 = "#d6dcf0", -- texto
  base06 = "#e6ebfa",
  base07 = "#ffffff",
  base08 = "#8fc7ff", -- variables
  base09 = "#72f1b8", -- números / código inline
  base0A = "#ffcc66", -- tipos
  base0B = "#e0a8ff", -- strings
  base0C = "#5ccfe6", -- escapes / regex
  base0D = "#ff5c8a", -- funciones / títulos
  base0E = "#b48cff", -- keywords
  base0F = "#ff9466",
}

M.polish_hl = {
  defaults = {
    CursorLineNr = { fg = "#ff4f7b", bold = true },
    Visual = { bg = "#262e44" },
    Search = { bg = "#3a1f3a", fg = "#ff9ec4" },
    IncSearch = { bg = "#ff4f7b", fg = "#0d111c" },
    MatchParen = { bg = "#262e44", fg = "#ff6fae", bold = true },
    FloatBorder = { fg = "#9a6cf5" },
    WinSeparator = { fg = "#262e44" },
    RenderMarkdownH1Bg = { bg = "#2a1424" },
    RenderMarkdownH2Bg = { bg = "#21163a" },
    RenderMarkdownH3Bg = { bg = "#2a2416" },
    RenderMarkdownH4Bg = { bg = "#14262e" },
    RenderMarkdownH5Bg = { bg = "#171d2d" },
    RenderMarkdownH6Bg = { bg = "#171d2d" },
    RenderMarkdownCode = { bg = "#111624" },
    RenderMarkdownCodeInline = { bg = "#171d2d", fg = "#72f1b8" },
    RenderMarkdownQuote = { fg = "#9a6cf5" },
    RenderMarkdownTableHead = { fg = "#ff4f7b" },
    RenderMarkdownTableRow = { fg = "#58627f" },
  },
  telescope = {
    TelescopeBorder = { fg = "#9a6cf5" },
    TelescopeTitle = { fg = "#ff4f7b", bold = true },
  },
  nvimtree = {
    NvimTreeOpenedFolderName = { fg = "#ff4f7b", bold = true },
  },
  treesitter = {
    ["@operator"] = { fg = M.base_30.pink },
    ["@punctuation.delimiter"] = { fg = M.base_30.light_grey },
    ["@punctuation.bracket"] = { fg = M.base_30.purple },
    ["@variable.parameter"] = { fg = M.base_30.orange },
    ["@comment"] = { fg = M.base_30.grey_fg, italic = true },
    ["@markup.raw"] = { fg = M.base_30.green },
    ["@markup.raw.markdown_inline"] = { fg = M.base_30.green },
    ["@markup.heading.1.markdown"] = { fg = M.base_30.red, bold = true },
    ["@markup.heading.2.markdown"] = { fg = M.base_30.purple, bold = true },
    ["@markup.heading.3.markdown"] = { fg = M.base_30.yellow, bold = true },
    ["@markup.heading.4.markdown"] = { fg = M.base_30.teal, bold = true },
    ["@markup.strong"] = { fg = M.base_30.baby_pink, bold = true },
    ["@markup.italic"] = { fg = M.base_30.purple, italic = true },
    ["@markup.link.url"] = { fg = M.base_30.teal, underline = true },
    ["@markup.quote"] = { fg = M.base_30.light_grey, italic = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "s1b-neon")

return M
