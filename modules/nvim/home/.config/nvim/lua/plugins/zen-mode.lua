return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>zz",
				"<cmd>ZenMode<CR>",
				desc = "Toggle Zen Mode",
			},
		},
		opts = {
			window = {
				backdrop = 0.95,
				width = 120,
				height = 1,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0",
					list = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
				twilight = { enabled = true },
				gitsigns = { enabled = false },
				tmux = { enabled = false },
				alacritty = {
					enabled = false,
					font = "14",
				},
			},
			on_open = function()
				vim.notify("🧘 Zen Mode activated - Focus time", vim.log.levels.INFO)
			end,
			on_close = function()
				vim.notify("👁️ Back to reality", vim.log.levels.INFO)
			end,
		},
	},
}
