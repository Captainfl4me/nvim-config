local opts = {
	install = { colorscheme = { "kanagawa" } },
	defaults = { lazy = true },
	checker = { enabled = true, notify = false },
	debug = false,
	ui = { border = "rounded" },
}

require("lazy").setup("plugins", opts)
