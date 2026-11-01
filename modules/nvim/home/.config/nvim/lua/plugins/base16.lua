return { 'RRethy/base16-nvim',
  enabled = false, -- 2026-10-09: paleta matugen clara congelada chocaba con NvChad flouromachine
  config = function()
    local ok, matugen = pcall(require, 'matugen')
    if ok then matugen.setup() end
  end,
}
