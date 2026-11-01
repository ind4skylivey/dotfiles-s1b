return {
	{
		"Eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>fml",
				"<cmd>CellularAutomaton make_it_rain<CR>",
				desc = "Make it rain (Matrix effect)",
			},
			{
				"<leader>gol",
				"<cmd>CellularAutomaton game_of_life<CR>",
				desc = "Game of Life animation",
			},
		},
		config = function()
			-- Plugin loads automatically, no setup needed
			vim.notify("Matrix effects loaded! Use <leader>fml", vim.log.levels.INFO)
		end,
	},
}
