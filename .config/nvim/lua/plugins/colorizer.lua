return {
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			filetypes = {
				"*",
				css = { css = true },
				scss = { css = true },
				sass = { css = true },
				html = { names = true },
			},
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = false,
				css_fn = true,
				mode = "background",
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
				virtualtext = "■",
				always_update = false,
			},
			buftypes = {},
		},
		config = function(_, opts)
			require("colorizer").setup(opts)

			-- Refresh colorizer on colorscheme change
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					require("colorizer").reload_all_buffers()
				end,
			})
		end,
	},
}
