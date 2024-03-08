local M = {
	"lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
	main = "ibl",
	opts = {
		-- indent = {
		-- 	char = "│",
		-- 	tab_char = "│",
		-- },
		-- scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"neo-tree",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
			},
		},
	}
}

return M
