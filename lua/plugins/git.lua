local M = {
	{
		'lewis6991/gitsigns.nvim',
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		keys = {
			{'<leader>ed', '<cmd>DiffviewOpen<cr>', desc = "Open Git Diff view"},
			{'<leader>cd', '<cmd>DiffviewClose<cr>', desc = "Close Git Diff view"},
		},
	}
}

return M
