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
		{'<leader>d', '<cmd>Telescope diagnostics<cr>', desc = "Telescope display diagnostic" },
		{'gd', '<cmd>Telescope lsp_definitions<cr>', desc = "Telescope goto definition(s)" },
		{'gi', '<cmd>Telescope lsp_implementations<cr>', desc = "Telescope goto implementation(s)" },
		{'gr', '<cmd>Telescope lsp_references<cr>', desc = "Telescope goto reference(s)" },
	},
}

return M
