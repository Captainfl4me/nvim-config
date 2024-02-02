local M = {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	cmd = {
		"Telescope"
	},
	keys = {
		{'<leader>ff', '<cmd>Telescope find_files<cr>', desc = "Telescope find files" },
		{'<leader>fg', '<cmd>Telescope live_grep<cr>', desc = "Telescope grep files" },
		{'<leader>fb', '<cmd>Telescope buffers<cr>', desc = "Telescope navigate buffers" },
		{'<leader>fh', '<cmd>Telescope help_tags<cr>', desc = "Telescope navigate help" },
	},
}

return M
