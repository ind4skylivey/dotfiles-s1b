 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#140022',
    base01 = '#20103a',
    base02 = '#8b5fd3',
    base03 = '#b06fe8',
    base04 = '#e6dbfa',
    base05 = '#f2e9ff',
    base06 = '#f2e9ff',
    base07 = '#f2e9ff',
    base08 = '#ff4d6d',
    base09 = '#ff2bd6',
    base0A = '#00d9ff',
    base0B = '#c926ff',
    base0C = '#99007b',
    base0D = '#730099',
    base0E = '#008299',
    base0F = '#00aecc',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2e9ff',          bg = '#140022' })
  hi('TelescopeBorder',         { fg = '#b06fe8',             bg = '#140022' })
  hi('TelescopePromptNormal',   { fg = '#f2e9ff',          bg = '#140022' })
  hi('TelescopePromptBorder',   { fg = '#b06fe8',             bg = '#140022' })
  hi('TelescopePromptPrefix',   { fg = '#c926ff',             bg = '#140022' })
  hi('TelescopePromptCounter',  { fg = '#e6dbfa',  bg = '#140022' })
  hi('TelescopePromptTitle',    { fg = '#140022',             bg = '#c926ff' })
  hi('TelescopePreviewTitle',   { fg = '#140022',             bg = '#00d9ff' })
  hi('TelescopeResultsTitle',   { fg = '#140022',             bg = '#ff2bd6' })
  hi('TelescopeSelection',      { fg = '#f2e9ff',          bg = '#8b5fd3' })
  hi('TelescopeSelectionCaret', { fg = '#c926ff',             bg = '#8b5fd3' })
  hi('TelescopeMatching',       { fg = '#c926ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2e9ff',          bg = '#140022' })
  hi('MiniPickBorder',         { fg = '#b06fe8',             bg = '#140022' })
  hi('MiniPickPrompt',   { fg = '#f2e9ff',          bg = '#140022' })
  hi('MiniPickPromptPrefix',   { fg = '#c926ff',             bg = '#140022' })
  hi('MiniPickBorderText',    { fg = '#140022',             bg = '#c926ff' })
  hi('MiniPickMatchCurrent',      { fg = '#f2e9ff',          bg = '#8b5fd3' })
  hi('MiniPickPromptCaret', { fg = '#c926ff',             bg = '#8b5fd3' })
  hi('MiniPickMatchRanges',       { fg = '#c926ff',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
