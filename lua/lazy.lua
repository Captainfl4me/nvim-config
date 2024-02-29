local opts = {
	install = { colorscheme = { "kanagawa" } },
	defaults = { lazy = true },
	checker = { enabled = true, notify = false },
	debug = false,
	ui = { border = "rounded" },
	change_detection = {
		notify = false,
	},
	git = {
		timeout = 240, -- In seconds
	},
}

require("lazy").setup("plugins", opts)
