-- Starship prompt in header, with flags after prompt to save space
pcall(function()
  require("starship"):setup({
    config_file = "$HOME/.config/starship.toml",
    hide_flags = true,
    flags_after_prompt = true,
  })
end)

-- Borders around panes for a cleaner layout
pcall(function()
  require("full-border"):setup({ type = ui.Border.ROUNDED })
end)
