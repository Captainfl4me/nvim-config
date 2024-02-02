local M = {
	'akinsho/toggleterm.nvim',
	version = "*",
	cmd = {
		"ToggleTerm"
	},
	keys = {
		{'<leader>t', '<Cmd>exe v:count1 . \"ToggleTerm\"<CR>', desc = "Open specific terminal" },
	},
	opts = {},
}

return M
