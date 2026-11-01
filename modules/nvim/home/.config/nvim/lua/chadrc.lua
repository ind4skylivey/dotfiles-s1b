-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "s1b-neon-light",
	-- Espacio t t alterna noche/día. Los colores viven en lua/themes/s1b-neon*.lua
	theme_toggle = { "s1b-neon", "s1b-neon-light" },
	transparency = false,
}

M.nvdash = {
	load_on_startup = true,
	header = {
		"                                                    ",
		"  ██╗██╗      ██╗██╗   ██╗██████╗ ██╗   ██╗       ",
		"  ██║██║      ███║██║   ██║╚════██╗╚██╗ ██╔╝       ",
		"  ██║██║      ╚██║██║   ██║ █████╔╝ ╚████╔╝        ",
		"  ██║██║       ██║╚██╗ ██╔╝ ╚═══██╗  ╚██╔╝         ",
		"  ██║███████╗  ██║ ╚████╔╝ ██████╔╝   ██║          ",
		"  ╚═╝╚══════╝  ╚═╝  ╚═══╝  ╚═════╝    ╚═╝          ",
		"                                                    ",
		"           Red Team Ops                            ",
		"    S1BGr0up.inc | 0day | offensive / malware      ",
		"    > intrusion // persistence // exfiltrate // evade",
		"                                                    ",
	},
	buttons = {
		{ txt = "󰈞  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
		{ txt = "󰋚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
		{ txt = "󰱼  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
		{ txt = "󰃀  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
		{ txt = "󰏘  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
		{ txt = "󰌌  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
		{ txt = "  Terminal", keys = "Alt i", cmd = "ToggleTerm" },
		{ txt = "  Git Status", keys = "Spc g s", cmd = "Telescope git_status" },
		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " ms"
				return "⚡ " .. stats.loaded .. "/" .. stats.count .. " modules loaded in " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
		},
		{
			txt = "[ SYSTEM READY ] :: ACCESS GRANTED :: s1b@redteam",
			hl = "NvDashFooter",
			no_gap = true,
		},
		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	},
}

M.ui = {
	statusline = {
		theme = "vscode_colored",
		separator_style = "round",
	},
	tabufline = {
		enabled = true,
		lazyload = false,
		order = { "treeOffset", "buffers", "tabs", "btns" },
	},
	cmp = {
		icons_left = true,
		style = "atom_colored",
	},
	telescope = { style = "bordered" },
	nvdash = {
		load_on_startup = true,
	},
}

M.term = {
	winopts = { number = false, relativenumber = false },
	sizes = { sp = 0.3, vsp = 0.4, ["bo sp"] = 0.3, ["bo vsp"] = 0.4 },
	float = {
		relative = "editor",
		row = 0.15,
		col = 0.15,
		width = 0.7,
		height = 0.6,
		border = "rounded",
	},
}

M.cheatsheet = {
	theme = "grid",
	excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

return M
