
return {
  {
    -- Plugin: twilight.nvim
    -- URL: https://github.com/folke/twilight.nvim
    -- Description: Dims code outside the current context. We exclude UI buffers to avoid Blob errors.
    "folke/twilight.nvim",
    opts = {
      -- Disable treesitter-aware context: twilight.nvim 1.x crashes (view.lua:102, "attempt to index
      -- local 'parser' (a nil value)") on any buffer whose filetype has no treesitter parser, such as
      -- the noice/nui split at WinEnter. Line-based context (context = 10) still dims inactive code.
      treesitter = false,
      -- Skip UI/scratch buffers that are not real files; this prevents E976 "Using a Blob as a String"
      exclude = {
        "noice",
        "notify",
        "lazy",
        "mason",
        "qf",
        "help",
        "dashboard",
        "alpha",
        "snacks_input",
      },
    },
  },
}
