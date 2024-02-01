local M = {
    'goolord/alpha-nvim',
	lazy = false,
	opts = function()
		local dashboard = require "alpha.themes.dashboard"
			dashboard.section.header.val = {
"________   _______   ________  ___      ___ ___  _____ ______      ",
"|\\   ___  \\|\\  ___ \\ |\\   __  \\|\\  \\    /  /|\\  \\|\\   _ \\  _   \\    ",
"\\ \\  \\\\ \\  \\ \\   __/|\\ \\  \\|\\  \\ \\  \\  /  / | \\  \\ \\  \\\\\\__\\ \\  \\   ",
" \\ \\  \\\\ \\  \\ \\  \\_|/_\\ \\  \\\\\\  \\ \\  \\/  / / \\ \\  \\ \\  \\\\|__| \\  \\  ",
"  \\ \\  \\\\ \\  \\ \\  \\_|\\ \\ \\  \\\\\\  \\ \\    / /   \\ \\  \\ \\  \\    \\ \\  \\ ",
"   \\ \\__\\\\ \\__\\ \\_______\\ \\_______\\ \\__/ /     \\ \\__\\ \\__\\    \\ \\__\\",
"    \\|__| \\|__|\\|_______|\\|_______|\\|__|/       \\|__|\\|__|     \\|__|",
"   ______            __        _          ________              ",
"  / ____/___ _____  / /_____ _(_)___     / ____/ /___ _____ ___ ",
" / /   / __ `/ __ \\/ __/ __ `/ / __ \\   / /_  / / __ `/ __ `__ \\",
"/ /___/ /_/ / /_/ / /_/ /_/ / / / / /  / __/ / / /_/ / / / / / /",
"\\____/\\__,_/ .___/\\__/\\__,_/_/_/ /_/  /_/   /_/\\__,_/_/ /_/ /_/ ",
"          /_/                                                   ",
			}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", "<cmd>ene <CR>"),
			-- dashboard.button("SPC f f", "󰈞  Find file"),
			-- dashboard.button("SPC f h", "󰊄  Recently opened files"),
			-- dashboard.button("SPC f r", "  Frecency/MRU"),
			-- dashboard.button("SPC f g", "󰈬  Find word"),
			-- dashboard.button("SPC f m", "  Jump to bookmarks"),
			-- dashboard.button("SPC s l", "  Open last session"),
		}
		dashboard.config.layout = {
			{ type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
			dashboard.section.header,
			{ type = "padding", val = 5 },
			dashboard.section.buttons,
			{ type = "padding", val = 3 },
			dashboard.section.footer,
		}
		dashboard.config.opts.noautocmd = true

		return dashboard.config
	  end,
}

return M
